
# outputs.tf

### Application Outputs ###

# Load Balancer DNS Output
output "loadbalancer_dns" {
  value       = aws_lb.webserver_lb.dns_name
  description = "Load Balancer DNS"
}

# Load Balancer ARN Output
output "loadbalancer_arn" {
  value       = aws_lb.webserver_lb.arn
  description = "Load Balancer ARN"
}

#VPC
output "VPC" {
  value       = aws_security_group.xyz-app-subnet-nsg.vpc_id
  description = "VPC Id"
}
