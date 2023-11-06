variable "GOOGLE_REGION" {
  type = string
}

variable "GOOGLE_PROJECT_ID" {
  type = string
}

variable "SECONDARY_STORAGE_BUCKET_ID" {
    description = "The name of a second firebase storage bucket resource."
    type = string
    default = "secondary"
}