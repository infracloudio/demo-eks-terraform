resource "kubernetes_namespace" "metric-server" {
  metadata {
    name = "metric-server"
  }
}


resource "helm_release" "demo-eks-metric-server" {
  name       = "demo-eks-metric-server"
  repository = "https://kubernetes-charts.storage.googleapis.com/"
  chart      = "metrics-server"
  namespace = "metric-server"

  depends_on = [
    kubernetes_namespace.metric-server
  ]
}