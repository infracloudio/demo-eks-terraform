# Additional resource that are required fot creating the EKS cluster
resource "aws_vpc" "eks_vpc" {
  cidr_block       = var.vpc_cidr_block
  tags = {
    Name = "eks-vpc"
  }
}


resource "aws_subnet" "eks_subnets" {
  count = var.subnet_count

  cidr_block  = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
  vpc_id      = aws_vpc.eks_vpc.id
}


resource "aws_iam_role" "eks_cluster_iam_role" {
  name = "eks_cluster_iam_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_iam_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_iam_role.name
}


resource "aws_iam_role" "eks_node_group_iam_role" {
  name = "eks_node_group_iam_role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role_policy_attachment" "eks_node_group_iam_policy_attachment-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_iam_role.name
}


resource "aws_iam_role_policy_attachment" "eks_node_group_iam_policy_attachment-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_iam_role.name
}


resource "aws_iam_role_policy_attachment" "eks_node_group_iam_policy_attachment-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_iam_role.name
}