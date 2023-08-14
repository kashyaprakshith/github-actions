terraform {
  required_version = ">= 0.15.0"  # Specify the required Terraform version
  required_providers {
    aws = ">= 3.0.0"  # Specify the required AWS provider version
  }
}

provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-example-bucket"  # Change to your desired bucket name
  acl    = "private"            # Access control for the bucket (private, public-read, etc.)

  tags = {
    Name = "ExampleBucket"
  }
}
