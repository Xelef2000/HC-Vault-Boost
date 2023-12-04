

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6"
  namespace = kubernetes_namespace.infra-argocd.metadata[0].name
  wait      = false



  depends_on = [
    kubernetes_namespace.infra-argocd,
  ]
}


resource "time_sleep" "argo-sleep" {
  depends_on = [helm_release.argocd]

  create_duration = "30s"
}

resource "null_resource" "argo_gitops" {
  depends_on = [time_sleep.argo-sleep]
  
  provisioner "local-exec" {
    command = ""
  }
}


# resource "helm_release" "vault" {
#   name       = "vault"
#   repository = "https://helm.releases.hashicorp.com"
#   chart      = "vault"
#   # version    = var.vault_helm_chart_version
#   namespace = kubernetes_namespace.vault.metadata[0].name
#   wait      = false

#   values = [
#     "${templatefile("./values/vault-values.yaml", {})}"
#   ]

#   depends_on = [
#     kubernetes_namespace.playground-namespace,
#     kubernetes_secret.vault_certs,
#     kubernetes_secret.vault_licence,
#     kubernetes_secret.prometheus-monitoring-token,
#     helm_release.prometheus-grafana,

#   ]
# }





