# Run Kylin with Docker


Создание машины

1) Войти в личный кабинет (зарегистрироваться, привязать номер телефона и банковскую карту)

2) В разделе «Облачные вычисления» найдите кнопку «Активировать», чтобы получить грант на создание инстансов (виртуальных машин)

![image](https://github.com/ThCompiler/lab-spark/assets/48956541/911e71c2-8e4d-4fd1-a8d6-5bc6cfe11285)

3) В разделе Облачные вычисления-> Виртуальные машины нажмите на кнопку «Создать инстанс».

![image](https://github.com/ThCompiler/lab-spark/assets/48956541/98d09d2e-2a86-4640-85f2-95f8361bcfc6)


4) Создание машины. Имя виртуальной машины выберите сами.
Минимальные требования
6 cpu
12 ГБ RAM
40 ГБ Физического диска

![image](https://github.com/ThCompiler/lab-spark/assets/48956541/a3c01d46-ffe6-4b6b-bdb9-e7935013ba1f)
![image](https://github.com/ThCompiler/lab-spark/assets/48956541/4985e57d-f65c-426e-83be-96f515b97b17)


При создании виртуальной машины в VK cloud обязательно выбирайте создать подсеть, иначе ничего работать не будет. Еще нужно назначить внешний ip. На картинке кнопка не нажата(

![image](https://github.com/ThCompiler/lab-spark/assets/48956541/26847c2b-0d88-4c1d-9b80-ad34e9ca0f0a)

![image](https://github.com/ThCompiler/lab-spark/assets/48956541/83921001-1083-4aef-a45a-2f5dca9eaa1d)

7) После завершения создания в разделе Облачные вычисления-> Виртуальные машины появится новый инстанс:

![image](https://github.com/ThCompiler/lab-spark/assets/48956541/58d1a3b2-1815-4d36-96c5-bf800c114a97)

Также будет скачан ключ с расшерением .pem для доступа к машине.

**Важно!** Не забывайте останавливать виртуальную машину, если вы не пользуетесь ей. Так как за работу машины вычитаются деньги из полученного гранта. Так же когда вы защитите лабораторную работу, рекомендуем удалить созданную виртуальную машину, чтобы не оплачивать аренду ресурсов.

Подключение к машине 
```bash
ssh -i <private key> <user>@<external ip>
```
user - ubuntu

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

Запуск контейнера на основе [Docker-образа](https://hub.docker.com/r/apachekylin/apache-kylin-standalone):
```bash
docker run -d \
-m 8G \
-p 7070:7070 \
-p 7080:7080 \
-p 8088:8088 \
-p 50070:50070 \
-p 8032:8032 \
-p 8042:8042 \
-p 2181:2181 \
apachekylin/apache-kylin-standalone:kylin-4.0.1-mondrian
```

8) В разделе Виртуальные сети-> Настойки firewall необходимо добавить группу безопасности. Назовем ее kylin.

![image](https://github.com/user-attachments/assets/0df5d36c-f93d-4790-af1e-b25df24cf248)

9) В созданной группе безопасности необходимо добавить правила по пробросу портов. Список портов взять из команды запуска контейнера на основе образа.

![image](https://github.com/user-attachments/assets/c7d27b4d-b7a3-49c3-9c52-29d74de8f9d2)

![image](https://github.com/user-attachments/assets/e9eb00c1-c06f-4e83-a257-ffa48f0fa0f8)

10) К группе правил kylin необходимо добавить созданную на 7 шаге виртуальную машину (кнопка внизу страницы этого правила)

![image](https://github.com/user-attachments/assets/d290548e-d456-46ed-8dca-e0e2313cdbf5)

Открыть Kylin Web UI: http://<external_ip>/kylin/login
Авторизация ADMIN KYLIN

![image](https://github.com/user-attachments/assets/026ff37a-882d-47af-a905-e4c100e647fa)


Необходимо выбрать существующий проект learn_kylin. На основе дефолтных таблиц Kylin спроектировать и построить (create+build) свой куб данных. 


[create_cube](https://kylin.apache.org/docs/4.0.4/tutorial/create_cube)


[build](https://kylin.apache.org/docs/4.0.4/tutorial/cube_build_job)

Зайти на Kylin MDX http://<external_ip>:7080/ и создать датасет на основе вашего куба.


![image](https://github.com/user-attachments/assets/c910a7da-320e-48ef-9fea-142ab32b46db)


В Excel загружаем датасет куба


![image](https://github.com/user-attachments/assets/8f2d03bb-f179-4b4e-9c43-7559692038f7)

Имя сервера: http://<external_ip>:7080/mdx/xmla/learn_kylin

Имя пользователя: ADMIN

Пароль: KYLIN

Выбираем свой датасет. Открыть его как сводную таблицу. Теперь можно делать срезы и сьроить диаграммы.




