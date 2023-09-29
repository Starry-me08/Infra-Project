terraform {
  backend "s3" {
    bucket         = "job-hr-454"
    key            = "HR-ec2/terraform.tfstate"
    dynamodb_table = "HR-terraform-remote-state-dynamo"
    region         = "us-east-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.0"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket         = "job-hr-454"
    key            = "HR/terraform.tfstate"
    dynamodb_table = "HR-terraform-remote-state-dynamo"
    region         = "us-east-2"
  }
}
provider "aws" {
  region = var.aws_region
  #profile = "terraform"
}
