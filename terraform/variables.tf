variable "aws_region" {
  description = "AWS region to deploy to"
  default     = "eu-north-1"
}
variable "db_username" {
  description = "Username for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
} 

variable "aws_secret_access_key" {
  type        = string
  sensitive   = true
}

variable "aws_access_key_id" {
  type        = string
  sensitive   = true
}

variable "certificate_id" {
  type        = string
  sensitive   = true
} 

variable "ssh_key" {
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
