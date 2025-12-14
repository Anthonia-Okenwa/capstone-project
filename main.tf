############################################
# VPC MODULE
############################################

module "vpc-deployment" {
  source = "./module-vpc"

  environment         = var.environment
  vpc_cidrblock       = var.vpc_cidrblock
  countsub            = var.countsub
  create_subnet       = var.create_subnet
  create_elastic_ip   = var.create_elastic_ip
}

############################################
# EKS MODULE
############################################

module "eks-deployment" {
  source = "./module-eks"

  environment     = var.environment
  cluster_name    = var.cluster_name
  eks_version     = var.eks_version
  repository_name = var.repository_name

  desired_size   = var.desired_size
  min_size       = var.min_size
  max_size       = var.max_size
  instance_types = var.instance_types
  capacity_type  = var.capacity_type
  ami_type       = var.ami_type

  # REQUIRED by module-eks
  public_subnet_ids  = module.vpc-deployment.public_subnet_ids
  private_subnet_ids = module.vpc-deployment.private_subnet_ids

  # TLS / DNS
  domain-name = var.domain_name
  email       = var.email
}

############################################
# ROUTE 53 HOSTED ZONE
############################################

resource "aws_route53_zone" "r53_zone" {
  name = var.domain_name
}

############################################
# LOOK UP LOAD BALANCER CREATED BY INGRESS
############################################

data "aws_lb" "nginx_ingress" {
  tags = {
    "kubernetes.io/service-name" = "ingress-nginx/nginx-ingress-ingress-nginx-controller"
  }

  depends_on = [
    module.eks-deployment
  ]
}

############################################
# ROUTE 53 RECORD (ALIAS → INGRESS LB)
############################################

resource "aws_route53_record" "app_record" {
  zone_id = aws_route53_zone.r53_zone.zone_id
  name    = "app.${var.domain_name}"
  type    = "A"

  alias {
    name                   = data.aws_lb.nginx_ingress.dns_name
    zone_id                = data.aws_lb.nginx_ingress.zone_id
    evaluate_target_health = true
  }
}
