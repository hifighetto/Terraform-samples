resource "aws_subnet" "main_subnet_1" {
  availability_zone_id    = var.azid1
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnet_cidr_1
  map_public_ip_on_launch = true

  tags = var.standard_tags
}

resource "aws_subnet" "main_subnet_2" {
  availability_zone_id    = var.azid2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnet_cidr_2
  map_public_ip_on_launch = true

  tags = var.standard_tags
}

resource "aws_subnet" "main_subnet_3" {
  availability_zone_id    = var.azid3
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnet_cidr_3
  map_public_ip_on_launch = true

  tags = var.standard_tags
}

resource "aws_subnet" "main_subnet_4" {
  availability_zone_id    = var.azid4
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnet_cidr_4
  map_public_ip_on_launch = true

  tags = var.standard_tags
}