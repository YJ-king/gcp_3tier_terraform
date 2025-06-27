### NLB Variables

variable "region" {
  type        = string
  description = "Region of the resources"
}

variable "was_mig_name" {
  type        = string
  description = "Name of the WAS MIG"
}

variable "backend_service_name" {
  type        = string
  description = "Name of the backend service"
}

variable "nlb_forwarding_rule_name" {
  type        = string
  description = "Name of the forwarding rule"
}

variable "health_check_self_link" {
  type        = string
  description = "Health check self link for the WAS backend"
}

variable "vpc_self_link" {
  type        = string
  description = "Self link of the VPC"
}

variable "subnet_self_link" {
  type        = string
  description = "Self link of the subnet"
}

