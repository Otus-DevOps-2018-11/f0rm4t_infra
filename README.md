# f0rm4t_infra
f0rm4t Infra repository

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
