module "configuration" {
  source = "./modules/configuration"

  CIDR_BLOCK_16 = var.CIDR_BLOCK_16
  CIDR_BLOCK_0  = var.CIDR_BLOCK_0
  AWS_REGION    = var.AWS_REGION
}


module "application" {
  source            = "./modules/application"
  AWS_REGION        = var.AWS_REGION
  AMIS              = var.AMIS
  INSTANCE_TYPE     = var.INSTANCE_TYPE
  PATH_TO_PUBLICKEY = var.PATH_TO_PUBLICKEY
  CIDR_BLOCK_16     = var.CIDR_BLOCK_16
  CIDR_BLOCK_0      = var.CIDR_BLOCK_0
  VPC_ID            = module.configuration.xyz-vnet
}
