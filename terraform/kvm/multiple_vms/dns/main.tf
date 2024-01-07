resource "dns_a_record_set" "srv" {
  name = var.vm_name
  zone = "${var.vm_subenvx}.${var.vm_envx}.${var.vm_tld}."
  addresses =   var.vm_address 
  ttl = 300
}

