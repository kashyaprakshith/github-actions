terraform {
  required_version = ">= 0.15.0"
}

provider "aws" {
  region = "invalid-region-value"  # Intentional error here
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-example-bucket"
  acl    = "private"

  tags = {
    Name = "ExampleBucket"
  }
}
