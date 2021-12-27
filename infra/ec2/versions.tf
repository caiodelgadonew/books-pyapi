# Version of Terraform CLI set to 1.1.2 and rightmost
# increment since Terraform CLI v1.1.0 and v1.1.1 
# both have a bug where a failure to construct the 
# apply-time graph can cause Terraform to incorrectly 
# report success and save an empty state, effectively 
# "forgetting" all existing infrastructure. 

# In the creation of this code I found that the issue is 
# not fixed on version 1.1.2, So I'm setting the Terraform
# CLI version to 1.0.0 and rightmost

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.70.0"
    }
  }
  required_version = "~> 1.0.0"
}
