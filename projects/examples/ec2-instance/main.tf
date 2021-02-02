data "aws_ami" "aws_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.2021*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_security_group" "ec2_instance_sg" {
  name        = "ssh-web"
  description = "SSH and web access GLOBAL!"
  vpc_id      = var.vpc_id

  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 22
      to_port          = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
    },
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 80
      to_port          = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
    },
  ]

  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
    }
  ]

  tags = var.standard_tags
}

resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.aws_linux.id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.ec2_instance_sg.id]
  key_name                    = var.ssh_key_name
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id

  tags = var.standard_tags
}