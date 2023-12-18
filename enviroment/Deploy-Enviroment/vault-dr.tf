
resource "kubernetes_namespace" "ns-vault-dr" {
  metadata {
    annotations = {
      name = "vault-dr"
    }

    name = "vault-dr"
  }
}

resource "kubernetes_secret" "vault_licence_dr" {
  metadata {
    name      = "hashicorp-vault-license-dr"
    namespace = "vault-dr"
  }
  type = "Opaque"

  data = {
    "license.hclic" = var.vault-license
  }
}


resource "kubernetes_secret" "vault_certs_dr" {
  depends_on = [kubernetes_namespace.ns-vault-dr]
  metadata {
    name      = "vault-ha-tls"
    namespace = "vault-dr"
  }
  type = "Opaque"

  data = {
    "vault.key" = tls_private_key.vault.private_key_pem
    "vault.crt" = tls_self_signed_cert.vault.cert_pem
    "vault.ca"  = tls_self_signed_cert.vault.cert_pem
  }

}
