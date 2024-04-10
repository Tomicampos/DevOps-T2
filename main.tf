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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "COMPRAS_QAs_instance" {
  ami                    = "ami-0c101f26f147fa7fd"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance_security_group.id]
  key_name               = "Casonegocio"  

  tags = {
    Name = "ORG-COMPRAS-QA"
  }
}

output "public_ip_dev" {
  value = aws_instance.COMPRAS_QA_instance.public_ip
}

env:
  SSH_PRIVATE_KEY: ${{ secrets.AWS_PEM}}
  REMOTE_USER: ec2-user
  REMOTE_HOST: ${{ vars.REMOTE_HOST }}
  APP_NAME: app.js

name: Create directory
  uses: appleboy/ssh-action@master
  with:
    host: ${{ env.REMOTE_HOST }}
    username: ec2-user
    key: ${{ secrets.AWS_PEM }}
    script: |
      sudo rm -rf /opt/montoto || true
