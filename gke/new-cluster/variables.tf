variable "GKE_NUM_NODES" {
  type    = number
  default = 1
}

variable "DEFAULT_SERVICE_ACCOUNT_EMAIL" {
  type      = string
  sensitive = true
}

variable "DEFAULT_VPC_NETWORK_NAME" {
  type    = string
  default = "cluster"
}

variable "LOCATION" {
  type    = string
  default = "us-east1-b"
}

variable "PROJECT_ID" {
  type = string
}

variable "SERVICE_ACCOUNT_ID" {
  type      = string
  sensitive = true
}

variable "REGION" {
  type    = string
  default = "us-east1"
}
