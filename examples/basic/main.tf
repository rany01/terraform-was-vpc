# Este módulo cria uma VPC na AWS com subnets públicas e privadas,
# além de recursos como NAT Gateway e Internet Gateway.

module "vpc" {
  source = "github.com/rany01/terraform-aws-vpc?ref=v1.0.0"

  vpc_name        = "giropops-vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
  enable_nat_gateway = true
}


/*
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
*/