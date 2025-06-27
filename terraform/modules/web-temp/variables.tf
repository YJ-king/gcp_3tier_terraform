### Web Template Variables

variable "web_sa_name" {
  type        = string
  description = "ID of the Web service account (prefix only)"
}

variable "template_name" {
  type        = string
  description = "Name of the instance template"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the Web instance"
}

variable "image" {
  type        = string
  description = "Custom Web image"
}

variable "region" {
  type        = string
  description = "Deployment region"
}

variable "subnet" {
  type        = string
  description = "Subnetwork self link"
}

variable "nlb_ip" {
  type        = string
  description = "Internal IP address of the NLB"
}

