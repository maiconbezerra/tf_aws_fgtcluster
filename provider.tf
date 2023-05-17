terraform {
  required_version = ">= 1.0.7, <= 1.3.9"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    #  TF remote state
    bucket = "bucketname"
    key = "firewall_cluster/environment.tfstate"
    region = "sa-east-1"

    #  TF state lock control
    dynamodb_table = "dynamodb_table_name"
    encrypt = true

  }
}


provider "aws" {
  region = local.region
}