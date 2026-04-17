# 🚀 Terraform Infrastructure Automation

🔗 Live App: http://44.199.208.243

Provisioned AWS infrastructure using Terraform, including networking, security, and compute resources, and deployed a live web server accessible via public IP.

---

## 📌 Overview

This project demonstrates Infrastructure as Code (IaC) by automating the creation of a complete AWS environment using Terraform.

The system provisions a fully functional cloud architecture and deploys a web server that can be accessed from the internet.

---

## 🏗️ Architecture

Internet
↓
Internet Gateway
↓
Route Table (0.0.0.0/0 → IGW)
↓
Public Subnet
↓
EC2 Instance (Apache Web Server)

---

## ⚙️ Tech Stack

* Terraform
* AWS (VPC, EC2, Networking)
* Amazon Linux 2
* Apache (httpd)

---

## Design Decisions & Tradeoffs

### Why Terraform instead of manually creating resources in the AWS Console?

I chose Terraform because it allows infrastructure to be defined as code, making the environment repeatable, version-controlled, and easier to maintain.

Tradeoff:
- Terraform requires more setup initially
- The AWS Console is faster for quick testing, but harder to reproduce consistently

### Why create a public subnet?

The EC2 instance needed to be accessible from the internet so I could SSH into it and access the web server through a browser.

Tradeoff:
- Public subnets make resources accessible externally
- Private subnets are more secure, but would require a bastion host or load balancer for access

### Why use an Internet Gateway and route table?

The Internet Gateway allows internet traffic to reach the VPC, while the route table sends outbound traffic (`0.0.0.0/0`) from the subnet to the gateway.

Tradeoff:
- This configuration provides internet access for the EC2 instance
- Without the route table and Internet Gateway, the web server would not be reachable

### Why allow ports 22 and 80 in the security group?

- Port 22 allows SSH access for administration
- Port 80 allows HTTP traffic to reach the web server

Tradeoff:
- Opening these ports makes the instance reachable and manageable
- More open ports increase exposure, so only the minimum required ports were allowed

### Why use Terraform outputs?

Terraform outputs make it easier to retrieve important information such as the EC2 public IP and DNS after deployment.

Tradeoff:
- Outputs simplify access to key values
- Too many outputs can clutter the Terraform configuration

---

## 🚀 Features

* Automated VPC creation with DNS support
* Public subnet with internet access
* Internet Gateway and routing configuration
* Security group with SSH (22) and HTTP (80) access
* EC2 instance deployment using Terraform
* Web server installation and configuration
* Terraform outputs for public IP and DNS

---

## 📊 Outputs

After running `terraform apply`, Terraform provides:

* EC2 Public IP
* EC2 Public DNS

### Example:

```
ec2_public_ip  = "44.199.208.243"
ec2_public_dns = "ec2-44-199-208-243.compute-1.amazonaws.com"
```

---

## 🌐 Accessing the Application

### 1. SSH into the instance

```bash
ssh -i ~/.ssh/ec2-practice-key.pem ec2-user@44.199.208.243
```

### 2. Open in browser

```
http://44.199.208.243
```

### Expected Output

```
Hello from Zonique Terraform project
```

---

## 📂 Project Structure

```
terraform-infrastructure-automation/
│
├── main.tf
├── outputs.tf
├── .gitignore
└── README.md
```

---

## 🧠 Key Concepts Demonstrated

* Infrastructure as Code (IaC)
* Terraform state management
* Resource dependencies
* AWS networking (VPC, subnets, routing)
* Security group configuration
* EC2 provisioning and access
* Output variables for automation

---

## 🎯 Project Goal

This project demonstrates the transition from manual AWS configuration and boto3 automation to production-style infrastructure management using Terraform.

---

## 🔮 Future Improvements

* Add variables (`variables.tf`) for reusable configuration
* Use Terraform modules for better structure
* Add `user_data` to automate web server setup
* Deploy a multi-tier architecture (ALB + multiple EC2s)
