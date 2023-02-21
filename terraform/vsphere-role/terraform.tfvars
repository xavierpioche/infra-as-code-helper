##################################################################################
# VARIABLES
##################################################################################

# Credentials

vsphere_server   = "vcenter.ms.fcm"
vsphere_username = "terraform@vsphere.local"
vsphere_password = "aze123QSD!"
vsphere_insecure = true

# vSphere Settings

vsphere_datacenter = "Datacenter"

# Roles

packer_vsphere_role = "Packer to vSphere Integration"

packer_vsphere_privileges = [
  "System.Anonymous",
  "System.Read",
  "System.View",
  "ContentLibrary.AddLibraryItem",
  "ContentLibrary.UpdateLibraryItem",
  "Cryptographer.Access",
  "Cryptographer.Encrypt",
  "Datastore.AllocateSpace",
  "Datastore.Browse",
  "Datastore.FileManagement",
  "Host.Config.SystemManagement",
  "Network.Assign",
  "Resource.AssignVMToPool",
  "VApp.Export",
  "VirtualMachine.Config.AddNewDisk",
  "VirtualMachine.Config.AddRemoveDevice",
  "VirtualMachine.Config.AdvancedConfig",
  "VirtualMachine.Config.Annotation",
  "VirtualMachine.Config.CPUCount",
  "VirtualMachine.Config.EditDevice",
  "VirtualMachine.Config.Memory",
  "VirtualMachine.Config.Resource",
  "VirtualMachine.Config.Settings",
  "VirtualMachine.Interact.DeviceConnection",
  "VirtualMachine.Interact.PowerOff",
  "VirtualMachine.Interact.PowerOn",
  "VirtualMachine.Interact.PutUsbScanCodes",
  "VirtualMachine.Interact.SetCDMedia",
  "VirtualMachine.Interact.SetFloppyMedia",
  "VirtualMachine.Inventory.Create",
  "VirtualMachine.Inventory.CreateFromExisting",
  "VirtualMachine.Inventory.Delete",
  "VirtualMachine.Provisioning.CreateTemplateFromVM",
  "VirtualMachine.Provisioning.MarkAsTemplate",
  "VirtualMachine.Provisioning.MarkAsVM",
  "VirtualMachine.State.CreateSnapshot"
]
