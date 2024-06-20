resource "aws_lb" "network_lb" {
  name               = "rabbitmq-network-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids
}

resource "aws_lb_target_group" "nlb_target_group" {
  name = "nlb-target-group"
  # RabbitMQ non-TLS client port. You need to configure TLS in /etc/rabbitmq.conf first
  # then update the port number here to 5671
  port     = 5672
  protocol = "TCP"
  vpc_id   = var.vpc_id

  target_type = "instance"

  # RabbitMQ does not have a health check endppoint for TCP
  # instead, we are using the RabbitMQ API to test nodes health
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

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.network_lb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }
}
