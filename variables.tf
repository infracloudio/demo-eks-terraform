variable "cluster_name" {
  type        = string
  default     = ""
  description = "Name of the EKS cluster"
}

variable "node_group_name" {
  type        = string
  default     = ""
  description = "Name of the Node group"
}


variable "vpc_cidr_block" {
  type        = string
  default     = "10.210.0.0/16"
  description = "VPC under which cluster needs to be created"
}

variable "subnet1" {
  type        = map
  description = "CIDR and AZ for Subnet1"
}

variable "subnet2" {
  type        = map
  description = "CIDR and AZ for Subnet2"
}

variable "subnet3" {
  type        = map
  description = "CIDR and AZ for Subnet3"
}

variable "subnet4" {
  type        = map
  description = "CIDR and AZ for Subnet4"
}

variable "subnet5" {
  type        = map
  description = "CIDR and AZ for Subnet5"
}

variable "subnet6" {
  type        = map
  description = "CIDR and AZ for Subnet6"
}

variable "eks_node_desired_size" {
  type        = number
  description = "Desired size of cluster"
}

variable "eks_node_min_size" {
  type        = number
  description = "Minimum number of nodes in cluster"
}

variable "eks_node_max_size" {
  type        = number
  description = "Maximum number of nodes in cluster"
}

variable "eks_node_instance_types" {
  type        = string
  description = "Instance type of nodes in cluster"
}

variable "node_ami_type" {
  type        = string
  description = "AMI type of cluster nodes"
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version on the cluster"
}
