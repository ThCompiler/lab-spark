# Init kuber cluster

Пример секрета для машины:

```yaml
# Ansible user password for sudo
ansible_become_pass: c9VFv8_qSy

ansible_user: worker

# Linux user's passwords
passwords:
  root: r1-vIQlAjH
  worker: c9VFv8_qSy

```

Указать пароли в secret.yml
ansible-vault encrypt inventory/host_vars/worker1/secret.yml
ansible-vault encrypt inventory/host_vars/worker2/secret.yml
ansible-vault encrypt inventory/host_vars/master/secret.yml
ansible-vault encrypt inventory-init/host_vars/worker1/secret.yml
ansible-vault encrypt inventory-init/host_vars/worker2/secret.yml
ansible-vault encrypt inventory-init/host_vars/master/secret.yml

ANSIBLE_CONFIG=ansible-init.cfg ansible-playbook playbooks/users.yml
ansible-playbook playbooks/all_hosts.yml
ansible-playbook playbooks/master.yml

kubeadm init --pod-network-cidr=10.100.0.0/16 --dry-run
https://habr.com/ru/articles/734928/
Настройка kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo kubeadm token create --print-join-command