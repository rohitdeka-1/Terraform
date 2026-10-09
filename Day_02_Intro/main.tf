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

resource "aws_s3_bucket" "abhinavBucketName" {
  bucket = "rohitdekacnbucketasdasdasdasd"
  tags = {
    "Env" : "Dev"
  }
}



# resource "aws_ec2" "name" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"

#   tags = {
#     Name        = "my-instance-rhd-unique-name"
#     Environment = "Dev"
#   }
# }

