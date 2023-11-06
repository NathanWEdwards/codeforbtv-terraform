resource "google_firebase_storage_bucket" "primary_bucket" {
  provider = google-beta

  project   = var.GOOGLE_PROJECT_ID
  bucket_id = var.PRIMARY_STORAGE_BUCKET_ID
}

