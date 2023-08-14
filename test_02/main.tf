terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = ">= 3.0.0"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-example-bucket"
  acl    = "invalid_acl_value"  # Intentional error here

  tags = {
    Name = "ExampleBucket"
  }
}
