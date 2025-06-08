resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = aws_subnet.public[*].id
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
