resource "aws_lb" "service1" {
  name               = "service1-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.public_subnet_id]

  security_groups    = [var.security_group_id]

  tags = {
    Name = "service1-lb"
  }
}

