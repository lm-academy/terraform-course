output "module_vpc_id" {
  value = module.vpc.vpc_id
}

output "module_public_subnets" {
  value = module.vpc.public_subnets
}

output "module_private_subnets" {
  value = module.vpc.private_subnets
}