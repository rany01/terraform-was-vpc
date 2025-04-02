
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    
    name = "my-vpc"
    cidr = "10.0.0.0/16"
    
    azs             = var.azs
    public_subnets  = var.public_subnets
    private_subnets = var.private_subnets
    
    enable_nat_gateway = true
    single_nat_gateway = true
    
    tags = {
        Terraform = "true"
        Environment = "dev"
    }
  
}