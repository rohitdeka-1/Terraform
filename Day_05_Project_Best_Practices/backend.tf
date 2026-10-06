terraform {
  backend "s3" {
    bucket       = "$new-backend-rohitdeka-001"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}
