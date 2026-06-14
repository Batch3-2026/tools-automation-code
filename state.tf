terraform {
  backend "s3" {
    bucket         = "batch-03-tools"
    key            = "tools/terraform.tfstate"
    region         = "us-east-1"
  }
}