# Terraform AWS Infrastructure Project

## 📌 Overview

This project provisions AWS infrastructure using **Terraform**.\
It demonstrates how to structure Terraform code with **modules** for
better reusability and maintainability.

The setup includes: - VPCs and subnets - EC2 instances - IAM roles and
policies - CloudWatch logging - S3 bucket for log storage

------------------------------------------------------------------------

## 🗂 Project Structure

    .
    ├── main.tf               # Root module entry point
    ├── variables.tf          # Variable definitions
    ├── outputs.tf            # Root outputs
    ├── terraform.tfvars      # Variable values (default input file)
    ├── modules/
    │   ├── vpc/
    │   │   ├── variables.tf
    │   │   ├── resources.tf
    │   │   ├── outputs.tf
    │   ├── ec2/
    │   │   ├── variables.tf
    │   │   ├── resources.tf
    │   │   ├── outputs.tf
    │   ├── subnets/
    │   │   ├── variables.tf
    │   │   ├── resources.tf
    │   │   ├── outputs.tf
    │   └── iam/
    │       ├── variables.tf
    │       ├── resources.tf
    │       ├── outputs.tf

------------------------------------------------------------------------

## 🔄 Variable Flow

1.  **Declare variables** in `variables.tf`.

2.  **Assign values** in `terraform.tfvars` (or via CLI/environment
    variables).

3.  **Root module** (`main.tf`) consumes the variables.

4.  **Pass variables explicitly** to child modules:

    ``` hcl
    module "vpc" {
      source       = "./modules/vpc"
      project_name = var.project_name
      vpc_cidr     = var.vpc_cidr
    }
    ```

5.  **Child modules** use their own `variables.tf` to accept values.

6.  **Outputs** from modules are returned back to the root via
    `outputs.tf`.

------------------------------------------------------------------------

## ▶️ Usage

### 1. Initialize Terraform

``` sh
terraform init
```

### 2. Review the execution plan

``` sh
terraform plan
```

### 3. Apply the configuration

``` sh
terraform apply
```

### 4. Destroy infrastructure

``` sh
terraform destroy
```

------------------------------------------------------------------------

## ⚙️ Configuration

Customize values in **`terraform.tfvars`**:

``` hcl
project_name = "aws-infra-project"
aws_region   = "us-east-1"

vpc_cidr     = "10.0.0.0/16"
subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

instance_type = "t3.micro"
key_name      = "my-ssh-key"
```

------------------------------------------------------------------------

## 📊 Variable Flow Diagram

![Terraform Variable Flow](./docs/terraform-variable-flow.png)

------------------------------------------------------------------------

## ✅ Best Practices

-   Use **modules** for reusability.
-   Store sensitive values in a **remote backend** (e.g., S3 + DynamoDB
    for state locking).
-   Use **workspaces** for different environments (dev, staging, prod).
-   Version control your `.tf` files, but **do not commit
    `terraform.tfstate`**.
