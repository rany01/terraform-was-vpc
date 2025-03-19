# Este arquivo contém a configuração principal para criar a VPC,
# subnets, NAT Gatway e Internet Gateway e rotas.

resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "giropops-vpc"
    }
}

resource "aws_subnet" "private" {
    count = length(var.private_subnets)

    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.private_subnets[count.index]
    availability_zone       = var.azs[count.index]

    tags = {
      Name = "giropops-private-subnet-${count.index}"
    }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)

    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.public_subnets[count.index]
    availability_zone       = var.azs[count.index]

    tags = {
      Name = "giropops-public-subnet-${count.index}"
    }
}