provider "aws" {
  region = "ap-northeast-2"
}

data "terraform_remote_state" "main" {
  backend = "local"
  config = {
    path = "../before_migration/terraform.tfstate"
  }
}
