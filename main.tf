# Variables
variable "ami_id" {
  type        = string
  default     = "ami-061ad72bc140532fd"
  description = "The AMI ID to use for the Nginx server instance."
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The instance type for the Nginx server."
}

variable "server_name" {
  type        = string
  default     = "NginxServer"
  description = "The name tag for the Nginx server instance."
}

variable "environment" {
  type        = string
  default     = "Staging"
  description = "The environment tag for the Nginx server instance."
}


provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "nginx-server" {
  ami           = var.ami_id # Example AMI, replace with a valid one
  instance_type = var.instance_type

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
    Name        = var.server_name
    Environment = var.environment
    Owner       = "Jorge C"
    Team        = "DevOps"
    Project     = "NginxDeployment"
  }
}

resource "aws_security_group" "nginx_server_sg" {
  name        = "${var.server_name}-sg"
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
    Environment = "${var.environment}"
    Owner       = "Jorge C"
    Team        = "DevOps"
    Project     = "NginxDeployment"
  }
}


resource "aws_key_pair" "nginx_key" {
  key_name   = "${var.server_name}-key"
  public_key = file("~/Desktop/terraform_aws/nginx-server.key.pub") # Ensure you have a valid public key

  tags = {
    Name        = "NginxServer-SSHKey"
    Environment = "${var.environment}"
    Owner       = "Jorge C"
    Team        = "DevOps"
    Project     = "NginxDeployment"
  }
}

output "server_public_ip" {
    value = aws_instance.nginx-server.public_ip
    description = "The public IP address of the Nginx server instance"
}

output "server_public_dns" {
    value = aws_instance.nginx-server.public_dns
    description = "The public IP address of the Nginx server instance"
}