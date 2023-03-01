# Install a fresh new system (optional)
text

# Specify installation method to use for installation
# To use a different one comment out the 'url' one below, update
# the selected choice with proper options & un-comment it
cdrom
#
# Set language to use during installation and the default language to use on the installed system (required)
lang ${vm_inst_os_language}

# Set system keyboard type / layout (required)
keyboard ${vm_inst_os_keyboard}

# Configure network information for target system and activate network devices in the installer environment (optional)
# --onboot	enable device at a boot time
# --device	device to be activated and / or configured with the network command
# --bootproto	method to obtain networking configuration for device (default dhcp)
# --noipv6	disable IPv6 on this device
#
# NOTE: Usage of DHCP will fail CCE-27021-5 (DISA FSO RHEL-06-000292). To use static IP configuration,
#       "--bootproto=static" must be used. For example:
# network --bootproto=static --ip=10.0.2.15 --netmask=255.255.255.0 --gateway=10.0.2.254 --nameserver 192.168.2.1,192.168.3.1
#
#network --onboot yes --device ens160 --bootproto dhcp --noipv6 --hostname tp-centos7
network --onboot yes --device ${vm_inst_ip_device} --bootproto=static --ip=${vm_inst_ip_addr} --netmask=${vm_inst_ip_mask} --gateway=${vm_inst_ip_gw} --nameserver ${vm_inst_ip_dns1},${vm_inst_ip_dns2} --noipv6 --hostname ${vm_name}

# Set the system's root password (required)
# Plaintext password is: server
# Refer to e.g. http://fedoraproject.org/wiki/Anaconda/Kickstart#rootpw to see how to create
# encrypted password form for different plaintext password
rootpw --plaintext ${ansible_password}
reboot
# The selected profile will restrict root login
# Add a user that can login and escalate privileges
# Plaintext password is: admin123
group --name=${ansible_username} --gid=1000

user --name=${ansible_username} --gid=1000 --groups=wheel --homedir=/home/ansible --password=${ansible_password} 

# Configure firewall settings for the system (optional)
# --enabled	reject incoming connections that are not in response to outbound requests
# --ssh		allow sshd service through the firewall
# firewall --enabled --ssh
firewall --disabled

# Set up the authentication options for the system (required)
# --enableshadow	enable shadowed passwords by default
# --passalgo		hash / crypt algorithm for new passwords
# See the manual page for authconfig for a complete list of possible options.
#authselect --enableshadow --passalgo=sha512
${authcommand}

# State of SELinux on the installed system (optional)
# Defaults to enforcing
selinux --disabled

# Set the system time zone (required)
timezone --utc ${vm_inst_os_timezone}

# Specify how the bootloader should be installed (required)
# Plaintext password is: password
# Refer to e.g. http://fedoraproject.org/wiki/Anaconda/Kickstart#rootpw to see how to create
# encrypted password form for different plaintext password
bootloader --location=mbr --append="crashkernel=auto rhgb quiet" 

# Initialize (format) all disks (optional)
# zerombr

# The following partition layout scheme assumes disk of size 20GB or larger
# Modify size of partitions appropriately to reflect actual machine's hardware
# 
# Remove Linux partitions from the system prior to creating new ones (optional)
# --linux	erase all Linux partitions
# --initlabel	initialize the disk label to the default based on the underlying architecture
clearpart --linux --initlabel
zerombr

# Create primary system partitions (required for installs)
part /boot --fstype=xfs --size=1024 --label=BOOTFS
part /boot/efi --fstype=vfat --size=1024 --label=EFIFS
part pv.01 --grow --size=1

# Create a Logical Volume Management (LVM) group (optional)
volgroup VolGroup --pesize=4096 pv.01
# Create particular logical volumes (optional)
logvol / --fstype=xfs --name=LogVol06 --vgname=VolGroup --size=8192 --grow
# CCE-26557-9: Ensure /home Located On Separate Partition
logvol /home --fstype=xfs --name=LogVol02 --vgname=VolGroup --size=1024 --fsoptions="nodev"
# CCE-26435-8: Ensure /tmp Located On Separate Partition
logvol /tmp --fstype=xfs --name=LogVol01 --vgname=VolGroup --size=1024 --fsoptions="nodev,noexec,nosuid"
# CCE-26639-5: Ensure /var Located On Separate Partition
logvol /var --fstype=xfs --name=LogVol03 --vgname=VolGroup --size=2048 --fsoptions="nodev"
# CCE-26215-4: Ensure /var/log Located On Separate Partition
logvol /var/log --fstype=xfs --name=LogVol04 --vgname=VolGroup --size=1024 --fsoptions="nodev"
# CCE-26436-6: Ensure /var/log/audit Located On Separate Partition
logvol /var/log/audit --fstype=xfs --name=LogVol05 --vgname=VolGroup --size=512 --fsoptions="nodev"
logvol swap --name=lv_swap --vgname=VolGroup --size=2016



# Packages selection (%packages section is required)
%packages
# Require @Base
@Base
@core
perl
chkconfig
gzip
gdisk
python3
python3-pip
-iwl*firmware
open-vm-tools
telnet
vim-enhanced
mlocate
net-tools
net-snmp
net-snmp-utils
sysstat
tcpdump
wget
libselinux-python3
policycoreutils-python
unzip
ntp

%end # End of %packages section


%pre
#
%end

#

%post
#
chkconfig sshd on
chkconfig vmtoolsd on
chkconfig chronyd on
#
echo "Welcome" > /etc/motd
# ajout de la cle ssh du user ansible
mkdir -p /home/ansible/.ssh
echo ${ansible_key} | tee /home/ansible/.ssh/authorized_keys
chmod 700 /home/ansible/.ssh
chmod 400 /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh

# configuration de ntp
cat > /etc/chronyd.conf << EOF_NTP
server ${vm_inst_ip_ntp1} prefer
driftfile /var/lib/chrony/drift
EOF_NTP
#
echo "ansible ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible
#
cat > /etc/cron.daily/yumsecurity.sh << EOF_YUM
/usr/bin/yum update-minimal --security -y
EOF_YUM

chmod +x /etc/cron.daily/yumsecurity.sh
#
cat > /etc/ssh/sshd_config << EOF_SSHD
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
SyslogFacility AUTHPRIV
PermitRootLogin no
AuthorizedKeysFile      .ssh/authorized_keys
PermitEmptyPasswords no
PasswordAuthentication yes
ChallengeResponseAuthentication no
GSSAPIAuthentication yes
GSSAPICleanupCredentials no
UsePAM yes
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no
UseDNS no
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS
Subsystem       sftp    /usr/libexec/openssh/sftp-server
EOF_SSHD
#
pip3 install boto

cat >> /etc/sysctl.conf << EOF_SYSCTL
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 1
net.ipv4.conf.default.secure_redirects = 1
net.ipv4.ip_forward = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
kernel.randomize_va_space = 2
fs.protected_hardlinks=1
fs.protected_symlinks=1
kernel.kptr_restrict=1
kernel.yama.ptrace_scope=1
kernel.perf_event_paranoid=2
EOF_SYSCTL


%end


# Reboot after the installation is complete (optional)
# --eject	attempt to eject CD or DVD media before rebooting
reboot --eject
