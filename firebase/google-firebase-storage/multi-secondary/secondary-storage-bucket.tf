resource "google_storage_bucket" "secondary_bucket" {
  # Exclude this resource from being provisioned if `should_provision` evaluates to false.
  provider = google-beta

  name = var.SECONDARY_STORAGE_BUCKET_ID
  project  = var.GOOGLE_PROJECT_ID
  force_destroy = true
  location = var.GOOGLE_REGION
}

resource "google_firebase_storage_bucket" "secondary_bucket" {
  # Exclude this resource from being provisioned if `should_provision` evaluates to false.
  provider = google-beta

  project   = var.GOOGLE_PROJECT_ID
  bucket_id = var.SECONDARY_STORAGE_BUCKET_ID
}