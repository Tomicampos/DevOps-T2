provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance_security_group" {
  name        = "instance_security_group"
  description = "Security group for EC2 instance"
}

resource "aws_instance" "COMPRAS_dev_instance" {
  ami                    = "ami-0c101f26f147fa7fd"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance_security_group.id]

  tags = {
    Name = "ORG-COMPRAS-DEV"
  }
}

output "public_ip_dev" {
  value = aws_instance.COMPRAS_dev_instance.public_ip
}
