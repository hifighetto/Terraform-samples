resource "aws_network_acl" "main_acl" {
  vpc_id = aws_vpc.main_vpc.id

  tags = var.standard_tags
}