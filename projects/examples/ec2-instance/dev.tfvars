env    = "dev"
region = "us-west-2"

standard_tags = {
  "Environment" = "dev"
  "Project"     = "ec2-instance"
  "Terraform"   = "v0.14.3"
  "AWS Version" = "3.22.0"
}

vpc_id    = "vpc-XXXXXXXXXXX"
subnet_id = "subnet-XXXXXXXXXXXX"

instance_type = "t3a.micro"
ssh_key_name  = "YourSSHKey"