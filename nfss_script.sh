yum -y install nfs-utils
systemctl enable firewalld --now
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload
mkdir /mnt/storage
chown -R nfsnobody:nfsnobody /mnt/storage
chmod -R 777 /mnt/storage
echo '/mnt/storage           192.168.50.11(rw,sync,no_root_squash,no_subtree_check)' >> /etc/exports
systemctl enable rpcbind nfs-server --now
