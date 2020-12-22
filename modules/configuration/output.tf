output "xyz-vnet"{
  value = aws_vpc.xyz-vnet.id
  description = "Vpc id of the instances"
}

output "lb-app-subnet-1"{
  value = aws_subnet.lb-app-subnet-1.id
  description = "load balancer public subnet id 1"
}

output "lb-app-subnet-2"{
  value = aws_subnet.lb-app-subnet-2.id
  description = "load balancer public subnet id 2"
}

output "xyz-app-subnet-1"{
  value = aws_subnet.xyz-app-subnet-1.id
  description = "webserver private subnet id 1"
}

output "xyz-app-subnet-2"{
  value = aws_subnet.xyz-app-subnet-2.id
  description = "webserver private subnet id 2"
}

output "xyz-db-subnet-1"{
  value = aws_subnet.xyz-db-subnet-1.id
  description = "database private subnet id 1"
}

output "xyz-db-subnet-2"{
  value = aws_subnet.xyz-db-subnet-2.id
  description = "database private subnet id 2"
}
