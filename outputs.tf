output "server_public_ip" {
    value = aws_instance.nginx-server.public_ip
    description = "The public IP address of the Nginx server instance"
}

output "server_public_dns" {
    value = aws_instance.nginx-server.public_dns
    description = "The public IP address of the Nginx server instance"
}