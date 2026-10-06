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

#create s3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "rhd-deka-001"
  tags = {
    Name        = "my-bucket-rhd-unique-name"
    Environment = "Dev"
  }
}

resource "aws_ec2" "name" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name        = "my-instance-rhd-unique-name"
    Environment = "Dev"
  }
}

