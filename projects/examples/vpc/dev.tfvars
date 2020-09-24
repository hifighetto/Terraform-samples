env = "dev"

my_region = "us-region-X"

standard_tags = {
  "Environment"    = "dev"
  "Terraform"      = "true"
  "Project Name"   = "Main VPC"
  "Terraform Path" = "project/examples/vpc"
}


new_tags = {
  "Terraform"      = "true"
  "Project Name"   = "Main VPC"
  "Terraform Path" = "project/dev/vpc"
}
main_cidr = "172.31.0.0/16"

# Availability zones go here 
# Weird order on this one though, not gonna lie
azid1 = "usw2-azX"
azid2 = "usw2-azX"
azid3 = "usw2-azX"
azid4 = "usw2-azX"

# The subnets you want to use go here 
subnet_cidr_1 = "172.31.X.0/20"
subnet_cidr_2 = "172.31.1X.0/20"
subnet_cidr_3 = "172.31.3X.0/20"
subnet_cidr_4 = "172.31.4X.0/20"