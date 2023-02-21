
//rhsm_username = env(TF_VAR_rhsm_username)
//rhsm_password = env(TF_VAR_rhsm_password)

ansible_username = "ansible"
//ansible_key      = env(TF_VAR_ansible_key)
//ansible_password_crypted = env(TF_VAR_ansible_crypted_password)
//ansible_password = env(TF_VAR_ansible_clear_password)

common_vm_version           = 19
common_tools_upgrade_policy = true
common_remove_cdrom         = true

common_iso_datastore = "ZDS1"

common_data_source      = "disk"
common_http_ip          = null
common_http_port_min    = 8000
common_http_port_max    = 8099
common_ip_wait_timeout  = "20m"
common_shutdown_timeout = "15m"

// vSphere Credentials
//vsphere_endpoint            = env(TF_VAR_vcenter_server)
//vsphere_username            = env(TF_VAR_vcenter_user)
//vsphere_password            = env(TF_VAR_vcenter_password)
vsphere_insecure_connection = true

// vSphere Settings
vsphere_datacenter = "Datacenter"
vsphere_cluster    = "Cluster"
vsphere_datastore  = "ZDS1"
vsphere_network    = "livebox"
vsphere_folder     = "Templates"

build_username  =  "ansible"
//build_password  =  env(TF_VAR_ansible_clear_password)
//build_key = env(TF_VAR_ansible_key)
//build_password_encrypted = env(TF_VAR_ansible_crypted_password)
