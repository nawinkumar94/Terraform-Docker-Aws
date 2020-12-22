data "aws_vpc" "xyz-vnet"{
  cidr_block  = var.CIDR_BLOCK_16
  tags = {
    Name      = "xyz-vnet"
  }
  depends_on  = [var.VPC_ID]
}

data "aws_subnet" "lb-app-subnet-1"{
  vpc_id    = data.aws_vpc.xyz-vnet.id
  tags = {
    Name    = "lb-app-subnet-1"
  }
}

data "aws_subnet" "lb-app-subnet-2"{
  vpc_id    = data.aws_vpc.xyz-vnet.id
  tags = {
    Name    = "lb-app-subnet-2"
  }
}

data "aws_subnet" "xyz-app-subnet-1"{
  vpc_id    = data.aws_vpc.xyz-vnet.id
  tags = {
    Name    = "xyz-app-subnet-1"
  }
}

data "aws_subnet" "xyz-app-subnet-2"{
  vpc_id    = data.aws_vpc.xyz-vnet.id
  tags = {
    Name    = "xyz-app-subnet-2"
  }
}

data "aws_subnet" "xyz-db-subnet-1"{
  vpc_id    = data.aws_vpc.xyz-vnet.id
  tags = {
    Name    = "xyz-db-subnet-1"
  }
}

data "aws_subnet" "xyz-db-subnet-2"{
  vpc_id    = data.aws_vpc.xyz-vnet.id
  tags = {
    Name    = "xyz-db-subnet-2"
  }
}

data "template_file" "init_script"{
  template = file("nginx.sh")
}

data "template_file" "db_script"{
  template = file("db_script.sh")
}

resource "aws_key_pair" "mykey"{
  key_name   = "mykeypair"
  public_key = file(var.PATH_TO_PUBLICKEY)
}

resource "aws_instance" "webserver1"{
  ami                    = lookup(var.AMIS,var.AWS_REGION)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.xyz-app-subnet-nsg.id]
  subnet_id              = data.aws_subnet.xyz-app-subnet-1.id
  user_data              = data.template_file.init_script.rendered
  key_name               = aws_key_pair.mykey.key_name
  tags = {
    Name = "webserver"
  }
}

resource "aws_instance" "webserver2"{
  ami                    = lookup(var.AMIS,var.AWS_REGION)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.xyz-app-subnet-nsg.id]
  subnet_id              = data.aws_subnet.xyz-app-subnet-2.id
  user_data              = data.template_file.init_script.rendered
  key_name               = aws_key_pair.mykey.key_name
  tags = {
    Name = "webserver"
  }
}

resource "aws_security_group" "xyz-app-subnet-nsg"{
  name   = "xyz-app-subnet-nsg"
  vpc_id = data.aws_vpc.xyz-vnet.id
  ingress{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks =[var.CIDR_BLOCK_0] //Need to give bastion host ip
  }
  ingress{
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_lb.id]
  }
  egress{
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.CIDR_BLOCK_0]
  }
  tags = {
    Name  = "xyz-app-subnet-nsg"
  }
}

resource "aws_instance" "database_server1"{
  ami                    = lookup(var.AMIS,var.AWS_REGION)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.xyz-db-subnet-nsg.id]
  subnet_id              = data.aws_subnet.xyz-db-subnet-1.id
  user_data              = data.template_file.db_script.rendered
  key_name               = aws_key_pair.mykey.key_name
  tags = {
    Name = "dbserver"
  }
}

resource "aws_instance" "database_server2"{
  ami                    = lookup(var.AMIS,var.AWS_REGION)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.xyz-db-subnet-nsg.id]
  subnet_id              = data.aws_subnet.xyz-db-subnet-2.id
  user_data              = data.template_file.db_script.rendered
  key_name               = aws_key_pair.mykey.key_name
  tags = {
    Name = "dbserver"
  }
}

resource "aws_security_group" "xyz-db-subnet-nsg" {
  name        = "xyz-db-subnet-nsg"
  vpc_id      =  data.aws_vpc.xyz-vnet.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.xyz-app-subnet-nsg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.CIDR_BLOCK_0]
  }

  tags = {
    Name = "xyz-db-subnet-nsg"
  }
}

resource "aws_lb" "webserver_lb"{
  name               = "webserver-lb"
  load_balancer_type = "application"
  security_groups    =[aws_security_group.allow_lb.id]
  subnets            =[data.aws_subnet.lb-app-subnet-1.id,data.aws_subnet.lb-app-subnet-2.id]
  tags = {
    Name  = "webserver-loadbalancer"
  }
}

resource "aws_lb_target_group" "webserver_lb_group"{
  name     = "webserver-lb-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.xyz-vnet.id
  tags = {
    Name  = "webserver-target_group"
  }
}

resource "aws_lb_target_group_attachment" "webserver_lb_attach"{
  target_group_arn = aws_lb_target_group.webserver_lb_group.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "webserver_lb_attach1"{
  target_group_arn = aws_lb_target_group.webserver_lb_group.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}


resource "aws_lb_listener" "webserver_lb_listener"{
  load_balancer_arn   = aws_lb.webserver_lb.arn
  port                = 80
  protocol            = "HTTP"
  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.webserver_lb_group.arn
  }
}

resource "aws_security_group" "allow_lb"{
  name    = "allow-security"
  vpc_id  = data.aws_vpc.xyz-vnet.id
  ingress{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.CIDR_BLOCK_0]
  }
  ingress{
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.CIDR_BLOCK_0]
  }
  egress{
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks =[var.CIDR_BLOCK_0]
  }
}
