terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ba9276d1fb25ed77"
  instance_type = "t3.micro"

  tags = {
    Name   = "ExampleAppServerInstance"
    Author = "Reuben"
  }
}
