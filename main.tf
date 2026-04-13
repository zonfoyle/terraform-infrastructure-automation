# -------------------------------
# Configure AWS Provider
# -------------------------------

# This tells Terraform to use AWS
# and which region to deploy resources in

provider "aws" {
  region = "us-east-1"
}

# -------------------------------
# Create VPC
# -------------------------------

# This creates a basic VPC in AWS
# CIDR block 10.0.0.0/16 provides the private network range

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "terraform-practice-vpc"
    Environment = "dev"
    Project     = "terraform-infrastructure-automation"
  }
}
# -------------------------------
# Create Subnet
# -------------------------------

# This creates a subnet inside the VPC
# The subnet uses part of the VPC CIDR range

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"   
  map_public_ip_on_launch = true

  tags = {
    Name        = "terraform-public-subnet"
    Environment = "dev"
    Project     = "terraform-infrastructure-automation"
  }
}
# -------------------------------
# Create Internet Gateway
# -------------------------------

# This creates an Internet Gateway and attaches it to the VPC

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "terraform-internet-gateway"
    Environment = "dev"
    Project     = "terraform-infrastructure-automation"
  }
}
# -------------------------------
# Create Route Table
# -------------------------------

# This creates a route table inside the VPC

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "terraform-public-route-table"
    Environment = "dev"
    Project     = "terraform-infrastructure-automation"
  }
}

# -------------------------------
# Add Internet Route
# -------------------------------

# This sends all outbound traffic to the Internet Gateway

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# -------------------------------
# Associate Route Table with Subnet
# -------------------------------

# This makes the subnet use the public route table

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
# -------------------------------
# Create Security Group
# -------------------------------

# This security group allows SSH access to the EC2 instance

resource "aws_security_group" "ec2_sg" {
  name        = "terraform-ec2-security-group"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.main.id

    ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "terraform-ec2-security-group"
    Environment = "dev"
    Project     = "terraform-infrastructure-automation"
  }
}
# -------------------------------
# Launch EC2 Instance
# -------------------------------

# This launches an EC2 instance in the public subnet

resource "aws_instance" "web" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = "ec2-practice-key"
  associate_public_ip_address = true

  tags = {
    Name        = "terraform-ec2-instance"
    Environment = "dev"
    Project     = "terraform-infrastructure-automation"
  }
}