terraform {
  required_providers {
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

provider "kustomization" {
  kubeconfig_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
