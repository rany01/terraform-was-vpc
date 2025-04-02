variables {
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
}

run "test_vpc_creation" {
  command = apply
  
  # Verificar se a VPC foi criada
  assert {
    condition = aws_vpc.this.id != ""
    error_message = "A vpc não foi criada"
  }

  # Verificar se as subnets públicas foram criadas
  assert {
    condition = length(aws_subnet.public[*].id) == 2
    error_message = "As subnets públicas não foram criadas"
  }

  # Verificar se as subnets privadas foram criadas
  assert {
    condition = length(aws_subnet.private[*].id) == 2
    error_message = "As subnets privadas não foram criadas"
  }
  
  # Verificar se a internet gateway foi criada
  assert {
    condition = aws_internet_gateway.this.id != ""
    error_message = "A internet gateway não foi criada"
  }
}