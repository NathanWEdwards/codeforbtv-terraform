resource "kubernetes_config_map" "containerd_config" {
  metadata {
    name      = "containerd-config"
    namespace = kubernetes_namespace.registry.id
  }

  immutable = true

  data = {
    "config.toml" = "${file("containerd-config.toml")}"
  }
}
