terraform {
  backend "s3" {
    encrypt        = "true"
    bucket         = "ChangeToYourDynamoDBTable"
    key            = "terraform/states/ec2-instance.tfstate"
    region         = "us-west-2"
    dynamodb_table = "ChangeToYourDynamoDBTable"
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
