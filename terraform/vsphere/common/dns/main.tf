resource "dns_a_record_set" "srv" {
  for_each = { for s in var.vm_name: index(var.vm_name, s) => s }
  name = var.vm_name["${each.key}"] 
  zone = "${var.vm_envx}.${var.vm_dns_search}."
  addresses = [ var.vm_address["${each.key}"] ]
  ttl = 300
}

