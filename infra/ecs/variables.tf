variable "state_bucket" {
    type = string
    description = "Bucket created for the terraform state"
}

variable "region" {
  description = "Define what region the instance will be deployed"
  default     = "eu-central-1"
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

variable "instance_type" {
  description = "AWS Instance type defines the hardware configuration of the machine"
  default     = "t3a.micro"
}


variable "container_image" {
  description = "Container image to be used by the service"
  default     = "caiodelgadonew/books-pyapi"
}


variable "app_ports" {
  description = "Required Application TCP ports"
  default     = ["9000"]
}

variable "tcp_ports" {
  description = "Required Ingress TCP ports"
  default     = ["80"]
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks that are allowed to access the instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
