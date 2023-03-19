variable "vm_name" {}
variable "vm_type" {}
variable "vm_zone" {}
variable "vm_image" {}
variable "vm_network" {}
variable "vm_ips" {}
variable "vm_env" {}
variable "vm_cidr" {}
variable "vm_project" {}
variable "vpc_name" {}


variable "all_types" {
    type = map(string)
    default =  {
            "small" = "e2-small"
        }
}

variable "all_images" {
    type = map(string)
    default = {
             "debian" = "debian-cloud/debian-11"
        }
}
