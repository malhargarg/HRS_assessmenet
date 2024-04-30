resource "aws_security_group" "microservices" {
  vpc_id = var.vpc_id

  # Define security group rules here if needed

  tags = {
    Name = "microservices-security-group"
  }
}


