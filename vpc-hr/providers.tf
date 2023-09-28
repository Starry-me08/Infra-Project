terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "job-hr-454"
    key            = "HR/terraform.tfstate"
    dynamodb_table = "HR-terraform-remote-state-dynamo"
    region         = "us-east-2"
  }
}

provider "aws" {
  region = var.aws_region
}