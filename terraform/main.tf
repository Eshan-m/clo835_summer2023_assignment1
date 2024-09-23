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
  ami           = "ami-0ebfd941bbafe70c6" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags = {
    Name = "CLO835-WebApp"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y docker",
      "sudo service docker start",
      "sudo usermod -aG docker ec2-user"
    ]
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
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
