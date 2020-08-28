# Table of content
- [Pre-requisites](#prereq)
- [Setting up credentials for AWS](#awscreds)
- [Repository Content](#repocontent)
- [Why, When and How to update the code](#updatecode)


<div id='prereq'/>

## Pre-requisites
Following tools should be installed and configured before you can use this repository content.
1. Install terraform: Latest version at the time of use is recommended. For steps to install and configure terraform visit [terraform documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli).
2. Access to AWS cloud: Depending on how you are using this repository(like on local computer or in CICD pipelines etc), you will need to setup your AWS Access to the environment where terraform is running. See the sample steps outlined below if you are running terraform from your local computer.

<div id='awscreds'/>

## Setting up credentials for AWS
Below steps will help in installing and configuring AWS CLI on the local computer, in this way we don't have to add sensitive information in code.
- Create and download your AWS Access key and secret key. [Visit this documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey) for the steps.
- Install awscli, for instructions on how to install and configure AWS CLI, visit [AWS Documentation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- Once AWS CLI is installed, run 'aws configure' command from terminal, it will ask you AWS Access key secret key and your default AWS region. Add this information, once done verify your access by listing any resource previously created, to make sure you are connected to the correct account. 
- This credentials will be automatically picked up by terraform, as we have added the aws provider block.

<div id='repocontent'/>

## Repository Content

The contents in the repository are structured as follows;
1. main.tf: This file contains modules that this repo can be used to provision. As of now it supports creation of EKS cluster and Installation of helm charts on the same. Note that all the other resources that EKS cluster needs are also included in the same module(for eg, IAM policy/roles or networking resources for EKS cluster are included in EKS module itself), in order to make the repository content based on modules rather than AWS resources.
2. provider.tf: This file is for terraforms reference. It contains definitions for respective providers used in the terraform code.
3. output.tf: Contains terraform code related to the information that needs to be given back to the user when terraform run completes.
4. Modules directory: Contains terraform code specific to the modules that this repository supports. As of now it supports EKS cluster provisioning and Helm chart installation with terraform.

<div id='updatecode'/>

## Why, When and How to update the code
In order to make sure we don't make any unintentional changes and we have to make fewer changes in code, please follow these guidelines regarding making changes to the code.

1. Update configuration of existing modules: If the module is already being supported, but you are looking for resource configuration to be different than the values provided by default (for eg. Instance type of EC2 instances in node group, subnet configuration or kubernetes version for the cluster etc), update the specific parameter in the respective module in main.tf.
2. Retrieve additional output from AWS resources: If you want to retrieve any output from the infrastructure created (say endpoint of the EKS cluster), we need to add output resource in terraform code. Add the output resource in output.tf file.
3. Add new module: If you are planning to add code for new module follow below guidelines:
- We have tried to modularize the content of the terraform code. Read more about modules in terraform [here](https://www.terraform.io/docs/modules/index.html).
- Create a folder under 'modules' directory with the name of the module and add your terraform code for the module in that folder. 
- Inside the specific module folder you can further distribute the code with respect to AWS resources to minimize complexity.
- To call the module, add a specific module calling code in main.tf . Check out the code that is already present, it will help to understand the code structure.
- It's recommended to use a PR approach for contribution and not adding the code directly to the master branch.