### Hexlet tests and linter status:
[![Actions Status](https://github.com/Zyabridos/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Zyabridos/devops-for-programmers-project-77/actions)

# Terraform Web App Infrastructure

This project provisions infrastructure for a web application using Terraform.

## What it deploys
- Two EC2 web servers
- HTTPS Load Balancer
- PostgreSQL Database as a service

## Requirements
- Terraform >= 1.3
- AWS account with permissions
- AWS CLI configured

## Usage

```bash
make init
make apply
To destroy:
```
```bash
make destroy
```

## Notes
Remote backend should be configured in provider.tf using S3 + DynamoDB
SSL certificate must be requested via ACM (Amazon Certificate Manager)