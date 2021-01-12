terraform {
  backend "s3" {
    encrypt = "true"
    bucket  = "ChangeMe"
    # Change to your Bucket 
    key    = "terraform/states/vpc.tfstate"
    region = "us-west-2"
    # Change to your dynamo-db table 
    dynamodb_table = "ChangeMe"
  }
  required_providers {
    aws = {
      version = "3.22.0"
      source  = "hashicorp/aws"
    }
  }

}

provider "aws" {
  region = "us-west-2"
}