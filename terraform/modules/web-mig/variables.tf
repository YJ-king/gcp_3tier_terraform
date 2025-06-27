### Web MIG Variables

variable "mig_name" {
  type        = string
  description = "Name of the Web MIG"
}

variable "region" {
  type        = string
  description = "Deployment region"
}

variable "template_self_link" {
  type        = string
  description = "Self link of the instance template"
}

variable "mig_size" {
  type        = number
  description = "Number of instances in the Web MIG"
}

variable "zones" {
  type        = list(string)
  description = "Zones for regional Web MIG"
}

