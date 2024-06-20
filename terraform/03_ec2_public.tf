# Bastion host EC2 instance to allow managing instances in private subnets
resource "aws_instance" "bastion_host" {
  ami                         = var.ami_id
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.bastion_subnet_id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.bastion_sg.id]
  key_name                    = var.bastion_ssh_key_name
  tags = {
    Name = "bastion-host"
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion_host.public_ip
}
