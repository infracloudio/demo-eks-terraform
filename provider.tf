# Provider configuration
# Note: Change the region name as per requirement

provider "aws" {
 region  = "us-east-1"  
}


# Additionally we can have backend block in here, if we want to manage the terraform state file in cloud (for eg AWS s3 as shown in example below, uncomment it if needed)


# terraform {
#   backend "s3" {
#     bucket = "mybucket"
#     key    = "path/to/my/key"
#     region = "us-east-1"
#   }
# }