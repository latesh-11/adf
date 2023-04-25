module "vpc_modules" {

  source = "./modules/aws_vpc"

  for_each = var.vpc_config

  cidr_block = each.value.cidr_block

  tags = each.value.tags


}

module "subnet_module" {

  source = "./modules/aws_subnets"

  for_each = var.subnet_config

  cidr_block = each.value.cidr_block

  tags = each.value.tags

  vpc_id = module.vpc_modules[each.value.vpc_name].vpc_id # we call module.vpc_modules because we need to connect (aws_vpc) to (aws_subnet) / to validate the vpc_id

  availability_zone = each.value.availability_zone

}

module "internetGW_module" {

  source = "./modules/aws_internetGW"

  for_each = var.internetGW_config

  vpc_id = module.vpc_modules[each.value.vpc_name].vpc_id

  tags = each.value.tags

}

module "natGW_module" {

  source = "./modules/aws_natGW"

  for_each = var.natGW_config

  elasticIP-id = module.elasticIP_module[each.value.epi_name].elastic_ip_id # .elastic_ip_id is an output

  subnet_id = module.subnet_module[each.value.subnet_name].subnet_id

  tags = each.value.tags


}

module "elasticIP_module" {

  source = "./modules/aws_elastic_IP"

  for_each = var.elasticIP_config

  tags = each.value.tags

}

module "route_table_module" {

  source = "./modules/aws_route_table"

  for_each = var.route_table_config

  vpc_id = module.vpc_modules[each.value.vpc_name].vpc_id

  tags = each.value.tags
  # ?=then , :=else
  internetGW_id = each.value.private == 0 ? module.internetGW_module[each.value.gateway_name].internetGW_id : module.natGW_module[each.value.gateway_name].natGW_id


}

module "route_table_association_module" {

  source = "./modules/aws_route_table_association"

  for_each = var.route_table_association_config

  subnet_id = module.subnet_module[each.value.subnet_name].subnet_id

  route_table_id = module.route_table_module[each.value.route_name].route_table_id
}

module "eks_cluster_module" {

  source = "./modules/aws_eks"

  for_each = var.eks_cluster_config

  eks_cluster_name = each.value.eks_cluster_name

  subnet_ids = [module.subnet_module[each.value.subnet1].subnet_id, module.subnet_module[each.value.subnet2].subnet_id, module.subnet_module[each.value.subnet3].subnet_id, module.subnet_module[each.value.subnet4].subnet_id]

  tags = each.value.tags

}

module "eks_nodegroup_module" {

  source = "./modules/aws_eks_nodegroup"

  for_each = var.eks_nodegroup_config

  eks_cluster_name = each.value.eks_cluster_name

  node_group_name = each.value.node_group_name

  iam_role_node = each.value.iam_role_node

  subnet_ids = [module.subnet_module[each.value.subnet1].subnet_id, module.subnet_module[each.value.subnet2].subnet_id]

  tags = each.value.tags
}

