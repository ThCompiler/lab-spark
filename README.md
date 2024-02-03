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
sudo kubeadm init --pod-network-cidr=10.100.0.0/16 --dry-run
sudo kubeadm init --pod-network-cidr=10.100.0.0/16
https://habr.com/ru/articles/734928/
Настройка kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo kubeadm token create --print-join-command
```
