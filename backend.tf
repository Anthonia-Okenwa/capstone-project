terraform {
  backend "s3" {
    bucket = "anthonia-capstone-terraform-state"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}

