resource "helm_release" "alb-controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.7.1"
  namespace  = "kube-system"
  depends_on = [
    module.eks,
    kubernetes_service_account.service-account
  ]

  values = [
    <<-EOF
    region: "${var.aws_region}"
    vpcId: "${var.vpc_id}"
    image:
      repository: "602401143452.dkr.ecr.${var.aws_region}.amazonaws.com/amazon/aws-load-balancer-controller"
    serviceAccount:
      create: false
      name: "aws-load-balancer-controller"
    clusterName: "${var.cluster_name}"
    EOF
  ]
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.34.6"
  create_namespace = true
  namespace        = "argocd"
  depends_on = [
    module.eks,
    helm_release.alb-controller
  ]

  values = [
    "${file("helm/argocd/values.yaml")}"
  ]
}

resource "helm_release" "bitnami-sealed-secrets" {
  name       = "bitnami-sealed-secrets"
  repository = "https://bitnami-labs.github.io/sealed-secrets"
  chart      = "sealed-secrets"
  namespace  = "kube-system"
  depends_on = [
    module.eks
  ]
}