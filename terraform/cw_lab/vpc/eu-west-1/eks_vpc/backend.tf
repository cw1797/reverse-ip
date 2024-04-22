terraform {
  backend "s3" {
    bucket         = "tfstate-cwlab"
    key            = "vpc/eks_vpc/tfstate"
    region         = "eu-west-1"
    profile        = "cwlab"
    dynamodb_table = "terraform_state_lock"
  }
}
