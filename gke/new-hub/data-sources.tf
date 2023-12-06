data "kustomization_overlay" "primary" {
  name_prefix = "jupyterhub-"
  namespace   = "jupyterhub"

  common_labels = {
    app = "jupyterhub"
  }

  resources = [
    "manifests/overlays/${terraform.workspace}/"
  ]

  kustomize_options {
    load_restrictor = "none"
  }
}
