# Azure VM Terraform Deployment

This project uses Terraform to provision Azure infrastructure, including resource groups, virtual networks, subnets, public IPs, network interfaces, network security groups, and Linux virtual machines.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- Azure subscription and credentials (login via `az login`)
- Sufficient permissions to create resources in the target subscription

## Files Overview

- `main.tf`: Sets up the provider and resource group.
- `variables.tf`: Defines all input variables for the deployment.
- `terraform.tfvars`: Provides values for the variables.
- `vnet.tf`: Provisions networking, security, and VM resources.

## Usage

1. **Clone the repository**

   ```sh
   git clone <repo-url>
   cd Azure-VM-TF
   ```

2. **Initialize Terraform**

   ```sh
   terraform init
   ```

3. **Review and Edit Variables**

   - Edit [`terraform.tfvars`](terraform.tfvars) to customize resource names, locations, network settings, and VM details as needed.

4. **Plan the Deployment**

   ```sh
   terraform plan -out main.tfplan
   ```

5. **Apply the Deployment**

   ```sh
   terraform apply "main.tfplan"
   ```

6. **Destroy the Deployment (when needed)**

   ```sh
   terraform destroy
   ```

## Resources Created

- Azure Resource Group
- Virtual Networks and Subnets
- Public IP Addresses
- Network Interfaces
- Network Security Groups and Rules
- Linux Virtual Machines

## Customization

- Update [`variables.tf`](variables.tf) and [`terraform.tfvars`](terraform.tfvars) to add or modify VMs, networks, or security rules.
- All resources are parameterized for flexibility and can be extended as needed.

## Notes

- Sensitive data (like admin passwords) are stored in `terraform.tfvars`. Consider using a secure method for secrets in production.
- The project uses