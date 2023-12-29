resource "google_container_cluster" "default" {
  project  = var.PROJECT_ID
  name     = "${var.PROJECT_ID}-gke"
  location = var.LOCATION

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = data.google_compute_network.default_vpc_network.self_link
  subnetwork = google_compute_subnetwork.default_gke.self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-ranges"
    services_secondary_range_name = google_compute_subnetwork.default_gke.secondary_ip_range.0.range_name
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }
  }

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${self.name} --location ${self.location}"
  }

  deletion_protection = false
}

resource "google_container_node_pool" "default_nodes" {
  project  = var.PROJECT_ID
  name     = google_container_cluster.default.name
  location = var.LOCATION
  cluster  = google_container_cluster.default.name

  version    = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.GKE_NUM_NODES

  node_config {
    service_account = data.google_service_account.default_service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
    machine_type = "e2-medium"
    tags         = ["gke-node", "${var.PROJECT_ID}-gke"]
  }

  lifecycle {
    ignore_changes = [node_config]
  }
}
