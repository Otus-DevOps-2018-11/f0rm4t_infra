# f0rm4t_infra
f0rm4t Infra repository

# HW-08 Ansible #1

Добавлена начальная конфигурация ansible с примерами inventory-файлов (директория `./ansible`).

```bash
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt

ansible all -m ping
```

Добавлен файл генерации inventory в формате JSON, в который необходимо передать переменную окружения `ENV`:

```bash
ENV=stage ansible all -i inventory.py -m ping
```


# HW-07 Terraform #2

Информация о состоянии инстансов хранится в бакете на GCS. Для создания бакетов необходимо применить конфигурацию из директории `terraform`, предварительно скопировав и изменив файл переменных `terraform.tfvars.example`

```bash
terraform init
terraform apply
```

Конфигурация разделена на два окружения:
1. prod - `terraform/prod`
2. stage - `terraform/stage`

В каждой из конфигураций имеется аналогичный пример файла переменных - `terraform.tfvars.example`.

Конфигурация инстансов приложения и БД вынесена в модули:

1. app - `terraform/modules/app`
2. db - `terraform/modules/db`

# HW-06 Terraform #1

Добавлена кофигурация для разворачивания инстанса с приложением через terraform.

Перед запуском необходимо скопировать файл `terraform/terraform.tfvars.example` в `terraform/terraform.tfvars` и внести в него необходимые изменения.

```bash
terraform plan
terraform apply
```

# HW-05 Base packer

В директории `packer` находятся шаблоны для создания базового (`ubuntu16.json`) и immutable (`immutable.json`) образов. Пользовательские переменные, необходимые для сборки, доступны в примере `packer/variables.json.example`

Создание образов:

```bash
packer build -var-file=variables.json ubuntu16.json
packer build -var-file=variables.json immutable.json
```

Создание инстанса приложениия на GCP

```bash
./config-scripts/create-reddit-vm.sh
```

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
