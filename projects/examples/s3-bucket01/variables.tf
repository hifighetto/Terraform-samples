variable "env" {
  description = "What is your environment"
  default     = "changeme"
}

variable "my_region" {
  description = "enter your region here"
  default     = "us-east-1"
}

variable "standard_tags" {
  description = "Tags, you need them"
  default     = {}
}

variable "project_name" {
  description = "What is your project called?"
}

variable "s3_bucket_name" {
  description = "The name of your S3 Bucket"
}