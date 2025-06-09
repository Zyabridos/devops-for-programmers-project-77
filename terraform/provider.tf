provider "aws" {
  region = var.aws_region
}

data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

data "aws_availability_zones" "available" {}

terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.34.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}