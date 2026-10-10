module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"] // this will override the variables passed. lets say we can use it in different env like prod and dev
}
//Variables in a module act like function arguments in programming. You can define defaults, but passing them explicitly is what makes modules so powerful and dynamic.


