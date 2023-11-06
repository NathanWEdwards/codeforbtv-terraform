variable "SECONDARY_STORAGE_BUCKET_ID" {
  description = "(Optional) When the ID of a secondary bucket is supplied, one additional firebase storage bucket is provisioned."
  type        = string
}

variable "GOOGLE_REGION" {
  type = string
}

variable "PROJECT_ID" {
  type = string
}