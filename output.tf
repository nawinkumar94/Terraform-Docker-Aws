
# outputs.tf

### Application Outputs ###

# Load Balancer DNS Output
output "loadbalancer_dns" {
  value       = module.application.loadbalancer_dns
  description = "Load Balancer DNS"
}

# Load Balancer ARN Output
output "loadbalancer_arn" {
  value       = module.application.loadbalancer_arn
  description = "Load Balancer ARN"
}

output "VPC" {
  value       = module.application.VPC
  description = "VPC Id"
}
