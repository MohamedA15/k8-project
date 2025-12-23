locals {
  name   = "eks-lab"
  domain = "lab.moamiin.org"
  region = "eu-west-2"

  tags = {
    Owner       = "Moamiin"
    Environment = "sandbox"
    Project     = "EKS Lab"
  }

}