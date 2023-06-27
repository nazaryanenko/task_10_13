provider "aws" {
  region = var.region
}

module "security_group" {
  name          = "Task 13 Security Croup"
  source        = "./modules/security_group"
  ingress_ports = var.ingress_ports
}

resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

data "aws_vpcs" "current" {
  filter {
    name   = "tag:Name"
    values = ["main"]
  }
}

locals {
  vpc_id        = length(data.aws_vpcs.current.ids) == 0 ? aws_vpc.my_vpc.id : data.aws_vpcs.current.ids[0]
  servers_count = length(data.aws_availability_zones.available.names)
}

module "server" {
  count             = local.servers_count
  source            = "./modules/custom_ec2"
  ami               = data.aws_ami.latest_ubuntu.id
  key_name          = "aws_key"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  security_group_id = module.security_group.id
  vpc_id            = local.vpc_id
}