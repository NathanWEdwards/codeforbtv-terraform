resource "helm_release" "jupyterhub" {
  name       = "jupyterhub"
  repository = "https://hub.jupyter.org/helm-chart/"
  chart      = "jupyterhub"
  version    = "3.2.1"

  values = [
    "${file("manifests/bases/app/jhub-values.yaml")}"
  ]

  depends_on = [kustomization_resource.ingress_nginx]
}

resource "kustomization_resource" "primary" {
  for_each = data.kustomization_overlay.primary.ids
  manifest = data.kustomization_overlay.primary.manifests[each.value]

  depends_on = [kustomization_resource.ingress_nginx]
}

resource "kustomization_resource" "ingress_nginx" {
  for_each = data.kustomization_overlay.ingress_nginx.ids
  manifest = data.kustomization_overlay.ingress_nginx.manifests[each.value]
}
