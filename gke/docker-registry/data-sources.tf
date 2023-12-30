data "kustomization_overlay" "registry" {
  common_labels = {
    app = "registry"
  }

  resources = [
    "manifests/overlays/${terraform.workspace}/"
  ]

  kustomize_options {
    load_restrictor = "none"
  }
}
