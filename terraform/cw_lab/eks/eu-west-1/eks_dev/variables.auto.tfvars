###############
# EKS CLUSTER #
###############
cluster_name        = "EKS_DEV"
eks_cluster_version = 1.29
environment         = "dev"
aws_region          = "eu-west-1"
profile_name        = "cwlab"

vpc_id              = "vpc-0e73adf672551e277"
vpc_private_subnets_id = [
  "subnet-0fd0e166211ba2394",
  "subnet-0757ae0dda0537e06",
  "subnet-03082b884735d7423",
]

cluster_endpoint_public_access_cidrs = [
  "82.36.112.224/32", #home network
  "62.6.249.84/32" #home network 2
]

cluster_addons = {
  coredns = {
    most_recent = true
  }
  kube-proxy = {
    most_recent = true
  }
  vpc-cni = {
    most_recent = true
  }
  aws-ebs-csi-driver = {
    most_recent = true
  }
}


#########################
# EKS NODE GROUP CONFIG #
#########################
eks_managed_node_groups = {
  Worker_Nodes = {
    min_size       = 3
    max_size       = 3
    desired_size   = 3
    instance_types = ["t2.medium"]
    capacity_type  = "ON_DEMAND"
    labels         = {}
    taints         = {}
  }
}


###########################
# EKS NODE SECURITY GROUP #
###########################
# node_security_group_additional_rules = {
#   allow_myapp_alb = {
#     type                          = "ingress"
#     from_port                     = 0
#     to_port                       = 65535
#     protocol                      = "tcp"
#     cidr_blocks                   = []
#     security_groups               = []
#     prefix_list_ids               = []
#     description                   = "master to access nodes any port"
#     source_cluster_security_group = false
#   }
# }

