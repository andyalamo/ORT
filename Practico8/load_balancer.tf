resource "aws_lb" "alb_ej8" {
  name               = "alb-ej8"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_webserver.id]
  subnets            = [module.Subnet["subnet_us_east_1a"].subnet_id,module.Subnet["subnet_us_east_1b"].subnet_id]


  tags = {
    Environment = "Ejercicio8"
  }
}

resource "aws_lb_target_group" "webservers" {
  vpc_id   = aws_vpc.vpc.id
  name     = "webservers"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  
  health_check {
    interval            = 30
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    path                = "/simple-ecomme"
  } 
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb_ej8.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.webservers.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "webserver-01" {
  target_group_arn = aws_lb_target_group.webservers.id
  target_id        = module.Webserver["webserver_us_east_1a"].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "webserver-02" {
  target_group_arn = aws_lb_target_group.webservers.id
  target_id        = module.Webserver["webserver_us_east_1b"].id
  port             = 80
}