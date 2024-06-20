# AWS RabbitMQ Cluster

This project uses Terraform and Ansible playbooks to provision a two-node RabbitMQ cluster on AWS. The nodes are configured as disk nodes in private subnets. Traffic is managed via a Network Load Balancer, and a bastion host is deployed in a public subnet to serve as an entry point to private instances for maintenance and troubleshooting.

RabbitMQ does not strictly implement a leader/worker type of clustering; instead, each node either serves as a memory node or a disk node, with all nodes capable of processing messages and sharing responsibilities in the cluster. RAM nodes store all their data in memory for faster access but are less persistent, while Disk nodes store data on disk, providing greater persistence at the cost of slower access speeds.

