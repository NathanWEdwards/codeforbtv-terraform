terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
    }

    helm = {
      source = "hashicorp/helm"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    kustomization = {
      source = "kbst/kustomization"
    }
  }
}

provider "google-beta" {
  credentials           = file("~/.goog/cluster.json")
  user_project_override = false
  project               = var.PROJECT_ID
  region                = var.LOCATION
}

provider "kubernetes" {
  load_config_file = "false"

  host                   = "https://${google_container_cluster.jupyterhub.endpoint}"
  token                  = data.google_service_account_access_token.jupyterhub.access_token
  client_certificate     = google_container_cluster.jupyterhub.master_auth.0.client_certificate
  client_key             = google_container_cluster.jupyterhub.master_auth.0.client_key
  cluster_ca_certificate = base64decode(google_container_cluster.jupyterhub.master_auth.0.cluster_ca_certificate)
}
