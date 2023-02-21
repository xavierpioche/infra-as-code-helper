ansible_username = "ansible"
//ansible_key      = ""
//ansible_password_crypted = ""
//ansible_password = ""

common_vm_version           = 19
common_tools_upgrade_policy = true
common_remove_cdrom         = true

common_iso_datastore = "ZDS1"

common_data_source      = "disk"
common_ip_wait_timeout  = "20m"
common_shutdown_timeout = "15m"

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
//build_key = ""
//build_password_encrypted = "$6$WA6JCLcurSQzfvNO$zr5.c5KR0kTqq..vJibvIbYljySmSPJN3xZVJh2HRzocm3zQY.4jSxNf7DJMxDJSKU2qB9NVJEhoWX7B2zHSj."
