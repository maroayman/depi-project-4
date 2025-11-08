# AWS EC2 Infrastructure Deployment
![Terraform](https://img.shields.io/badge/Terraform-v1.x-7B42BC?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?logo=amazon-aws&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Active-success)

## Project Overview

This project uses Terraform — the Infrastructure-as-Code (IaC) tool — to quickly deploy an Amazon EC2 instance on AWS. It provides a reusable and version-controlled setup allowing you to spin up an EC2 instance (and associated infrastructure) with minimal manual steps.

## Key Features

- **Declarative Infrastructure**: HCL files (`main.tf`, `variables.tf`, `outputs.tf`) define the infrastructure
- **Configurability**: Customizable via variables for different environments
- **Output Management**: Capture instance details like public IP address
- **Repeatable Deployment**: Quick provisioning and teardown of infrastructure
- **Version Controlled**: All infrastructure code tracked in Git

## Repository Structure

```
.
├── diagrams/           # Architecture diagram(s)
├── user_data/          # Optional user-data scripts for EC2 instance bootstrap
├── main.tf             # Primary Terraform configuration
├── variables.tf        # Variable definitions and defaults
├── outputs.tf          # Outputs returned after apply
├── terraform.lock.hcl  # Terraform dependency lock file
└── .gitignore          # Files/folders to exclude from Git
```

## Prerequisites

Before running this project, you'll need:

- **AWS Account** with permissions to create EC2 instances (and possibly VPC, security groups, IAM roles)
- **Terraform** installed (version >= required version) on your local CLI
- **AWS CLI** (optional but helpful) with configured credentials/profile for Terraform
- **Selected AWS Region** and optionally an SSH key-pair for EC2 instance access

> **Cost Warning**: Ensure you understand the AWS free-tier and potential cost implications when running EC2 instances.

## Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/maroayman/depi-project-4.git
cd depi-project-4
```

### 2. Generate SSH Key Pair for EC2 Instance Access

```bash
# Generate a new SSH key pair (if you don't have one already)
ssh-keygen -t rsa -b 4096 -f ./terraform-key -N ""

# Set appropriate permissions
chmod 400 terraform-key
chmod 400 terraform-key.pub
```

**Note**: The `terraform-key` (private key) will be used to SSH into the EC2 instance, and the public key (`terraform-key.pub`) will be deployed to the instance.

### 3. Configure AWS Credentials

```bash
# Option 1: AWS CLI configuration
aws configure

# Option 2: Environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### 4. Initialize Terraform

```bash
terraform init
```

## Usage

### Plan Deployment

```bash
terraform plan
```

### Apply Configuration

```bash
terraform apply
```

### Destroy Infrastructure

```bash
terraform destroy
```

## SSH Key Management

### Using the Generated Key to Connect

After deployment, use the generated private key to SSH into your EC2 instance:

```bash
ssh -i terraform-key ec2-user@<instance-public-ip>
```

### Security Best Practices

- Keep your private key (`terraform-key`) secure and never commit it to version control
- The `.gitignore` file should already exclude `terraform-key*` files
- Consider using a passphrase for additional security
- Rotate keys regularly in production environments

## Configuration

Modify the `variables.tf` file to customize your deployment:

- **Instance Type**: Change the EC2 instance specifications
- **Region**: Set your preferred AWS region
- **AMI**: Specify the Amazon Machine Image
- **Security Groups**: Configure network access rules
- **Key Pair**: Ensure the key pair name matches your generated keys

## Outputs

After successful deployment, Terraform will output:

- EC2 Instance Public IP address
- Instance ID
- Availability Zone
- SSH connection command (if configured in outputs)
- (Additional outputs as defined in `outputs.tf`)

## Customization

### Adding User Data Scripts

Place your bootstrap scripts in the `user_data/` directory and reference them in your Terraform configuration.

### Modifying Infrastructure

Edit the `main.tf` file to add additional AWS resources or modify existing ones.

## Security Notes

- Ensure proper IAM roles and permissions are configured
- Use secure methods for handling secrets and credentials
- Regularly update and patch your EC2 instances
- Review security group rules to minimize exposure
- Never commit private keys to version control
- Use different key pairs for different environments

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

[Add your license information here]

## Support

If you encounter any issues or have questions, please open an issue in the GitHub repository.

---

**Note**: Always run `terraform plan` before `terraform apply` to review changes and avoid unexpected infrastructure modifications. Ensure your SSH key pair is properly generated and secured before deployment.
