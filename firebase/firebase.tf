# Enable the required APIs
resource "google_project_service" "default" {
  provider = google-beta

  project = var.PROJECT_ID
  for_each = toset([
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "firebase.googleapis.com",
    "firebaserules.googleapis.com",
    "firestore.googleapis.com",
    "identitytoolkit.googleapis.com",
    "serviceusage.googleapis.com",
    "storage.googleapis.com"
  ])
  service = each.key

  disable_on_destroy = false
}

resource "google_firebase_project" "default" {
  provider = google-beta
  project  = var.PROJECT_ID

  depends_on = [
    google_project_service.default
  ]
}

resource "google_firestore_database" "default" {
  provider = google-beta

  project          = var.PROJECT_ID
  name             = var.PROJECT_ID
  location_id      = var.GOOGLE_REGION
  type             = "FIRESTORE_NATIVE"
  concurrency_mode = "OPTIMISTIC"

  depends_on = [
    google_firebase_project.default
  ]
}

resource "google_firebaserules_ruleset" "default-firestore" {
  provider = google-beta

  project = var.PROJECT_ID
  source {
    files {
      name    = "firestore.rules"
      content = file("firestore.rules")
    }
  }

  depends_on = [
    google_firestore_database.default
  ]
}

resource "google_firebaserules_release" "default-firestore" {
  provider = google-beta

  project      = var.PROJECT_ID
  name         = "cloud.firestore"
  ruleset_name = google_firebaserules_ruleset.default-firestore.name

  depends_on = [
    google_firestore_database.default
  ]
}

resource "google_firestore_index" "default" {
  provider = google-beta

  project     = var.PROJECT_ID
  collection  = "Events"
  query_scope = "COLLECTION"

  fields {
    field_path = "modifiedAt"
    order      = "DESCENDING"
  }

  fields {
    field_path = "createdAt"
    order      = "DESCENDING"
  }

  depends_on = [
    google_firestore_database.default
  ]
}

resource "google_identity_platform_config" "default" {
  provider = google-beta
  project  = var.PROJECT_ID

  autodelete_anonymous_users = true

  depends_on = [
    google_firebase_project.default
  ]
}

resource "google_identity_platform_project_default_config" "default" {
  provider = google-beta

  project = var.PROJECT_ID

  sign_in {
    allow_duplicate_emails = false

    anonymous {
      enabled = false
    }

    email {
      enabled           = true
      password_required = true
    }
  }

  depends_on = [
    google_identity_platform_config.default
  ]
}

resource "google_app_engine_application" "default" {
  provider = google-beta

  project     = var.PROJECT_ID
  location_id = var.GOOGLE_REGION

  # Provisioning Cloud Storage AFTER Cloud Firestore
  # will ensure Firestore is provisioned in Native mode.
  depends_on = [
    google_firestore_database.default
  ]
}

module "primary_google_storage_bucket" {
  source                    = "./google-firebase-storage/primary"
  GOOGLE_PROJECT_ID         = var.PROJECT_ID
  GOOGLE_REGION             = var.GOOGLE_REGION
  PRIMARY_STORAGE_BUCKET_ID = google_app_engine_application.default.default_bucket
}

module "secondary_google_storage_bucket" {
  source            = "./google-firebase-storage/multi-secondary"
  count             = length(var.SECONDARY_STORAGE_BUCKET_ID) > 0 ? 1 : 0
  GOOGLE_PROJECT_ID = var.PROJECT_ID
  GOOGLE_REGION     = var.GOOGLE_REGION
}

resource "google_firebaserules_ruleset" "default-storage" {
  provider = google-beta

  project = var.PROJECT_ID
  source {
    files {
      name    = "storage.rules"
      content = file("storage.rules")
    }
  }

  depends_on = [
    google_firebase_project.default
  ]
}

resource "google_firebase_web_app" "default" {
  provider = google-beta

  project      = var.PROJECT_ID
  display_name = var.PROJECT_ID

  deletion_policy = "DELETE"

  depends_on = [
    google_firebase_project.default,
  ]
}

resource "google_firebase_hosting_site" "preview" {
  provider = google-beta

  project = google_firebase_project.default.project
  app_id  = google_firebase_web_app.default.app_id
  site_id = "${google_firebase_project.default.project}-preview"
}

resource "google_firebase_hosting_channel" "default" {
  provider = google-beta

  site_id    = google_firebase_hosting_site.preview.site_id
  channel_id = "preview"
}