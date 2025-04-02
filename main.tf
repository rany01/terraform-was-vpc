# Este arquivo contém a configuração principal para criar a VPC,
# subnets, NAT Gatway e Internet Gateway e rotas.

resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = var.vpc_name
    }
}

# Cria o Internet Gateway
resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "${var.vpc_name}-igw"
    }
  
}

# Cria as subnets públicas e privadas
resource "aws_subnet" "private" {
    count = length(var.private_subnets)

    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.private_subnets[count.index]
    availability_zone       = var.azs[count.index % length(var.azs)]

    tags = {
      Name = "${var.vpc_name}-private-${count.index}"
    }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)

    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.public_subnets[count.index]
    availability_zone       = var.azs[count.index % length(var.azs)]

    tags = {
      Name = "${var.vpc_name}-public-${count.index}"
    }
}

# Cria o Nat Gateway
resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0
  domain = "vpc"
#  vpc = true
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}

# Cria a tabela de rotas p´ublicas
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }

    tags = {
        Name = "${var.vpc_name}-public-rt"
    }
}

# Associa as subnets públicas com a tabela de rotas públicas
resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public)

    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

# Cria a tabela de rotas privadas
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = var.enable_nat_gateway ? aws_nat_gateway.this[0].id : null
    }

    tags = {
        Name = "${var.vpc_name}-private-rt"
    }
}

# Associa as subnets privadas com a tabela de rotas privadas
resource "aws_route_table_association" "private" {
    count = length(var.private_subnets)

    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}