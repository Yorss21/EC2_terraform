provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "nginx-server" {
  ami           = "ami-061ad72bc140532fd" # Example AMI, replace with a valid one
  instance_type = "t2.micro"

  tags = {
    Name = "NginxServer"
  }
}