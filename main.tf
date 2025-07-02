### tfstate ###
terraform {
  backend "s3" {
    bucket         = "jorge-terraform-practice-tfstate"
    key            = "nginx_server/terraform/state/terraform.tfstate"
    region         = "us-west-1"
  }
}


### Modules ###
module "nginx_server_dev"{
    source = "./nginx_server_module"
    
    environment = "dev"
    instance_type = "t3.medium"
    ami_id = "ami-061ad72bc140532fd"
    server_name = "nginx-server-dev"
    region = "us-west-1"
}

module "nginx_server_qa"{
    source = "./nginx_server_module"
    
    environment = "qa"
    instance_type = "t3.large"
    ami_id = "ami-061ad72bc140532fd"
    server_name = "nginx-server-qa"
    region = "us-west-1"
}

output "nginx_dev_public_ip" {
    value = module.nginx_server_dev.server_public_ip
    description = "The public IP address of the Nginx server instance"
}

output "nginx_dev_public_dns" {
    value = module.nginx_server_dev.server_public_dns
    description = "The public IP address of the Nginx server instance"
}

output "nginx_qa_public_ip" {
    value = module.nginx_server_qa.server_public_ip
    description = "The public IP address of the Nginx server instance"
}

output "nginx_qa_public_dns" {
    value = module.nginx_server_qa.server_public_dns
    description = "The public IP address of the Nginx server instance"
}