# Este arquivo define as variáveis que serão usadas no módulo da VPC.

variable "vpc_name" {
    description = "Nome da VPC"
    type        = string
    default     = "giropops-vpc"
}

variable "vpc_cidr" {
    description = "Bloco CIDR para a VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "private_subnets" {
    description = "Blocos CIDR para as subnets privadas"
    type        = list(string)
    default = [ "10.0.101.0/24", "10.0.102.0/24" ]
}

variable "public_subnets" {
    description = "Blocos CIDR para as subnets públicas"
    type        = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "azs" {
    description = "Zonas de disponibilidade"
    type        = list(string)
    default = [ "us-east-1a", "us-east-1b" ]
}

variable "enable_nat_gateway" {
    description = "Habilita o Nat Gateway"
    type        = bool
    default     = true
}