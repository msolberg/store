#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
repo --name="Server-HighAvailability" --baseurl=file:///run/install/repo/addons/HighAvailability
repo --name="Server-ResilientStorage" --baseurl=file:///run/install/repo/addons/ResilientStorage
# Use CDROM installation media
cdrom
# Use graphical install
text
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=vda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=static --device=eth0 --gateway=10.59.119.1 --ip=10.59.119.175 --nameserver=10.59.119.175 --netmask=255.255.255.0 --onboot=on --ipv6=auto --no-activate
network  --hostname=cobbler00815.odretail.net

# Root password
rootpw --iscrypted $6$kas7w.HDWVcUbKBP$c1Euycb.Gf4ocsdWymSOVojTNBdM6luQxyzQSZzFSCW0D/07Ot18S4.6DD8IUenJlA8cd82jEtMpucRcCix4P.
# System services
services --enabled="chronyd"
# System timezone
timezone America/New_York --isUtc
user --groups=wheel --name=ansible --password=$6$/d4uzcBv1xzmvHIC$9c02NGOFYkw4pwdXGbHAhqNfA5oOYzWADaqIlsy2wjLiRMbGr7N5hW8BPOwlIPuNuG7MHqi6Xeiuo8R9d76Wq/ --iscrypted --gecos="ansible"
# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=vda
# Partition clearing information
clearpart --all --initlabel --drives=vda
# Disk partitioning information
part pv.231 --fstype="lvmpv" --ondisk=vda --size=47587
part /boot --fstype="xfs" --ondisk=vda --size=1024
volgroup rhel --pesize=4096 pv.231
logvol /home  --fstype="xfs" --size=6675 --name=home --vgname=rhel
logvol /var  --fstype="xfs" --size=28610 --name=var --vgname=rhel
logvol /  --fstype="xfs" --size=10240 --name=root --vgname=rhel
logvol swap  --fstype="swap" --size=2048 --name=swap --vgname=rhel

%packages
@^minimal
@core
chrony
kexec-tools
screen
bind-utils

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
