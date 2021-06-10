terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.15.4"
}

provider "aws" {
  region  = "us-east-1"
}