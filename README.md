# Init kuber cluster

Пример секрета для машины:

```yaml
# Ansible user password for sudo
ansible_become_pass: ********

ansible_user: worker

# Linux user's passwords
passwords:
  root: ********
  worker: ******** # пользователь системы

```

Указать в настройках инвентори хосты

Если не дебиан то поменять для крио соответствующий тип машины в group_vars в соответсвии с https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/.

Надо устноваить ансибл по инструкции из этой [ссылки](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

Указать пароли в secret.yml

```cmd
ansible-vault encrypt inventory/host_vars/worker1/secret.yml
ansible-vault encrypt inventory/host_vars/worker2/secret.yml
ansible-vault encrypt inventory/host_vars/master/secret.yml
ansible-vault encrypt inventory-init/host_vars/worker1/secret.yml
ansible-vault encrypt inventory-init/host_vars/worker2/secret.yml
ansible-vault encrypt inventory-init/host_vars/master/secret.yml
```

Запустить конфигурирования машин

```cmd
ANSIBLE_CONFIG=ansible-init.cfg ansible-playbook playbooks/users.yml
ansible-playbook playbooks/all_hosts.yml
ansible-playbook playbooks/master.yml
```

```cmd
sudo kubeadm init --apiserver-advertise-address=<ip of master> --control-plane-endpoint=<ip of master> --upload-certs --pod-network-cidr 10.24.0.0/16 --dry-run
sudo kubeadm init --apiserver-advertise-address=<ip of master> --control-plane-endpoint=<ip of master> --upload-certs --pod-network-cidr 10.24.0.0/16
```
Настриваем kubectl
```cmd
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```


Устанавливаем аддон для сети

```cmd
curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
```

Обновляем ip под выбранный нами диапазон

```cmd
sed -ie 's/192.168.0.0/10.24.0.0/g' custom-resources.yaml
```

Применяем аддон
```cmd
kubectl create -f tigera-operator.yaml
kubectl create -f custom-resources.yaml
```

Дожидаемся кода всё станет в запушшеном состоянии
```cmd
kubectl get pods -A
```

Если они не запустились, возможно данная команда поможет
```cmd
update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
```

Из этой команды получаем инструкцию для подключения node
```cmd 
sudo kubeadm token create --print-join-command
```

## В случае перезапуска

Если вы перезапустили мастера кубер может обратно не подняться. Тогда необходимо выполнить две следующие строчки:
```cmd
sudo swapoff -a
sudo systemctl start kubelet
```
