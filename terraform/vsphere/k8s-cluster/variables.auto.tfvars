dns_server = "192.168.1.240"

masters_vms_name = [ "1" , "2" , "3" ]
masters_vms_ip_ad = [ "192.168.10.101" , "192.168.10.102" , "192.168.10.103" ]
masters_vms_ip_mk = [ "24" , "24" , "24" ]
masters_vms_ip_gw = [ "192.168.10.1" , "192.168.10.1" , "192.168.10.1" ]
masters_vms_template = [ "linux-ubuntu-22.3-socle" , "linux-ubuntu-22.3-socle" , "linux-ubuntu-22.3-socle" ]
masters_vms_folder = [ "k8s-masters" , "k8s-masters" , "k8s-masters" ]
masters_vms_resource_pool = [ "" , "" , "" ]

masters_vms_datastore = [ "ZDS2" , "ZDS3" , "ZDS4" ]
masters_vms_datacenter = [ "Datacenter" , "Datacenter" , "Datacenter" ]
masters_vms_cluster = [ "Cluster" , "Cluster" ,"Cluster" ]
masters_vms_network = [ "k8s-nodes" , "k8s-nodes" , "k8s-nodes" ]
masters_vms_memory = [ "medium" , "medium" , "medium" ]
masters_vms_cpu = [ "medium" , "medium" , "medium" ]
masters_vms_suffix = [ "k8s-masters" , "k8s-masters" , "k8s-masters" ]
masters_vms_prefix = [ "op" , "op" , "op" ]
masters_vms_site = [ "gp" , "gp" , "gp" ]
masters_vms_is_windows = [ false , false , false ]
masters_vms_datadsk = [ "small" , "small" , "small" ]

workers_vms_name = [ "1" , "2" , "3" ]
workers_vms_ip_ad = [ "192.168.10.201" , "192.168.10.202" , "192.168.10.203" ]
workers_vms_ip_mk = [ "24" , "24" , "24" ]
workers_vms_ip_gw = [ "192.168.10.1" , "192.168.10.1" , "192.168.10.1" ]
workers_vms_template = [ "linux-ubuntu-22.3-socle" , "linux-ubuntu-22.3-socle" , "linux-ubuntu-22.3-socle" ]
workers_vms_folder = [ "k8s-workers" , "k8s-workers" , "k8s-workers" ]
workers_vms_resource_pool = [ "" , "" , "" ]
workers_vms_datastore = [ "ZDS2" , "ZDS3" , "ZDS4" ]
workers_vms_datacenter = [ "Datacenter" , "Datacenter" , "Datacenter" ]
workers_vms_cluster = [ "Cluster" , "Cluster" ,"Cluster" ]
workers_vms_network = [ "k8s-nodes" , "k8s-nodes" , "k8s-nodes" ]
workers_vms_memory = [ "large" , "large" , "large" ]
workers_vms_cpu = [ "medium" , "medium" , "medium" ]
workers_vms_suffix = [ "k8s-workers" , "k8s-workers" , "k8s-workers" ]
workers_vms_prefix = [ "op" , "op" , "op" ]
workers_vms_site = [ "gp" , "gp" , "gp" ]
workers_vms_is_windows = [ false , false , false ]
workers_vms_datadsk = [ "small" , "small" , "small" ]

common_vm_dns_list = "192.168.1.240"
common_vm_dns_search = "k8s.local"
common_vm_envx = "xprd"
