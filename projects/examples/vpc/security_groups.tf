resource "aws_security_group" "default_security_group" {
  name        = "default"
  description = "default VPC security group"
  vpc_id      = aws_vpc.main_vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  ingress {
    cidr_blocks = []
    from_port   = 0
    to_port     = 0
    protocol    = -1
    self        = true
  }

  timeouts {}

  tags = var.standard_tags
}