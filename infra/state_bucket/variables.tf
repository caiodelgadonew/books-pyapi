variable "state_bucket" {
  type        = string
  description = "Bucket name to be created for the terraform state"
}

variable "name" {
  description = "Name of the Application"
  default     = "books-pyapi"
}

variable "env" {
  description = "Environment of the Application"
  default     = "dev"
}

variable "squad" {
  description = "Owner Squad of the Application"
  default     = "devops-squad"
}
