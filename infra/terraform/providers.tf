provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "LMS-2026"
      Environment = "dev"
      ManagedBy   = "Terraform"
      Laboratory  = "lab09"
    }
  }
}
