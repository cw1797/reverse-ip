module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.3.0"

  cluster_name    = var.cluster_name
  cluster_version = var.eks_cluster_version

  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_addons                       = var.cluster_addons
  access_entries                       = var.access_entries

  vpc_id                   = var.vpc_id
  subnet_ids               = var.vpc_private_subnets_id
  control_plane_subnet_ids = var.vpc_private_subnets_id

  eks_managed_node_groups                 = var.eks_managed_node_groups
  create_node_security_group              = true
  cluster_security_group_additional_rules = var.cluster_security_group_additional_rules
  node_security_group_additional_rules    = var.node_security_group_additional_rules

  enable_cluster_creator_admin_permissions = true
  cluster_encryption_config                = {}

  tags = {
    Terraform   = "true",
    Environment = var.environment
  }
}

module "lb_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  depends_on = [
    module.eks
  ]

  role_name                              = "${var.cluster_name}_eks_lb"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}

resource "kubernetes_service_account" "service-account" {
  depends_on = [
    module.eks,
    module.lb_role
  ]
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
      "app.kubernetes.io/component" = "controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn"               = module.lb_role.iam_role_arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}

