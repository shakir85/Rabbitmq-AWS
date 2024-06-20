variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs where NLB will be deployed"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where EC2 instances will be deployed"
  type        = list(string)
}

variable "bastion_subnet_id" {
  description = "Subnet ID where bastion host will be deployed"
  type        = string
}

variable "bastion_ssh_cidr_blocks" {
  description = "CIDR blocks to allow SSH access to the bastion host. This is the SecurityGroup SSH inbound rule"
  type        = list(string)
}

variable "bastion_ssh_key_name" {
  description = "Name of a previously provisioned SSH key"
  type        = string
}

variable "ec2_subnet1_name" {
  description = "Name of subnet where EC2 instance 1 will be deployed"
  type        = string
}

variable "ec2_subnet1_az" {
  description = "Availability Zone for EC2 instance 1"
  type        = string
}

variable "ec2_subnet2_name" {
  description = "Name of subnet where EC2 instance 2 will be deployed"
  type        = string
}

variable "ec2_subnet2_az" {
  description = "Availability Zone for EC2 instance 2"
  type        = string
}

variable "aws_vpc_region" {
  description = "AWS region where VPC is deployed"
  type        = string
}

variable "ami_id" {
  description = "AMI ID that that is going to be used across all the instances"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type. Defaults to t2.micro"
  type        = string
  default     = "t2.micro"
}

variable "aws_s3_region" {
  description = "AWS region for S3 where state file will be stored"
  type        = string
}

variable "s3_bucket_uri" {
  description = "S3 bucket where the TF state file will be stored"
  type        = string
}