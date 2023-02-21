
vm_dns_list = "10.0.0.10" 
vm_dns_search = "cs.local"


//vsphere_endpoint = ""
//vsphere_username = ""
//vsphere_password = ""

vms_prefix = ["op", "op","op", "op","op", "op","op"]
vms_site = [ "si" , "si" , "si" , "pr" , "pr" , "rd" , "rd" ]
vms_suffix = ["acdi", "acdi","acdi", "acdi","acdi", "acdi","acdi"]
vms_name = ["1","2","3","4","5","6","7"]

vms_cpu = [ "small" , "small" ,"small" ,"small" ,"small" ,"small" ,"small" ]
vms_memory = [ "small" , "small" ,"small" ,"small" ,"small" ,"small" ,"small" ]
vms_is_windows = [ true , true , true , true , true , true , true ]


vms_ip_ad = [ "10.0.1.10", "10.0.1.11", "10.0.1.12", "10.1.1.10", "10.1.1.11", "10.2.1.10", "10.2.1.11" ]

vms_ip_mk = [ "24" , "24" , "24" , "24" , "24" , "24" , "24" ]

vms_ip_gw = [ "10.0.1.2" , "10.0.1.2" , "10.0.1.2" , "10.1.1.2" , "10.1.1.2" , "10.2.1.2" , "10.2.1.2" ]

vms_template = ["windows-server-2022-standard-dexp-socle", "windows-server-2022-standard-dexp-socle", "windows-server-2022-standard-dexp-socle", "windows-server-2022-standard-dexp-socle","windows-server-2022-standard-dexp-socle", "windows-server-2022-standard-dexp-socle","windows-server-2022-standard-dexp-socle"]

vms_resource_pool = ["", "", "", "","", "",""]

vms_datacenter = ["Datacenter","Datacenter","Datacenter","Datacenter","Datacenter","Datacenter","Datacenter"]

vms_datastore = [ "ZDS3" , "ZDS4" , "ZDS2" , "ZDS3" , "ZDS4" , "ZDS2" , "ZDS3" ]

vms_cluster = ["Cluster","Cluster","Cluster","Cluster","Cluster","Cluster","Cluster"]

vms_network = [ "Siege-Services" , "Siege-Services" , "Siege-Services" , "Production-Services" , "Production-Services" , "RDSAV-Services" , "RDSAV-Services" ]

vms_folder = [ "ConnectAndSport/CS-Montpellier", "ConnectAndSport/CS-Montpellier", "ConnectAndSport/CS-Montpellier", "ConnectAndSport/CS-Sete", "ConnectAndSport/CS-Sete", "ConnectAndSport/CS-Grauduroi", "ConnectAndSport/CS-Grauduroi" ]
