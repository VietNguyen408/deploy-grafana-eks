provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "grafana" {
  name       = "my-grafana-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "grafana"
  # namespace = "viet"
  values = [
    file("${path.module}/grafana-values.yaml")
  ]
}