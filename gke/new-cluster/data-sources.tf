data "google_service_account" "jupyterhub_service_account" {
  project    = var.PROJECT_ID
  account_id = var.SERVICE_ACCOUNT_ID
}

data "google_service_account_access_token" "jupyterhub_kubernetes" {
  target_service_account = var.JUPYTERHUB_SERVICE_ACCOUNT_EMAIL
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "1800s"
}

data "google_compute_network" "jupyterhub_vpc_network" {
  project = var.PROJECT_ID
  name    = var.JUPYTERHUB_VPC_NETWORK_NAME
}

data "google_container_engine_versions" "gke_version" {
  project        = var.PROJECT_ID
  location       = var.LOCATION
  version_prefix = "1.27."
}
