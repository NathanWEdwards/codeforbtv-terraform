data "google_service_account" "default_service_account" {
  project    = var.PROJECT_ID
  account_id = var.SERVICE_ACCOUNT_ID
}

data "google_service_account_access_token" "default_kubernetes" {
  target_service_account = var.DEFAULT_SERVICE_ACCOUNT_EMAIL
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "1800s"
}

data "google_compute_network" "default_vpc_network" {
  project = var.PROJECT_ID
  name    = var.DEFAULT_VPC_NETWORK_NAME
}

data "google_container_engine_versions" "gke_version" {
  project        = var.PROJECT_ID
  location       = var.LOCATION
  version_prefix = "1.27."
}
