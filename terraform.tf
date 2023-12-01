terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "test-server" {
  ami           = "ami-0287a05f0ef0e9d9a"  
  instance_type = "t2.micro"
  tags = {
     Name = "Test-Server"
  }
}
resource "aws_instance" "prod-server" {
  ami           = "ami-0287a05f0ef0e9d9a"  
  instance_type = "t2.micro"
  tags = {
     Name = "Prod-Server"
  }
}

resource "aws_security_group" "allow_ssh_and_8080" {
  name        = "allow-ssh-and-8080"
  description = "Allow incoming SSH (port 22) and HTTP (port 8080) traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "test_server_ip" {
  value = aws_instance.test-server.public_ip
}

output "prod_server_ip" {
  value = aws_instance.prod-server.public_ip
}