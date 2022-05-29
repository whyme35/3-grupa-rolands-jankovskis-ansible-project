module "prod-vpc"{
    source = "./modules/vpc"
    region=var.region
    vpc_cidr=var.vpc-cidr
    environment=var.env
    public_subnets_cidr  = var.public_subnets_cidr
    availability_zones   = var.availability_zones
}
module "prod-ec2"{
    source = "./modules/ec2"
    region=var.region
    environment=var.env
    instance_type = var.instance_type
    vpcid = module.prod-vpc.vpc_id
    subnet_id = module.prod-vpc.public_subnets_id[0]
    vpc_security_group_idsc = module.prod-vpc.security_groups_ids
}