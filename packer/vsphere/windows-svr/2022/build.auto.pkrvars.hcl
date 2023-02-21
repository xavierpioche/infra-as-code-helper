// vSphere Credentials
//vsphere_endpoint            = ""
//vsphere_username            = ""
//vsphere_password            = ""
vsphere_insecure_connection = true

// vSphere Settings
vsphere_datacenter = "Datacenter"
vsphere_cluster    = "Cluster"
vsphere_datastore  = "ZDS1"
vsphere_network    = "livebox"
vsphere_folder     = "Templates"

build_username  =  "ansible"
//build_password  =  ""
//build_key    =  ""

common_vm_version           = 19
common_tools_upgrade_policy = true
common_remove_cdrom         = true

common_iso_datastore = "ZDS1"

common_data_source      = "cdrom"
common_ip_wait_timeout  = "20m"
common_shutdown_timeout = "15m"

