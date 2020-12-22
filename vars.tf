variable AWS_REGION {
  default = "us-east-1"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PATH_TO_PUBLICKEY" {
  default = "mykeypair.pub"
}

variable PATH_TO_PRIVATE_KEY {
  default = "mykeypair"
}

variable AMIS {
  type = map(string)
  default = {
    ap-south-1     = "ami-09052aa9bc337c78d"
    ap-northeast-1 = "ami-021234069a5506633"
    us-east-1      = "ami-00ddb0e5626798373"
  }
}

variable "CIDR_BLOCK_16" {
  default = "10.0.0.0/16"
}

variable "CIDR_BLOCK_0" {
  default = "0.0.0.0/0"
}
