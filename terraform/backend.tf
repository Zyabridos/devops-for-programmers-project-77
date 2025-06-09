terraform {
  backend "s3" {
    bucket = "terraform-learning-nina-ziabrina"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}