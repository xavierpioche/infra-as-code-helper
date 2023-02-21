export TF_VAR_vsphere_endpoint="<vcenter ip>"
export TF_VAR_vsphere_username="<vcenter username>"
export TF_VAR_vsphere_password="<vcenter password>"

export TF_VAR_rhsm_username="<your redhat username>"
export TF_VAR_rhsm_password="<your redhat password>"
export TF_VAR_ansible_key="<the pub ssh key used to connect as ansible user>"
export TF_VAR_build_password_encrypted='<the password crypted as in shadow file>'
export TF_VAR_build_password="<the clear password>"

export TF_VAR_build_key=$TF_VAR_ansible_key
export TF_VAR_ansible_password=$TF_VAR_build_password
export TF_VAR_ansible_password_crypted=$TF_VAR_build_password_encrypted

export PKR_VAR_rhsm_username=$TF_VAR_rhsm_username
export PKR_VAR_rhsm_password=$TF_VAR_rhsm_password
export PKR_VAR_ansible_key=$TF_VAR_ansible_key
export PKR_VAR_build_password_encrypted=$TF_VAR_build_password_encrypted
export PKR_VAR_build_password=$TF_VAR_build_password
export PKR_VAR_build_key=$TF_VAR_ansible_key
export PKR_VAR_ansible_password=$TF_VAR_build_password
export PKR_VAR_ansible_password_crypted=$TF_VAR_build_password_encrypted

export PKR_VAR_vsphere_endpoint=$TF_VAR_vsphere_endpoint
export PKR_VAR_vsphere_username=$TF_VAR_vsphere_username
export PKR_VAR_vsphere_password=$TF_VAR_vsphere_password
