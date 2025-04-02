output "vpc_id" {
    description = "ID da VPC"
    value       = aws_vpc.this.id
}

output "private_subnets" {
    description = "IDs das subnets privadas"
    value       = aws_subnet.private[*].id
}

output "public_subnets" {
    description = "IDs das subnets públicas"
    value       = aws_subnet.public[*].id
}

output "nat_gateway_id" {
    description = "ID do Nat Gateway"
#    value       = var.enable_nat_gateway ? aws_nat_gateway.this[0].id : null
    value       = try(aws_nat_gateway.this[0].id, null)
}