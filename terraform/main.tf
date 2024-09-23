provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "webapp_repo" {
  name = "webapp"
}

resource "aws_ecr_repository" "mysql_repo" {
  name = "mysql"
}

resource "aws_instance" "webapp" {
  ami           = "ami-0ebfd941bbafe70c6"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-09c0aae12ced55d78"]  # Correct argument for security groups in a VPC
  key_name      = "a2"                         # Ensure the key exists in your AWS account

  tags = {
    Name = "CLO835-WebApp"
  }
}
