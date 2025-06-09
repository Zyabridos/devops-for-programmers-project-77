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

// invintory.ini file template
locals {
  web_servers_block = join("\n", [
    for i, ip in aws_instance.web[*].public_ip :
    "web-${i + 1} ansible_host=${ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/new_key"
  ])
}

data "template_file" "inventory" {
  template = file("${path.module}/templates/inventory.ini.tmpl")

  vars = {
    web_servers_block = local.web_servers_block
  }
}