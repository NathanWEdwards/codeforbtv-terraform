variable "GOOGLE_REGION" {
  type = string
}

variable "GOOGLE_PROJECT_ID" {
  type = string
}

variable "PRIMARY_STORAGE_BUCKET_ID" {
    description = "Storage bucket id supplied from the google_app_engine_application resource."
    type = string
}