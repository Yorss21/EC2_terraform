provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "nginx-server" {
  ami           = "ami-061ad72bc140532fd" # Example AMI, replace with a valid one
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  key_name               = aws_key_pair.nginx_key.key_name
  vpc_security_group_ids = [aws_security_group.nginx_server_sg.id]
  tags = {
    Name        = "NginxServer"
    Environment = "Staging"
    Owner       = "Jorge C"
    Team        = "DevOps"
    Project     = "NginxDeployment"
  }
}

resource "aws_security_group" "nginx_server_sg" {
  name        = "nginx_server-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere, consider restricting this in production
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name        = "NginxServer-SG"
    Environment = "Staging"
    Owner       = "Jorge C"
    Team        = "DevOps"
    Project     = "NginxDeployment"
  }
}


resource "aws_key_pair" "nginx_key" {
  key_name   = "nginx_key"
  public_key = file("~/Desktop/terraform_aws/nginx-server.key.pub") # Ensure you have a valid public key

  tags = {
    Name        = "NginxServer-SSHKey"
    Environment = "Staging"
    Owner       = "Jorge C"
    Team        = "DevOps"
    Project     = "NginxDeployment"
  }
}

