variable "ami" {
  type    = string
  default = ""
}

variable "key_name" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "volumes_count" {
  type    = number
  default = 0
}

variable "volume_size" {
  type    = number
  default = 1
}