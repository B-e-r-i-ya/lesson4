# lesson4

Создаем Vagrantfile:

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |v|
    v.memory = 256
    v.cpus = 1
  end

  config.vm.define "nfss" do |nfss|
    nfss.vm.network "private_network", ip: "192.168.50.10", virtualbox__intnet: "net1"
    nfss.vm.hostname = "nfss"
    nfss.vm.provision "shell", path: "nfss_script.sh"
  end

  config.vm.define "nfsc" do |nfsc|
    nfsc.vm.network "private_network", ip: "192.168.50.11", virtualbox__intnet: "net1"
    nfsc.vm.hostname = "nfsc"
    nfsc.vm.provision "shell", path: "nfsc_script.sh"
  end

end
```
И Два скрипта `nfss_script.sh` и `nfsc_script.sh`

`nfss_script.sh`:
```
yum -y install nfs-utils      #устанавливаем
systemctl enable firewalld --now
firewall-cmd --permanent --zone=public --add-service=nfs                      #настраиваем файрволл
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload
mkdir /mnt/storage                                                          #создаем директорию
chown -R nfsnobody:nfsnobody /mnt/storage                                   
chmod -R 777 /mnt/storage
echo '/mnt/storage           192.168.50.11(rw,sync,no_root_squash,no_subtree_check)' >> /etc/exports #настраиваем шару
systemctl enable rpcbind nfs-server --now           # запускаем службу
```


