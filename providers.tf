terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50.0"
    }
  }
  required_version = "> 1.0.0, < 2"
}

provider "aws" {
  region = "eu-west-2"
}
