# The Multi-Environment 3-Tier Architecture

**The Goal:** Build a secure, highly-available web application infrastructure that can be deployed to both a `dev` and `prod` environment using the exact same code, automated via GitHub Actions.

## Phase 1: The Foundation (Networking Module) - ✅ COMPLETED

In this phase, we built a reusable VPC module that dynamically scales across Availability Zones.

- [x] Create a custom `vpc` module structure (`main.tf`, `variables.tf`, `outputs.tf`).
- [x] Use `aws_vpc` to create the main network.
- [x] Use `count` and `data.aws_availability_zones` to dynamically create Public and Private subnets across multiple AZs.
- [x] Create an Internet Gateway and Public Route Table for public internet access.
- [x] Create an Elastic IP, NAT Gateway, and Private Route Table to allow private subnets to download packages securely.
- [x] Call the module from the root `main.tf` and pass dynamic variables (`vpc_cidr`, `public_subnets`, `private_subnets`).

## Phase 2: The Data Layer (Database & Security) - 🚧 NEXT

Build the secure backend hidden from the internet.

- [ ] Create a `database` module.
- [ ] Create Security Groups (Database SG only allows traffic from Compute SG).
- [ ] Deploy an AWS RDS instance (MySQL/PostgreSQL) inside the Private Subnets.
- [ ] Use Terraform `random_password` and AWS Secrets Manager / SSM to generate and store the database password securely.

## Phase 3: The Compute Layer (Load Balancing & Servers)

Serve the traffic securely and highly available.

- [ ] Create a `compute` module.
- [ ] Create an Application Load Balancer (ALB) in the Public Subnets.
- [ ] Create an Auto Scaling Group (ASG) in the Private Subnets.
- [ ] Write a `user_data` bash script to install a web server (e.g., Apache/Nginx) on boot and connect it to RDS.

## Phase 4: Multi-Environment (Dev vs Prod)

Deploy multiple environments without rewriting code.

- [ ] Create `dev.tfvars` and `prod.tfvars` files.
- [ ] Override variables to deploy smaller instances in Dev (`db.t3.micro`, 1 server) and larger instances in Prod (`db.t3.large`, 2 servers).

## Phase 5: CI/CD Automation (The Interview Closer)

Throw away your laptop terminal and automate deployments.

- [ ] Set up an S3 Remote Backend and DynamoDB state locking.
- [ ] Push code to a GitHub repository.
- [ ] Write a GitHub Actions workflow (`.yml`) to automatically run `terraform plan` on Pull Requests and `terraform apply` on merge to `main`.
