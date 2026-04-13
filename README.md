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
