variable "project_id" {}

variable "vpc_name" {}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = []
}
