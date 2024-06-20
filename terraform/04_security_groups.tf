# Data source for private subnet CIDR blocks to build sg rules
data "aws_subnet" "private_subnets" {
  for_each = toset(var.private_subnet_ids)

  id = each.value
}

# Security Group for EC2 instances, should only be limited for TCP, but
# it's enabled temporarly to test pings (ICMP) and some other troubleshooting
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-communication-sg"
  description = "Allow all protocols between EC2 instances"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_subnet.private_subnets[1].cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_subnet.private_subnets[0].cidr_block]
  }
}

# Bastion host security group `ec2_public.tf`
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access to bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
