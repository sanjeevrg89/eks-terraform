data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_availability_zones" "available" {
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.12"
}

module "vpc" {
  source               = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc"
  name                 = var.vpcname
  cidr                 = var.cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  source               = "git::https://github.com/terraform-aws-modules/terraform-aws-eks"
  cluster_name         = local.cluster_name
  cluster_version      = var.cluster_version
  subnets              = module.vpc.private_subnets
  vpc_id               = module.vpc.vpc_id

  node_groups          = {
    ng1 = {
      desired_capacity = 3
      max_capacity     = 3
      min_capacity     = 3
      instance_type    = "var.instance_type1"
    }
    ng2 = {
      desired_capacity = 3
      max_capacity     = 3
      min_capacity     = 3
      instance_type    = "var.instance_type2"
    }
  }

  write_kubeconfig     = true
}