# Provider configuration
# Note: Change the region name as per requirement

provider "aws" {
 region  = "ap-south-1"  
}

data "aws_eks_cluster_auth" "cluster-auth" {
  name       = module.eks_cluster.eks_cluster_name
}

provider "helm" {
kubernetes {
    host                   = module.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.eks_cluster_certificate_authority)
    token                  = data.aws_eks_cluster_auth.cluster-auth.token
    load_config_file       = false
  }
}

provider "kubernetes" {
    host                   = module.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.eks_cluster_certificate_authority)
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
