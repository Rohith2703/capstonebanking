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

output "test_server_ip" {
  value = aws_instance.test-server.public_ip
}

output "prod_server_ip" {
  value = aws_instance.prod-server.public_ip
}