# Init kuber cluster

Обновляем систему:
```bash
sudo apt-get update
sudo apt-get upgrade
```

Устанавливаем (докер)[]:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Установка kubectl:
```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

Устанавливаем (minikube)[https://minikube.sigs.k8s.io/docs/start/]
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
kubectl port-forward <zeppelin-pod-name> 8080:8080
```

Переходим по айпи сервера на порт 8080


[Оф сайт](https://zeppelin.apache.org/docs/0.11.0/quickstart/kubernetes.html)
