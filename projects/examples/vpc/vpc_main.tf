resource "aws_vpc" "main_vpc" {
  cidr_block = var.main_cidr

  tags = var.standard_tags
}

resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = var.standard_tags
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gateway.id
  }

  tags = var.standard_tags
}

resource "aws_vpc_dhcp_options" "basic_dhcp_options" {
  domain_name         = "${var.my_region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags                = var.standard_tags
}