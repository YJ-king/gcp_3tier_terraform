### WAS MIG Variables

variable "region" {
  type        = string
  description = "Region to deploy the MIG"
}

variable "mig_name" {
  type        = string
  description = "Name of the Managed Instance Group"
}

variable "template_self_link" {
  type        = string
  description = "Self link of the instance template"
}

variable "mig_size" {
  type        = number
  description = "Number of instances in the MIG"
}

variable "health_check_name" {
  type        = string
  description = "Name of the health check"
}

