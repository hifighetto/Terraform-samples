terraform {
  backend "s3" {
    encrypt              = "true"
    bucket               = "ChangeMe"
    # Change to your Bucket 
    key                  = "terraform/states/vpc_main/"
    region               = "us-west-2"
    # Change to your dynamo-db table 
    dynamodb_table       = "ChangeMe"
    # Uncomment below and add your workspace prefix key
    # workspace_key_prefix = "MyWorkspace"
  }

  required_version = ">=0.12.0"
}

provider "aws" {
  version = "~> 3.1.0"
  region  = "us-west-2"
}
