# VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block       = var.vpc_cidr_block
  tags = {
    Name = "eks-vpc"
  }
}

# Subnets: 2 public and 2 private
resource "aws_subnet" "eks_subnet_1" {
  # Public subnet
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.subnet1.cidr_block
  availability_zone = var.subnet1.availability_zone

  tags = {
    "kubernetes.io/cluster/${aws_eks_cluster.demo-eks-cluster.name}" = "shared"
  }
}

resource "aws_subnet" "eks_subnet_2" {
  # Private subnet
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.subnet2.cidr_block
  availability_zone = var.subnet2.availability_zone
  
  tags = {
    "kubernetes.io/cluster/${aws_eks_cluster.demo-eks-cluster.name}" = "shared"
  }
}

resource "aws_subnet" "eks_subnet_3" {
  # Public subnet
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.subnet3.cidr_block
  availability_zone = var.subnet3.availability_zone
  
  tags = {
    "kubernetes.io/cluster/${aws_eks_cluster.demo-eks-cluster.name}" = "shared"
  }
}

resource "aws_subnet" "eks_subnet_4" {
  # Private subnet
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.subnet4.cidr_block
  availability_zone = var.subnet4.availability_zone
  
  tags = {
    "kubernetes.io/cluster/${aws_eks_cluster.demo-eks-cluster.name}" = "shared"
  }
}

# NAT gateway and EIP for NAT gateway
resource "aws_eip" "nat-eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id = aws_subnet.eks_subnet_1.id
}

# Internet gateway for public subnets
resource "aws_internet_gateway" "int-gtwy" {
  vpc_id = aws_vpc.eks_vpc.id
}

# Routing table for internet access
resource "aws_route_table" "rt-tbl-public" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int-gtwy.id
  }
}

# Routing table for private subnet which connects to NAT for Internet access
resource "aws_route_table" "rt-tbl-private" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }
}

# Routing table association: Public
resource "aws_route_table_association" "rt-tbl-association-public-1" {
  subnet_id      = aws_subnet.eks_subnet_1.id
  route_table_id = aws_route_table.rt-tbl-public.id
}

resource "aws_route_table_association" "rt-tbl-association-public-2" {
  subnet_id      = aws_subnet.eks_subnet_3.id
  route_table_id = aws_route_table.rt-tbl-public.id
}

# Routing table association: Private
resource "aws_route_table_association" "rt-tbl-association-private-3" {
  subnet_id      = aws_subnet.eks_subnet_2.id
  route_table_id = aws_route_table.rt-tbl-private.id
}

resource "aws_route_table_association" "rt-tbl-association-private-4" {
  subnet_id      = aws_subnet.eks_subnet_4.id
  route_table_id = aws_route_table.rt-tbl-private.id
}

