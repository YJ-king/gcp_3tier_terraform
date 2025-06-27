### VPC Module Variables

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR range for the subnet"
}

variable "region" {
  type        = string
  description = "Region where the subnet will be created"
}

variable "router_name" {
  type        = string
  description = "Name of the Cloud Router"
}

variable "nat_name" {
  type        = string
  description = "Name of the Cloud NAT"
}

