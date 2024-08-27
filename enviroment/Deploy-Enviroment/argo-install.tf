

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6"
  namespace  = kubernetes_namespace.infra-argocd.metadata[0].name
  wait       = false



  depends_on = [
    kubernetes_namespace.infra-argocd,
  ]
}


resource "time_sleep" "argo-sleep" {
  depends_on = [helm_release.argocd]

  create_duration = "30s"
}

resource "null_resource" "argo-init" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "./init-argo.sh"
  }

  depends_on = [time_sleep.argo-sleep]
}