resource "aws_instance" "server" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_name
  monitoring             = false
  vpc_security_group_ids = [var.security_group_id]
  availability_zone      = var.availability_zone
}


#
#data "aws_ebs_volume" "current" {
#  filter {
#    name   = "tag:Name"
#    values = [aws_instance.server.id]
#  }
#}

#locals {
#  vpc_id        = length(data.aws_ebs_volume.current) == 0 ? module.volume.volume_id : data.aws_ebs_volume.current.volume_id
#}

module "volume" {
  count             = var.volumes_count
  source            = "../volume"
  availability_zone = aws_instance.server.availability_zone
  size              = var.volume_size
  name              = aws_instance.server.id
}

module "volume_attachment" {
  count           = var.volumes_count
  source          = "../volume_attachment"
  ec2_instance_id = aws_instance.server.id
  volume_id       = module.volume[0].volume_id
}

module "elastic_ip" {
  source          = "../elastic_ip"
  ec2_instance_id = aws_instance.server.id
}

