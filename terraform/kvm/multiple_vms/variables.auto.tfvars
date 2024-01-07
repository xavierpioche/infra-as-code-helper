vms_name = [ "k8sma1" , "k8sma2", "k8sma3" , "k8swk1", "k8swk2", "k8swk3" ]
vms_domain = [ "k8s.xprd.local", "k8s.xprd.local", "k8s.xprd.local", "k8s.xprd.local", "k8s.xprd.local", "k8s.xprd.local" ]
vms_ip_type = [ "dhcp", "dhcp", "dhcp", "dhcp", "dhcp", "dhcp" ]
vms_memoryMB = [ 8192, 4096, 4096, 4096, 4096, 4096 ]
vms_cpu = [ 2 , 2 , 2 , 2 , 2 , 2 ]

common_vm_subenvx = "k8s"
common_vm_envx = "xprd"
common_vm_tld = "local"

dns_server = "192.168.122.232"
