env = "dev"

my_region = "us-west-2"

standard_tags = {
  "Environment"    = "dev"
  "Terraform"      = "true"
  "Project Name"   = "Main VPC"
  "Terraform Path" = "project/dev/vpc"
}


new_tags = {
  "Asset_ID"       = "0001"
  "BillingCode"    = "121321"
  "Country Code"   = "US1-23"
  "Terraform"      = "true"
  "Project Name"   = "Main VPC"
  "Terraform Path" = "project/dev/vpc"
}
main_cidr = "172.31.0.0/16"

# Availability zones go here 
# Weird order on this one though, not gonna lie
azid1 = "usw2-az3"
azid2 = "usw2-az1"
azid3 = "usw2-az2"
azid4 = "usw2-az4"

# The subnets you want to use go here 
subnet_cidr_1 = "172.31.0.0/20"
subnet_cidr_2 = "172.31.16.0/20"
subnet_cidr_3 = "172.31.32.0/20"
subnet_cidr_4 = "172.31.48.0/20"