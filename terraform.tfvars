# In order to configure the resources, only make changes in this file. 
# Variables defined here are referrenced in the terraform code in other files


vpc_cidr_block = "10.210.0.0/16"
subnet1 = { 
    "cidr_block" = "10.210.1.0/24"
    "availability_zone" = "us-east-1a"
}
subnet2 = { 
    "cidr_block" = "10.210.2.0/24"
    "availability_zone" = "us-east-1a"
}
subnet3 = { 
    "cidr_block" = "10.210.3.0/24"
    "availability_zone" = "us-east-1b"
}
subnet4 = { 
    "cidr_block" = "10.210.4.0/24"
    "availability_zone" = "us-east-1b"
}

eks_node_desired_size = 3
eks_node_min_size = 3
eks_node_max_size = 3

eks_node_instance_types = "t3.medium"
node_ami_type = "AL2_x86_64"

k8s_version = "1.14"
