variable "vpc_cidr" {
    description = "Bloco CIDR para a VPC"
    type        = string
}

variable "private_subnets" {
    description = "Blocos CIDR para as subnets privadas"
    type        = list(string)
}

variable "public_subnets" {
    description = "Blocos CIDR para as subnets públicas"
    type        = list(string)
}

variable "azs" {
    description = "Zonas de disponibilidade"
    type        = list(string)
}