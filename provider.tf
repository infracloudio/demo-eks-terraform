# Provider configuration
# Note: Change the region name as per requirement

provider "aws" {
 region  = "ap-south-1"  
}

data "aws_eks_cluster_auth" "cluster-auth" {
  depends_on = [aws_eks_cluster.demo-eks-cluster]
  name       = aws_eks_cluster.demo-eks-cluster.name
}

provider "helm" {
kubernetes {
    host                   = aws_eks_cluster.demo-eks-cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.demo-eks-cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster-auth.token
    load_config_file       = false
  }
}

provider "kubernetes" {
    host                   = aws_eks_cluster.demo-eks-cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.demo-eks-cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster-auth.token
    load_config_file       = false
}

# This block is responsible for storing terraform state file in S3
terraform {
  backend "s3" {
    bucket = "eks-test-rahulkadam"
    key    = "demo1/terraform.tfstate"
    region = "ap-south-1"
  }
}
