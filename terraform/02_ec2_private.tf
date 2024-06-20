# EC2 instances
resource "aws_instance" "ec2_instance1" {
  ami               = var.ami_id
  instance_type     = var.ec2_instance_type
  subnet_id         = var.private_subnet_ids[0]
  availability_zone = var.ec2_subnet1_az
  security_groups   = [aws_security_group.ec2_sg.id]
  tags = {
    Name = var.ec2_subnet1_name
  }
}

resource "aws_instance" "ec2_instance2" {
  ami               = var.ami_id
  instance_type     = var.ec2_instance_type
  subnet_id         = var.private_subnet_ids[1]
  availability_zone = var.ec2_subnet2_az
  security_groups   = [aws_security_group.ec2_sg.id]
  tags = {
    Name = var.ec2_subnet2_name
  }
}

output "ec2_instance1_private_ip" {
  value = aws_instance.ec2_instance1.private_ip
}

output "ec2_instance2_private_ip" {
  value = aws_instance.ec2_instance2.private_ip
}
