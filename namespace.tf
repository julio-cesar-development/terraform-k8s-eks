resource "kubernetes_namespace" "ingress-nginx-namespace" {
  metadata {
    name = "ingress-nginx"
  }

  depends_on = [null_resource.wait_cluster]
}

resource "kubernetes_namespace" "cert-manager-namespace" {
  metadata {
    name = "cert-manager"

    labels = {
      "certmanager.k8s.io/disable-validation" = "true"
    }
  }

  depends_on = [null_resource.wait_cluster]
}
