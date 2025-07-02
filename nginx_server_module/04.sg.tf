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
