resource "aws_eks_cluster" "demo-eks-cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_iam_role.arn

  version = var.k8s_version

  vpc_config {
    subnet_ids = [aws_subnet.eks_subnet_1.id,aws_subnet.eks_subnet_2.id,aws_subnet.eks_subnet_3.id,aws_subnet.eks_subnet_4.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_iam_policy_attachment,
    aws_iam_role.eks_cluster_iam_role
  ]
}

resource "aws_eks_node_group" "demo_eks_node_group" {
  cluster_name    = aws_eks_cluster.demo-eks-cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_group_iam_role.arn
  subnet_ids      = [aws_subnet.eks_subnet_1.id,aws_subnet.eks_subnet_2.id]

  scaling_config {
    desired_size = var.eks_node_desired_size
    max_size     = var.eks_node_max_size
    min_size     = var.eks_node_min_size
  }

  instance_types = [var.eks_node_instance_types]
  version = var.k8s_version
  ami_type = var.node_ami_type

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_iam_policy_attachment-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_node_group_iam_policy_attachment-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_node_group_iam_policy_attachment-AmazonEC2ContainerRegistryReadOnly
  ]
}

output "endpoint" {
  value = aws_eks_cluster.demo-eks-cluster.endpoint
}

output "eks_cluster_name" {
  value = aws_eks_cluster.demo-eks-cluster.name
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.demo-eks-cluster.certificate_authority.0.data
}
