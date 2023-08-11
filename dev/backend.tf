terraform {
  backend "s3" {
    bucket = "my-tfstate-bucket"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
