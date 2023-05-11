data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



resource "aws_instance" "app1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  private_ip             = "10.0.0.171"
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.nginx.id]
  user_data              = file("templates/nginx.sh")
  security_groups        = [aws_security_group.nginx.id]
  iam_instance_profile   = aws_iam_instance_profile.vault.name
  key_name               = aws_key_pair.demo.key_name
  tags = {
    Name = "${var.prefix}-app1"
    Env  = "vault"
  }
}