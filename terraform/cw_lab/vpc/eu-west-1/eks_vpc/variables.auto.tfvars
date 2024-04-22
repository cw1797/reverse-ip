##############
# VPC CONFIG #
##############
aws_region   = "eu-west-1"
profile_name = "cwlab"

vpc_name = "EKS_VPC"
vpc_cidr = "10.16.0.0/16"

enable_nat_gateway     = true
single_nat_gateway     = false
one_nat_gateway_per_az = true
reuse_nat_ips          = true

vpc_public_subnets = [
  "10.16.0.0/22", #NATGW AZ1
  "10.16.4.0/22", #NATGW AZ2
  "10.16.8.0/22", #NATGW AZ3
]

vpc_private_subnets = [
  "10.16.12.0/22", #EKS-DEV
  "10.16.16.0/22", #EKS-DEV
  "10.16.20.0/22", #EKS-DEV
]

public_subnet_tags = {
  "kubernetes.io/role/elb" = "1"
}

private_subnet_tags = {
  "kubernetes.io/role/internal-elb" = "1"
}
