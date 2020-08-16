yum -y install nfs-utils
systemctl enable rpcbind --now
mkdir /mnt/nfs-share
echo '192.168.50.10:/mnt/storage  /mnt/nfs-share     nfs    defaults    0 0'>> /etc/fstab
mount -a