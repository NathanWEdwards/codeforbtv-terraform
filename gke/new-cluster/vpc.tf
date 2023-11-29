resource "google_compute_subnetwork" "jupyterhub_internal" {
  project       = var.PROJECT_ID
  name          = "jupyterhub-internal"
  ip_cidr_range = "10.3.0.0/16"
  region        = var.REGION
  network       = data.google_compute_network.jupyterhub_vpc_network.self_link
}

resource "google_compute_subnetwork" "jupyterhub_gke" {
  project       = var.PROJECT_ID
  name          = "jupyterhub-gke"
  ip_cidr_range = "10.1.0.0/16"
  region        = var.REGION
  network       = data.google_compute_network.jupyterhub_vpc_network.self_link

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.2.127.0/28"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "10.2.0.0/20"
  }
}
