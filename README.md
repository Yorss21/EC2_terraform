# EC2 Terraform Deployment

This project provisions EC2 instances on AWS using Terraform, with separate configurations for development (`dev`) and quality assurance (`qa`) environments.

## 📁 Project Structure

    EC2_terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── 01.provider.tf
    ├── nginx_server_module/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── server_dev_qa.tfplan

## ⚙️ Prerequisites

- Terraform v1.x
- Configured AWS CLI
- AWS credentials with appropriate permissions

## 🚀 Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/Yorss21/EC2_terraform.git
    cd EC2_terraform
    ```

2. Initialize Terraform:

    ```bash
    terraform init
    ```

3. Preview the execution plan:

    ```bash
    terraform plan -out=server_dev_qa.tfplan
    ```

4. Apply the configuration:

    ```bash
    terraform apply "server_dev_qa.tfplan"
    ```

## 🧩 Variables

Main input variables are defined in `variables.tf`, including:

- `region`: AWS region to deploy the instances.
- `environment`: Deployment environment (`dev` or `qa`).
- `instance_type`: EC2 instance type.
- `ami_id`: AMI ID to use.
- `server_name`: Name assigned to the instance.

You can customize these as needed.

## 📤 Outputs

After deployment, Terraform will output the following:

- `nginx_dev_public_ip`: Public IP of the dev environment EC2 instance.
- `nginx_dev_public_dns`: Public DNS of the dev environment EC2 instance.
- `nginx_qa_public_ip`: Public IP of the QA environment EC2 instance.
- `nginx_qa_public_dns`: Public DNS of the QA environment EC2 instance.

## 🧱 `nginx_server_module` Module

The `nginx_server_module` encapsulates logic for provisioning an EC2 instance with Nginx. It includes:

- EC2 instance configuration.
- Security group association.
- Public IP assignment.
- Tagging and naming.

The module is reusable for different environments or server configurations.

## 🧹 Clean Up

To destroy the resources created:

```bash
terraform destroy
```

