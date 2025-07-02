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