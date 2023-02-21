disk_pool=kvmpool01
iso=/var/tmp/ISOs/pfSense-CE-2.6.0-RELEASE-amd64.iso
virt-install --virt-type kvm --name pfsense --ram 2048 --vcpus 2 \
--cdrom=$iso \
--disk $disk_pool,bus=virtio,size=10,format=qcow2 \
--network default \
--network bridge=virbr0 \
--graphics vnc,listen=0.0.0.0 --noautoconsole \
--os-type=linux --os-variant=freebsd10.0
