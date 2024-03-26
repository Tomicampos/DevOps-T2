provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance_security_group" {
  name        = "instance_security_group"
  description = "Security group for EC2 instance"
  ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port   = 3000
  to_port     = 3000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "COMPRAS_dev_instance" {
  ami                    = "ami-0c101f26f147fa7fd"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance_security_group.id]
  key_name = "Casonegocio"


  tags = {
    Name = "ORG-COMPRAS-DEV"
  }
}

output "public_ip_dev" {
  value = aws_instance.COMPRAS_dev_instance.public_ip
}
