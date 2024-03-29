variable "credential_json_file" { default = "" }

variable "project_name" {}
variable "project_id" {}
variable "billing_account" {}

//variable project_folder {}
//variable project_org {}

variable "vpc_name" {}

variable "all_subnet_name" { type = list(any) }
variable "all_subnet_param" {
  type    = map(map(string))
  default = {}
}
#variable "all_subnet_cidr" { type = list(any) }
#variable "all_subnet_region" { type = list(any) }

variable "all_routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = []
}

variable "all_firewall_rules" {
  type        = list(map(string))
  description = "List of firewall rules being created in this VPC"
  default     = []
}

variable "all_route_rules" {
  type        = list(map(string))
  description = "List of firewall rules being created in this VPC"
  default     = []
}


variable "all_computes_1" {
  type    = map(map(any))
  default = {}
}

