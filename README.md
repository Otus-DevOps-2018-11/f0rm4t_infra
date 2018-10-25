# f0rm4t_infra
f0rm4t Infra repository

# HW-04 GCP + cloud-testapp

Конфигурация

```
testapp_IP = 35.195.34.12
testapp_port = 9292
```

Создание инстанса и запуск прииложения в GCP:

```bash
gcloud compute instances create reddit-app-2 \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup.sh
```

Создание правила для фаервола:

```bash
gcloud compute firewall-rules create default-puma-server \
  --direction=INGRESS \
  --priority=1000 \
  --network=default \
  --action=ALLOW \
  --rules=tcp:9292 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=puma-server
```

# HW-02 GCP + Bastion

Подключение ко внутренниму хосту (`someinternalhost`) с локальной машины

```bash
ssh -o ProxyCommand='ssh -W %h:%p %user%@%bastionhost%' %user%:%internalhost%
```

Для более удобного подключения ко внутреннему сервису, можно добавить следующие хосты в `~/.ssh/config`:

```
Host bastion
  Hostname %bastionhost%

Host someinternalhost
  Hostname %internalhost%
  ProxyCommand ssh bastion -W %h:%p
```

Данная конфигурация позволит подключаться к хосту (ssh, scp, etc) по заданному имени:

```
ssh someintnernalhost
```

Так же, можно использовать VPN - конфигурация в файле `cloud-bastion.ovpn`

Конфигурация

```
bastion_IP = 35.233.116.241
someinternalhost_IP = 10.132.0.3
```
