variable "env" {
  type        = string
  description = "Set your environment"
}

variable "my_region" {
  type        = string
  description = "The Region for this project"
}

variable "standard_tags" {
  description = "Tags that are used throughout the project"
}

variable "main_cidr" {
  description = "The CIDR block for the entire VPC"
}

# The availability zones 
variable "azid1" {
  description = "The First Availabilty Zone"
}
variable "azid2" {
  description = "The Second Availabilty Zone"
}
variable "azid3" {
  description = "The Third Availabilty Zone"
}
# Sometimes the 4th AZ is not avaiable
# It variables on the age of your AWS Account
variable "azid4" {
  description = "The Fourth Availabilty Zone"
}

# The subnets for each zone
variable "subnet_cidr_1" {
  description = "The /20 cidr for subnet 1"
}
variable "subnet_cidr_2" {
  description = "The /20 cidr for subnet 2"
}
variable "subnet_cidr_3" {
  description = "The /20 cidr for subnet 3"
}
variable "subnet_cidr_4" {
  description = "The /20 cidr for subnet 4"
}


variable "new_tags" {
  description = "Tags that are used throughout the project"
}
