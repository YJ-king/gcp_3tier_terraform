variable "dns_zone_name" {
  description = "Name of the existing Cloud DNS managed zone"
  type        = string
}

variable "domain_name" {
  description = "Fully qualified domain name (e.g. yjking.shop.)"
  type        = string
}

variable "alb_ip_address" {
  description = "Global IP address of the ALB"
  type        = string
}

variable "alb_dependency" {
  description = "Explicit dependency to ensure ALB is created before DNS record"
  type        = any
}

