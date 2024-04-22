data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.2"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs                 = data.aws_availability_zones.azs.names
  private_subnets     = var.vpc_private_subnets
  private_subnet_tags = var.private_subnet_tags

  public_subnets     = var.vpc_public_subnets
  public_subnet_tags = var.public_subnet_tags

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  reuse_nat_ips       = var.reuse_nat_ips
  external_nat_ip_ids = aws_eip.nat_eip.*.id

  tags = {
    Terraform = "true"
  }
}

#https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest#external-nat-gateway-ips
resource "aws_eip" "nat_eip" {
  count  = length(data.aws_availability_zones.azs.names)
  domain = "vpc"

  tags = {
    Terraform = "true"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}
