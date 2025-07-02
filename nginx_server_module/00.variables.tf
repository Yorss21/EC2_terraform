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

variable "region" {
  type        = string
  default     = "us-west-1"
  description = "The AWS region to deploy the Nginx server instance."
}