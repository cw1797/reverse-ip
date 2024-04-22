terraform {
  backend "s3" {
    bucket         = "tfstate-cwlab"
    key            = "eks/eks_dev/tfstate"
    region         = "eu-west-1"
    profile        = "cwlab"
    dynamodb_table = "terraform_state_lock"
  }
}
