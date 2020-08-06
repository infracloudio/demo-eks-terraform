# In order to configure the resources, only make changes in this file. 
# Variables defined here are referrenced in the terraform code in other files

# EKS Cluster
cluster_name = "demo-eks-cluster-rahulkadam"
node_group_name = "demo_eks_node_group-rahulkadam"
eks_node_desired_size = 3
eks_node_min_size = 3
eks_node_max_size = 3
eks_node_instance_types = "t2.micro"
node_ami_type = "AL2_x86_64"
k8s_version = "1.14"

# Networking
vpc_cidr_block = "10.210.0.0/16"

# Private subnets
subnet1 = { 
    "cidr_block" = "10.210.1.0/24"
    "availability_zone" = "ap-south-1a"
}
subnet2 = { 
    "cidr_block" = "10.210.2.0/24"
    "availability_zone" = "ap-south-1b"
}
subnet3 = { 
    "cidr_block" = "10.210.3.0/24"
    "availability_zone" = "ap-south-1c"
}
subnet4 = { 
    "cidr_block" = "10.210.4.0/24"
    "availability_zone" = "ap-south-1a"
}
subnet5 = { 
    "cidr_block" = "10.210.5.0/24"
    "availability_zone" = "ap-south-1b"
}
subnet6 = { 
    "cidr_block" = "10.210.6.0/24"
    "availability_zone" = "ap-south-1c"
}
