resource "kubernetes_namespace" "registry" {
  metadata {
    name = "registry"

    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
      "pod-security.kubernetes.io/audit"   = "privileged"
      "pod-security.kuberentes.io/warn"    = "privileged"
    }
  }
}

