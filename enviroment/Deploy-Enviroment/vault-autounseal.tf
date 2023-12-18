
resource "kubernetes_namespace" "ns-vault-autounseal" {
  metadata {
    annotations = {
      name = "vault-autounseal"
    }

    name = "vault-autounseal"
  }
}

resource "kubernetes_secret" "vault_licence_autounseal" {
  metadata {
    name      = "hashicorp-vault-license-dr"
    namespace = "vault-autounseal"
  }
  type = "Opaque"

  data = {
    "license.hclic" = var.vault-license
  }
}


resource "kubernetes_secret" "vault_certs_autounseal" {
  depends_on = [kubernetes_namespace.ns-vault-autounseal]
  metadata {
    name      = "vault-ha-tls"
    namespace = "vault-autounseal"
  }
  type = "Opaque"

  data = {
    "vault.key" = tls_private_key.vault.private_key_pem
    "vault.crt" = tls_self_signed_cert.vault.cert_pem
    "vault.ca"  = tls_self_signed_cert.vault.cert_pem
  }

}
