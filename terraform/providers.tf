provider "aws" {
  region = var.aws_vpc_region
}

terraform {
  backend "s3" {
    region  = var.aws_s3_region
    bucket  = ""
    key     = "${var.s3_bucket_uri}-rabbitmq.tfstate"
    encrypt = true
  }
}
