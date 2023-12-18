resource "kubernetes_namespace" "cert-manager-demo" {
  metadata {
    annotations = {
      name = "cert-manager-demo"
    }

    name = "cert-manager-demo"
  }
}

resource "kubernetes_namespace" "infra-argocd" {
  metadata {
    annotations = {
      name = "infra-argocd"
    }

    name = "infra-argocd"
  }
}