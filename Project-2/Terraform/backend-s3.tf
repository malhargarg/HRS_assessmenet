terraform {
  backend "s3" {
    bucket = "terra-devops-state11"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}