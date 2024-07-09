locals {
  tr_nr_02 = "02"
}

resource "kubernetes_namespace" "vault_tr_02" {
  metadata {
    annotations = {
      name = "vault-tr-${local.tr_nr_02}"
    }

    name = "vault-tr-${local.tr_nr_02}"
  }
}


resource "tls_private_key" "vault_tr_02" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "vault_tr_02" {
  private_key_pem = tls_private_key.vault.private_key_pem

  subject {
    common_name  = "vault-tr-02.vault-boost.lab"
    organization = "vault-boost.lab"
  }

  // 10 weeks
  validity_period_hours = 1680

  ip_addresses = ["127.0.0.1"]
  dns_names    = ["localhost", "vault", "vault-tr-${local.tr_nr_02}-active", "vault-tr-${local.tr_nr_02}", "vault-tr-${local.tr_nr_02}-internal", "vault-tr-${local.tr_nr_02}-standby", "vault-tr-${local.tr_nr_02}.vault-boost.lab", "vault-tr-${local.tr_nr_02}-active.vault-tr-${local.tr_nr_02}.svc.cluster.local"]


  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "data_encipherment"
  ]
}


resource "kubernetes_secret" "vault_certs_tr_02" {
  depends_on = [kubernetes_namespace.vault_tr_02]
  metadata {
    name      = "vault-ha-tls"
    namespace = "vault-tr-${local.tr_nr_02}"
  }
  type = "Opaque"

  data = {
    "vault-playground-cert.key" = tls_private_key.vault.private_key_pem
    "vault-playground-cert.crt" = tls_self_signed_cert.vault.cert_pem
    "vault-playground-cert.ca"  = tls_self_signed_cert.vault.cert_pem
  }

}



resource "kubernetes_secret" "vault_licence_tr_02" {
  depends_on = [kubernetes_namespace.vault_tr_02]

  metadata {
    name      = "hashicorp-vault-license"
    namespace = "vault-tr-${local.tr_nr_02}"
  }
  type = "Opaque"

  data = {
    "license.hclic" = var.vault-license
  }
}



resource "helm_release" "vault_tr_02" {
  name       = "vault-tr-${local.tr_nr_02}"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  # version    = var.vault_helm_chart_version
  namespace = "vault-tr-${local.tr_nr_02}"
  wait      = false

  values = [
    "${templatefile("./values/vault-values.yaml", {})}"
  ]

  depends_on = [
    kubernetes_namespace.vault_tr_02,
    kubernetes_secret.vault_certs_tr_02,
    kubernetes_secret.vault_licence_tr_02,
  ]
}

resource "time_sleep" "vault-sleep_tr_02" {
  depends_on = [helm_release.vault_tr_02]

  create_duration = "30s"
}


resource "kubernetes_ingress_v1" "vault-ingress_tr_02" {
  depends_on = [time_sleep.vault-sleep_tr_02]
  metadata {
    name      = "vault-ingress-tr-${local.tr_nr_02}"
    namespace = "vault-tr-${local.tr_nr_02}"
    annotations = {
      "nginx.ingress.kubernetes.io/ssl-passthrough"    = "true"
      "kubernetes.io/ingress.class"                    = "nginx"
      "nginx.ingress.kubernetes.io/backend-protocol"   = "https"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
    }
  }
  spec {
    rule {
      host = "vault-tr-${local.tr_nr_02}.vault-boost.lab"
      http {
        path {
          path_type = "Prefix"
          path      = "/"
          backend {
            service {
              name = "vault-tr-${local.tr_nr_02}-active"
              port {
                number = 8200
              }
            }
          }
        }
      }
    }
  }
}
