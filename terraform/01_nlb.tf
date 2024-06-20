resource "aws_lb" "network_lb" {
  name               = "rabbitmq-network-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids
}

resource "aws_lb_target_group" "nlb_target_group_amqp" {
  name = "nlb-target-group-amqp"
  port     = 5672
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 6
  }
}

resource "aws_lb_target_group" "nlb_target_group_ui" {
  name = "nlb-target-group-ui"
  port     = 15672
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  
  # RabbitMQ management plugin must be installed. 
  # Otherwise, health checks for the management UI will fail
  health_check {
    protocol            = "HTTP"
    port                = 15672
    path                = "/api/healthchecks/node"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 6
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "nlb_listener_amqp" {
  load_balancer_arn = aws_lb.network_lb.arn
  port              = 5672 
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group_amqp.arn
  }
}

resource "aws_lb_listener" "nlb_listener_ui" {
  load_balancer_arn = aws_lb.network_lb.arn
  port              = 15672 
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group_ui.arn
  }
}
