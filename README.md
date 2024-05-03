# Init kuber cluster

Обновляем систему:
```bash
sudo apt-get update
sudo apt-get upgrade
```

Устанавливаем [докер](https://docs.docker.com/engine/install/ubuntu/):

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Установка [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/):
```bash
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

Устанавливаем [minikube](https://minikube.sigs.k8s.io/docs/start/)
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```

Запускаем spark:
```
kubectl apply -f cfg.yml
kubectl apply -f spark.yml
```

Запускает zeppelin:
```bash
kubectl apply -f zeppelin.yml
```

Открываем порт:
```bash
kubectl port-forward <zeppelin-pod-name> 8080:8080 --address='0.0.0.0'
```

Переходим по айпи сервера на порт 8080


[Оф сайт](https://zeppelin.apache.org/docs/0.11.0/quickstart/kubernetes.html)

Утилиты:
```bash
eval $(minikube docker-env)
```
