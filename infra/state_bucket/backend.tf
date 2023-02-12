provider "aws" {

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
