terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

#create a resource
resource "s3_bucket" "my_bucket" {
  bucket = "my-bucket-rhd-unique-name"

}

