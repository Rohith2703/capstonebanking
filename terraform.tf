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
  key_name      = "Jenkins-Server"
  tags = {
     Name = "Test-Server"
  }
}
resource "aws_instance" "prod-server" {
  ami           = "ami-0287a05f0ef0e9d9a"  
  instance_type = "t2.micro"
  key_name      = "Jenkins-Server"
  tags = {
     Name = "Prod-Server"
  }
}

data "aws_security_group" "existing_sg" {
  id = "sg-0cd0b11c0a086bb1c"  # Replace with your actual security group ID
}

resource "aws_security_group" "reuse_existing_sg" {
  name        = data.aws_security_group.existing_sg.name
  description = "Reuse an existing security group allowing all traffic"
}

output "test_server_ip" {
  value = aws_instance.test-server.public_ip
}

output "prod_server_ip" {
  value = aws_instance.prod-server.public_ip
}