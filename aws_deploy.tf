
# AWS Terraform Deployment for SaaSgenix Infra-as-Code Agent

provider "aws" {
  region = "us-west-2"
}

resource "aws_ecr_repository" "saasgenix_repo" {
  name = "saasgenix-agent"
}

resource "aws_eks_cluster" "saasgenix_cluster" {
  name     = "saasgenix-cluster"
  role_arn = "arn:aws:iam::123456789012:role/EKSRole"
  vpc_config {
    subnet_ids = ["subnet-abc123", "subnet-def456"]
  }
}
