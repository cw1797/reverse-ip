variable vpc_id {
  type    = string
  default = ""
}

variable vpc_private_subnets_id {
  type    = list(string)
  default = []
}

variable environment {
  type    = string
  default = ""
}

variable aws_region {
  type    = string
  default = ""
}

variable profile_name {
  type    = string
  default = ""
}

variable cluster_name {
  type    = string
  default = ""
}

variable eks_cluster_version {
  type    = string
  default = ""
}

variable cluster_endpoint_public_access_cidrs {
  type    = list(string)
  default = []
}

variable access_entries {
  type = map(object({
    kubernetes_groups = list(string)
    principal_arn     = string

    policy_associations = map(object({
      policy_arn = string
      access_scope = object({
        type = string
      })
    }))
  }))
  default = {}
}


variable eks_managed_node_groups {
  type = map(object({
    min_size       = number
    max_size       = number
    desired_size   = number
    instance_types = list(string)
    labels         = map(string)
  }))
  default = {}
}

variable iam_role_additional_policies {
  type    = list(string)
  default = []
}

variable cluster_security_group_additional_rules {
  type = map(object({
    type                          = string
    protocol                      = string
    from_port                     = number
    to_port                       = number
    cidr_blocks                   = list(string)
    source_security_group_id      = string
    prefix_list_ids               = list(string)
    description                   = string
    source_cluster_security_group = bool
  }))
  default = {}
}

variable node_security_group_additional_rules {
  type = map(object({
    type            = string
    protocol        = string
    from_port       = number
    to_port         = number
    cidr_blocks     = list(string)
    security_groups = list(string)
    prefix_list_ids = list(string)
    description     = string
    self            = bool
  }))
  default = {}
}

variable cluster_addons {
  type = map(object({
    most_recent = bool
  }))
  default = {}
}
