resource "aws_instance" "web" {
  count         = 2
  ami           = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = "WebServer-${count.index + 1}"
  }
}

resource "aws_eip" "web_1" {
  tags = {
    Name = "EIP for WebServer 1"
  }
}

resource "aws_eip" "web_2" {
  tags = {
    Name = "EIP for WebServer 2"
  }
}

resource "aws_eip_association" "web_1" {
  instance_id   = aws_instance.web[0].id
  allocation_id = aws_eip.web_1.id
}

resource "aws_eip_association" "web_2" {
  instance_id   = aws_instance.web[1].id
  allocation_id = aws_eip.web_2.id
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP, HTTPS, and SSH"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = [80, 443, 22, 3000]
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
  security_groups    = [aws_security_group.web_sg.id]
}

resource "aws_key_pair" "deployer" {
  key_name   = "nina-key"
  public_key = file("~/.ssh/new_key.pub")
}
resource "aws_lb_target_group" "tg" {
  name     = "app-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  lifecycle {
    create_before_destroy = true
  }
  health_check {
  path                = "/"
  port                = "3000"
  protocol            = "HTTP"
  interval            = 30
  timeout             = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}
}
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
resource "aws_lb_target_group_attachment" "attach" {
  count              = 2
  target_group_arn   = aws_lb_target_group.tg.arn
  target_id          = aws_instance.web[count.index].id
  port               = 3000
}

resource "aws_db_instance" "db" {
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = aws_subnet.public[*].id
}
