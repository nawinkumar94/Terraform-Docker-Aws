terraform {
  backend "s3" {
    bucket  = "terraform-state-4294"
    key     = "terraform.tfstate" # Created a s3 bucket to store remote state
    region  = "us-east-1"
    encrypt = true
  }
}
