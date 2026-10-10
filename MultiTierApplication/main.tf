module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"] // this will override the variables passed. lets say we can use it in different env like prod and dev
}
//Variables in a module act like function arguments in programming. You can define defaults, but passing them explicitly is what makes modules so powerful and dynamic.


module "database" {
  source = "./modules/database"

  vpc_id             = module.vpc.vpc_id
  vpc_cidr_block     = "10.0.0.0/16" # Used for security group ingress
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "compute" {
  source = "./modules/compute"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  db_endpoint        = module.database.db_endpoint
}
