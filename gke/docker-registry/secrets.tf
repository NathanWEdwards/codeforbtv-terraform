resource "tls_private_key" "ed25519" {
  algorithm = "ED25519"
}

resource "tls_self_signed_cert" "cert" {
  private_key_pem = tls_private_key.ed25519.private_key_pem

  subject {
    common_name  = "docker.registry.svc.cluster.local"
    organization = "none"
  }

  validity_period_hours = 30

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth"
  ]
}

resource "kubernetes_secret" "registry_certificate" {

  metadata {
    name      = "registry-certificates"
    namespace = kubernetes_namespace.registry.id
  }

  type = "Opaque"

  data = {
    "cert.crt" = tls_self_signed_cert.cert.cert_pem
  }
}
