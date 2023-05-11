provider "aws" {
  region = "us-west-2" # Update with your desired region
}

variable "region" {
  default = "us-west-2" # Update with your desired region
}

variable "laptop_ip" {
  description = "Your laptop's public IP address"
}

resource "aws_vpc" "bigip_vpc" {
  cidr_block = "10.0.0.0/16" # Update with your desired VPC CIDR block

  tags = {
    Name = "BIG-IP VPC"
  }
}

resource "aws_instance" "bigip_instance" {
  ami                         = var.f5ami  # Replace with the correct BIG-IP AMI ID
  instance_type               = "m5.large" # Update with the desired instance type
  key_name                    = aws_key_pair.demo.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.f5.id]
  associate_public_ip_address = true
  private_ip                  = "10.0.0.200"
  user_data                   = data.template_file.f5_init.rendered
   tags = {
    Name = "${var.prefix}-f5"
    Env  = "vault"
  }
}

data "template_file" "f5_init" {
  template = file("templates/f5.tpl")

  vars = {
    password = random_string.password.result
  }
}

resource "random_string" "password" {
  length  = 10
  special = false
}
