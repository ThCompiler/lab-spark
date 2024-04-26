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
sudo kubeadm init --apiserver-advertise-address=<ip of master> --control-plane-endpoint=<ip of master> --upload-certs --pod-network-cidr 10.5.0.0/16 --dry-run
sudo kubeadm init --apiserver-advertise-address=<ip of master> --control-plane-endpoint=<ip of master> --upload-certs --pod-network-cidr 10.5.0.0/16
```

Устанавливаем аддон для сети

```cmd
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml
```

Проверяем что kube-router работает
```cmd
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods -A
```

Удаляем стандартный proxy
```cmd
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl -n kube-system delete ds kube-proxy
```

Настриваем kubectl
```cmd
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
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
