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