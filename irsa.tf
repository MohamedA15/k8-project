###########################################
# CERT-MANAGER IRSA (DNS01 via Route53)
###########################################
module "cert_manager_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.30.0"

  create_role = true
  role_name   = "cert-manager"

  # Correct for EKS module v20
  provider_urls = [
    module.eks.cluster_oidc_issuer_url
  ]

  # Route53 DNS permissions (broad – replace later with restricted)
  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  ]

  # Kubernetes service account identity
  oidc_fully_qualified_subjects = [
    "system:serviceaccount:cert-manager:cert-manager"
  ]

  tags = local.tags
}

###########################################
# EXTERNAL-DNS IRSA (Route53)
###########################################
module "external_dns_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.30.0"

  create_role = true
  role_name   = "external-dns"

  provider_urls = [
    module.eks.cluster_oidc_issuer_url
  ]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  ]

  oidc_fully_qualified_subjects = [
    "system:serviceaccount:external-dns:external-dns"
  ]

  tags = local.tags
}
