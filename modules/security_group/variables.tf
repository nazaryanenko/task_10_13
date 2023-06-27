variable "ingress_ports" {
  type    = list(string)
  default = ["22", "80", "443", "3000", "3001", "3002", "3003", "3004", "8080", "9090"]
}

variable "name" {
  type    = string
  default = "My security group"
}