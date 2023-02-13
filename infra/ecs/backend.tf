terraform {
  backend "s3" {
    key    = "books-pyapi/terraform.tfstate"
    region = "eu-central-1"
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
