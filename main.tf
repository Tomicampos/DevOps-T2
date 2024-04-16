provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance_security_group" {
  name        = "instance_security_group1"
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Cobranzas_QA_instance" {
  ami                    = "ami-051f8a213df8bc089"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance_security_group.id]
  key_name               = "Casonegocio"

  tags = {
    Name = "ORG-Cobranzas-QA"
  }
}

output "public_ip_dev" {
  value = aws_instance.Cobranzas_QA_instance.public_ip
}

