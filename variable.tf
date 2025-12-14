############################################
# General / Environment
############################################

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
  default     = "staging"
}

############################################
# Networking (VPC)
############################################

variable "vpc_cidrblock" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "create_subnet" {
  description = "Whether to create subnets"
  type        = bool
  default     = true
}

variable "countsub" {
  description = "Number of subnets to create"
  type        = number
  default     = 2
}

variable "create_elastic_ip" {
  description = "Whether to create Elastic IPs"
  type        = bool
  default     = true
}

############################################
# EKS Cluster
############################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

variable "eks_version" {
  description = "EKS cluster Kubernetes version"
  type        = string
  default     = "1.29"
}

############################################
# EKS Node Group
############################################

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 6
}

variable "instance_types" {
  description = "EC2 instance types for worker nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  description = "Capacity type for node group (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "ami_type" {
  description = "AMI type for EKS nodes"
  type        = string
  default     = "AL2_x86_64"
}

############################################
# Container Registry (ECR)
############################################

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "eks-repository"
}

############################################
# DNS / Domain (Route 53)
############################################

variable "domain_name" {
  description = "Base domain name (e.g. example.com)"
  type        = string
}

############################################
# Certificate / Notifications
############################################

variable "email" {
  description = "Email used for TLS certificates and alerts"
  type        = string
}

############################################
# Database (RDS)
############################################

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS (GB)"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "production_db"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}
