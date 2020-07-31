# demo-eks-terraform

### Setting up credentials for AWS
- Install awscli and configure your AWS access key and secret key for the account in which we need to deploy the cluster.
- This credentials will be automatically picked up by terraform, as we have added the aws provider block.
- In this way we don't have to add sensitive information in code.

### Information about files in this repo and how to make the changes

**provider.tf** : Contains provider and backend information.

**supporting_resources.tf** : Contains terraform code for other resources which are needed to create the EKS cluster. For instance, while creating an EKS cluster with terraform the subnet and IAM role information is mandatory, these resources are coded in this file.

**eks_cluster.tf** : Contains terraform code specific to EKS cluster and node group.

**terraform.tfvars** : Variable file. We only need to make changes in this file as per the configuration requirement. 

**output.tf** : This file has code related to any information that the end user might need, and we want terraform to tell us the same. Edit this file if any more information is needed.


### Which files to update and when
In order to make sure we don't make any breaking changes in the code unintentionally, it's recommended that you should only make changes in the below files.
1. *terraform.tfvars* : If we want to make any config changes in the resources, update this file. If we end up adding a new variable, we will need to update the corresponding code.
2. *output.tf* : If we want any information about the cluster to be shown on the terminal, update this file with the specific attribute of the resource.

### Additional security attribute recommended but not mandatory in EKS cluster
For enhanced security, it is recommended that you should add below parameters in your code for EKS worker node group. However they are not made mandatory by terraform to create the node group:

1. *source_security_group_ids* : This parameter will accept security group id in which we can specify IP rules for SSH access to the cluster.
2. *ec2_ssh_key* : This parameter accepts SSH public key from the key pair which can be used to ssh to the nodes.