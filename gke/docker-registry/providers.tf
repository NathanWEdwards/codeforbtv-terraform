terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    kustomization = {
      source = "kbst/kustomization"
    }

    tls = {
      source = "hashicorp/tls"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "kustomization" {
  kubeconfig_path = "~/.kube/config"
}
