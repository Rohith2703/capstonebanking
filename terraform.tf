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
  region = "ap-south-1a"
}

resource "aws_instance" "test-server" {
  ami           = "ami-0287a05f0ef0e9d9a"  
  instance_type = "t2.micro"
}

output "public_ip" {
  value = aws_instance.test-server.public_ip
}