# VPC Import 

## Instructions for importing VPC to terraform 

This is the text version for how to import the VPC to terraform. This is only used as an exmaple of importing these items 

### This is not a module 
This is not a module to import items directly, and it is not meant to be anything more than a template. <br> 
Not everything in this respotiory is exaclty perfect, and there are many more options available. <br>
Please read all items before carrying on, and also be sure to check the [Terraform VPC Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) <br>
This is also not a full instruction on how to do everything within terraform.<br>

### This is a guide 
This is a basic guide to give some examples of a simple VPC import into terraform. <br>
It will assist or give a starting point on how to import an existing infrastructure environment.<br>

### Getting started 

#### Before Starting 
All terraform commands are meant to be run with the flag of `--var-file=dev.tfvars`.
It is recommended to put your own variables into the `dev.tfvars` file, as these have sample variables. 


#### Doing the things 
Start by creating the VPC resource in your terraform file. 
The file [vpc_main](vpc_main.tf) has some of the basics for the resource. 
After you have the resource created, even with a simple blank resource as below, you can run the import. 
```
resource "aws_vpc" "main_vpc" {
}
```

To run the import on the resouce, run `terraform import` 
```
terraform import --var-file dev.tfvars aws_vpc.main_vpc vpc-###########

aws_vpc.main_vpc: Importing from ID "vpc-###########"...
aws_vpc.main_vpc: Import prepared!
  Prepared aws_vpc for import
aws_vpc.main_vpc: Refreshing state... [id=vpc-###########]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

Releasing state lock. This may take a few moments...
```
Then doing a `terraform plan` will show if resources need to be changed. This is where you can add the existing variables by putting the enteries into the resource. 


##### Me 
I am usually active on twitter, but I can be found at [linktr.ee](https://linktr.ee/hifighetto)
Associated [YouTube Video](https://youtu.be/N-ptWCl3xlY)