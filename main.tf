# Example: Secure S3 bucket configuration
# All security checks pass for this module

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws"; version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.aws_region
}

module "secure_s3" {
  source        = "./modules/s3-secure"
  bucket_name   = "${var.project}-${var.environment}-data"
  environment   = var.environment
  project       = var.project
  allowed_roles = var.allowed_iam_roles
}
