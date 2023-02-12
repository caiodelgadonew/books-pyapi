terraform {
  backend "s3" {
    key    = "books-py-api/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      app         = var.name
      environment = var.env
      owner       = var.squad
      provisioner = "terraform"
      vcs         = "https://github.com/caiodelgadonew/book-pyapi"
    }
  }
}
