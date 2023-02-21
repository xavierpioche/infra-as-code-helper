disk_pool=kvmpool01
iso=/var/tmp/ISOs/VMware-VMvisor-Installer-7.0U3g-20328353.x86_64.iso
virt-install --virt-type=kvm --name=esxi1 --cpu host-passthrough --ram 8192 --vcpus=2  --virt-type=kvm --hvm --cdrom $iso --network network:default,model=vmxnet3 --graphics vnc --video qxl --disk pool=$disk_pool,size=20,sparse=true,bus=ide,format=qcow2  --boot cdrom,hd,menu=on --noautoconsole --force --osinfo detect=on,require=off
virt-install --virt-type=kvm --name=esxi2 --cpu host-passthrough --ram 8192 --vcpus=2  --virt-type=kvm --hvm --cdrom $iso --network network:default,model=vmxnet3 --graphics vnc --video qxl --disk pool=$disk_pool,size=20,sparse=true,bus=ide,format=qcow2  --boot cdrom,hd,menu=on --noautoconsole --force --osinfo detect=on,require=off
