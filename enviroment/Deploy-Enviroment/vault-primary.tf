
resource "kubernetes_namespace" "ns-vault-primary" {
  metadata {
    annotations = {
      name = "vault-primary"
    }

    name = "vault-primary"
  }
}

resource "kubernetes_secret" "vault_licence" {
  metadata {
    name      = "hashicorp-vault-license-primary"
    namespace = "vault-primary"
  }
  type = "Opaque"

  data = {
    "license.hclic" = var.vault-license
  }
}

resource "tls_private_key" "vault" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "vault" {
  private_key_pem = tls_private_key.vault.private_key_pem

  subject {
    common_name  = "TestOrg"
    organization = "Devops"
  }

  // 10 weeks
  validity_period_hours = 1680

  ip_addresses = ["127.0.0.1"]
  dns_names    = ["localhost", "vault", "vault-primary-active", "vault-primary", "vault-primary-internal", "vault-primary-standby", "vault-primary.vault-boost.lab", "vault-dr-active", "vault-dr", "vault-dr-internal", "vault-dr-standby", "vault-dr.vault-boost.lab", "vault-primary-active.vault-primary.svc.cluster.local", "vault-dr-active.vault-dr.svc.cluster.local", "vault-cluster-api-dr.vault-dr.svc.cluster.local", "vault-cluster-api-primary.vault-primary.svc.cluster.local", "vault-autounseal-active", "vault-autounseal", "vault-autounseal-internal", "vault-autounseal-standby", "vault-autounseal.vault-boost.lab", "vault-autounseal-active.vault-autounseal.svc.cluster.local", "vault-cluster-api-dr.vault-autounseal.svc.cluster.local"]

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "data_encipherment"
  ]
}


resource "kubernetes_secret" "vault_certs" {
  depends_on = [kubernetes_namespace.ns-vault-primary]
  metadata {
    name      = "vault-ha-tls"
    namespace = "vault-primary"
  }
  type = "Opaque"

  data = {
    "vault.key" = tls_private_key.vault.private_key_pem
    "vault.crt" = tls_self_signed_cert.vault.cert_pem
    "vault.ca"  = tls_self_signed_cert.vault.cert_pem
  }

}
