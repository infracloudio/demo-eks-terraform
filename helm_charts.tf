resource "kubernetes_namespace" "cluster-autoscaler" {
  metadata {
    name = "cluster-autoscaler"
  }
}

resource "kubernetes_namespace" "metric-server" {
  metadata {
    name = "metric-server"
  }
}

resource "helm_release" "demo-eks-cluster-autoscaler" {
  name       = "demo-eks-cluster-autoscaler"
  repository = "https://kubernetes-charts.storage.googleapis.com/"
  chart      = "cluster-autoscaler"
  namespace = "cluster-autoscaler"

  set {
    name  = "autoscalingGroups[0].name"
    value = aws_eks_node_group.demo_eks_node_group.resources[0].autoscaling_groups[0].name
  }

  set {
    name  = "autoscalingGroups[0].maxSize"
    value = 3
  }

  set {
    name  = "autoscalingGroups[0].minSize"
    value = 1
  }

  depends_on = [
    kubernetes_namespace.cluster-autoscaler
  ]
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