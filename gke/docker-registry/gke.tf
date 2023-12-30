resource "kustomization_resource" "registry" {
  for_each = data.kustomization_overlay.registry.ids
  manifest = data.kustomization_overlay.registry.manifests[each.value]

  depends_on = [
    kubernetes_config_map.containerd_config,
    kubernetes_secret.registry_certificate
  ]
}
