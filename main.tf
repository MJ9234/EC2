provider "aws" {
  region = "us-east-1"
}

module "users" {
  source          = "../modules"
}
