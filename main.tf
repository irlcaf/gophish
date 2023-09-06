terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket  = var.bucket
    key     = var.key
    region  = var.region
    profile = "default"
  }
}

module "gophish" {
  source = "./gophish/"
}

output "gophish_server_ip" {
  value = "https://${module.gophish.server_ip}:3333"
}
