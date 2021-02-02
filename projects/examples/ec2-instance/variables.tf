variable "env" {
  description = "Environment variable"
}

variable "region" {
  description = "The region you are working in"
}

variable "standard_tags" {
  description = "Tags you want to use"
}

variable "vpc_id" {
  description = "The default VPC to use"
}

variable "subnet_id" {
  description = "The subnet id that you want to use for the instance."
}

variable "instance_type" {
  description = "The size or type of the instance to use"
}

variable "ssh_key_name" {
  description = "The SSH key to the EC2 instnace"
}