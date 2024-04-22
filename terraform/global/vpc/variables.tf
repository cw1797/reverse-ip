variable "profile_name" {
  type    = string
  default = ""
}

variable "vpc_name" {
  type    = string
  default = ""
}

variable "vpc_cidr" {
  type    = string
  default = ""
}

variable "vpc_private_subnets" {
  type    = list(string)
  default = []
}

variable "vpc_public_subnets" {
  type    = list(string)
  default = []
}

variable "private_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "public_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "aws_region" {
  type    = string
  default = ""
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "single_nat_gateway" {
  type    = bool
  default = false
}

variable "one_nat_gateway_per_az" {
  type    = bool
  default = true
}

variable "reuse_nat_ips" {
  type    = bool
  default = true
}
