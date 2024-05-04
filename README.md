# Init kuber cluster

Подключеие к машине 
```bash
ssh -i <private key> <user>@<ip>
```

Обновляем систему:
```bash
sudo apt-get update
sudo apt-get upgrade
```

Устанавливаем [докер](https://docs.docker.com/engine/install/ubuntu/):

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo groupadd docker
sudo usermod -aG docker $USER
```

Надо перезапустить терминал чтобы изменения применились.

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

Настраиваем minikube:
```bash
minikube config set cpus 6
minikube config set memory 10g
minikube start
```

Скачиваем этот репозиторий:
```bash
git clone 
```

Запускает jupiter:
```bash
kubectl apply -f jupiter.yml
```

Состояние пода можно посмотреть:
```bash
kubectl get pods
```

Перед запуском jupyter, необходимо посмотреть токен доступа с помощью команды:
```bash
kubectl logs jupiter-spark-0
```

![image](https://github.com/ThCompiler/lab-spark/assets/48956541/ec427814-f12f-48e6-a08b-2731d42fbeab)


Открываем порт:
```bash
kubectl port-forward jupiter-spark-0 8080:8888 --address='0.0.0.0'
```

Переходим по айпи сервера на порт 8080

Там подключаемся с помощью
```python
from pyspark.sql import SparkSession

spark = (SparkSession
            .builder
            .master("k8s://https://kubernetes.default.svc:443")
            .config("spark.executor.instances", "2")
            .config("spark.kubernetes.container.image", "spark:python3-java17")
            .getOrCreate()
        )
```

Более детальная настройка на оф сайте [spar](https://spark.apache.org/docs/latest/running-on-kubernetes.html)

Загружаем слова:

```python
import os

os.environ["HADOOP_USER_NAME"] = "root"

df= spark.read.format("text").load("hdfs://212.233.97.126:9000/dataset/words_1.txt")
```

Загружаем 32 гб слов:

```python
import os

os.environ["HADOOP_USER_NAME"] = "root"

df= spark.read.format("text").load("hdfs://212.233.97.126:9000/dataset/words_32.txt")
```

Считаем число уникальных слов:

```python
import time
from pyspark.sql.functions import col, countDistinct

start_time = time.time()
df.select(countDistinct("value")).show()
print("--- %s seconds ---" % (time.time() - start_time))
```

Посчитать количество содержащих:

```python
import time
from pyspark.sql.functions import col, countDistinct

start_time = time.time()
df.filter(col("value").contains("jk")).select(countDistinct("value")).show()
print("--- %s seconds ---" % (time.time() - start_time))
```

Посчитать число повторений для каждого слова:

```python
import time
import pyspark.sql.functions as f

start_time = time.time()
df.withColumn('word', f.col('value')).groupBy('word').count().sort('count', ascending=False).show()
print("--- %s seconds ---" % (time.time() - start_time))
```

Выключить spark;

```python
spark.stop()
```

Утилиты:
```bash
eval $(minikube docker-env)
```
