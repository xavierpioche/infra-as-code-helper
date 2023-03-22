variable "nsg_name" {}
variable "nsg_location" {}
variable "nsg_resource_group" {}

variable "nsg_rules" {
    type=map(map(any))
}
