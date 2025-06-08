variable "aws_region" {
  description = "AWS region to deploy to"
  default     = "eu-north-1"
}

# variable "acm_certificate_arn" {
#   description = "ARN of the ACM certificate for HTTPS listener"
#   type        = string
# }

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
} 

variable "datadog_api_key" {
  type      = string
  sensitive = true
}

variable "datadog_app_key" {
  type      = string
  sensitive = true
}
