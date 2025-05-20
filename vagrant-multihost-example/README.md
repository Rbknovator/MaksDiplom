# Example Vagrant multi-host project with Ansible

Host are provisioned with [Ansible](http://docs.ansible.com).

Virtual machine are created either with [VirtualBox](https://www.virtualbox.org/)
or with [QEMU](http://www.qemu.org). Please see `rebuild-all` script for that. That script uses QEMU.

Please see [Vagrant documentation](http://docs.vagrantup.com) for details how to use it. The quick tutorial is as follows:
* `vagrant up` - starts all virtual machines, provision them if necessary
* `vagrant provision` - provision already created virtual machines again - in this case it would be Ansible playbook in `provisioning/site.yml`
* `vagrant halt` - stop all created virtual machines

After Vagrant installs machines the first time it will spin up much faster the next time.

Once the virtual machines are up, you connect to with `vagrant ssh ex01`, etc, command.

Once the system is fully started, you connect to with:
* `http://ex01.multihostexample.dev`
* `http://ex02.multihostexample.dev`
* `http://ex03.multihostexample.dev`
* `http://ex04.multihostexample.dev`

## Requirements ##
* VirtualBox >= 4.3.26 or QEMU, ideally with KVM
* Ansible >= 1.9.0
* Vagrant >= 1.7.0

### VirtualBox ###

Virtualbox binaries are available at its [download page](https://www.virtualbox.org/wiki/Downloads) and follow the instruction there.

### QEMU ###

QEMU is available as Linux packages in the modern distributions.
Vagrant needs [Vagrant Libvirt Provider](https://github.com/pradels/vagrant-libvirt) - this can be installed with `vagrant plugin install vagrant-libvirt`

### Ansible ###

Please follow [installation instructions](http://docs.ansible.com/ansible/intro_installation.html) in the Ansible [documentation](http://docs.ansible.com).

Please note: as there isn't Ansible implementation for MS Windows, this example won't start Ansible provisioner on that platform.

### Vagrant ###

> Installing Vagrant is extremely easy. Head over to the [downloads page](http://www.vagrantup.com/downloads) and get the appropriate installer or package for your platform. Then install it using standard procedures for your operating system.

> The installer will automatically add vagrant to your system path so that it is available in terminals. If it is not found, please try logging out and logging back in to your system (this is particularly necessary sometimes for Windows).

taken from https://docs.vagrantup.com/v2/installation/index.html

############################
## Additional Vagrant Plugins Installation

### Install Vagrant Hostmanager Plugin
  * `vagrant plugin install vagrant-hostmanager`

## Deployment to Vagrant ##
```
#!shell

vagrant up
```

## Running Ansible playbooks again ##
```
#!shell

ansible-galaxy install -r requirements.yml
vagrant provision
```

## Running arbitrary Ansible playbooks ##
```
#!shell

./run-ansible-vagrant.sh provisioning/site.yml
```

---------------------------------------------------------------------------------------
# 🧠 Vagrant Multi-Host Cyber Lab

## 🔧 Описание

Этот проект создаёт виртуальную лабораторию из 4 связанных машин (`ex01` → `ex04`) с логической цепочкой заданий.  
Каждая машина требует базовой логики, команд Linux и понимания SSH-доступа.

Проект идеально подходит для обучения кибербезопасности, работы с `Vagrant`, `VirtualBox` и системными правами в Linux.

---

## 📁 Структура проекта

vagrant-multihost-example/
├── Vagrantfile # Главный файл конфигурации Vagrant
├── provisioning/ # Скрипты настройки машин
│ ├── ex01.sh # Машина 1 — стартовая, SSH-подсказка
│ ├── ex02.sh # Машина 2 — требует получения root
│ ├── ex03.sh # Машина 3 — поиск скрытого ключа
│ ├── ex04.sh # Машина 4 — доступ только по ключу
│ └── keys/ # SSH-ключи (генерируются вручную)
│ ├── id_rsa_user4
│ └── id_rsa_user4.pub

yaml
Копировать
Редактировать

---

## 🚀 Быстрый старт

1. Перейди в папку проекта:

```bash
cd vagrant-multihost-example
Запусти виртуальные машины:

bash
Копировать
Редактировать
vagrant up
Или перезапусти + применить provisioning:

bash
Копировать
Редактировать
vagrant reload --provision
🔐 Генерация SSH-ключа (например, для ex04)
Если ты хочешь спрятать ключ на одной машине и использовать его на другой:

bash
Копировать
Редактировать
ssh-keygen -t rsa -b 2048 -f provisioning/keys/id_rsa_user4 -N ""
Будут созданы:

provisioning/keys/id_rsa_user4 — приватный ключ

provisioning/keys/id_rsa_user4.pub — публичный ключ

Они используются в скриптах ex03.sh и ex04.sh.

🧩 Логика прохождения
Машина ex01

Пользователь: student

Подсказка: файл ssh_history.txt с примером команды ssh

Машина ex02

Пользователь: limited

Подсказка: директории, первые буквы которых = получирут

Цель: ввести sudo -i и получить root

Машина ex03

Пользователь: ctf

Подсказка: clue.txt намекает использовать ls -a

Цель: найти скрытый приватный ключ, скопировать его в ~/.ssh

Машина ex04

Пользователь: access

Вход возможен только по ключу (id_rsa_user4)

Финальный флаг: FLAG.txt

🔁 Сброс и повторное прохождение
Полный сброс всех машин:

bash
Копировать
Редактировать
vagrant destroy -f
vagrant up
Сброс конкретной машины:

bash
Копировать
Редактировать
vagrant destroy ex03 -f
vagrant up ex03
📝 Инструкции для Макса
Все задания и логика прохождения реализуются через скрипты:

bash
Копировать
Редактировать
vagrant-multihost-example/provisioning/ex01.sh
vagrant-multihost-example/provisioning/ex02.sh
vagrant-multihost-example/provisioning/ex03.sh
vagrant-multihost-example/provisioning/ex04.sh
Если нужно спрятать ключ на одной машине и использовать на другой:

Выполни:

bash
Копировать
Редактировать
ssh-keygen -t rsa -b 2048 -f provisioning/keys/id_rsa_user4 -N ""
Это создаст:

bash
Копировать
Редактировать
provisioning/keys/id_rsa_user4
provisioning/keys/id_rsa_user4.pub
Приватный ключ (id_rsa_user4) копируется на ex03, а публичный (.pub) — в ~/.ssh/authorized_keys на ex04.

Все скрытые подсказки, флаги и инструкции добавляются внутри соответствующих ex*.sh.

📌 Требования
Vagrant 2.x

VirtualBox 7.x

(опционально) Git Bash или WSL для генерации SSH-ключей на Windows

🧠 Цель проекта
Создание логически связанной среды для обучения:

командам Linux

безопасному доступу по SSH

работе с пользователями и root-правами

Даже если ты ничего не знаешь — достаточно внимательности и логики, чтобы пройти от начала до флага на ex04.//

..//



✅ Общая цепочка:
ex01 → ex02 → ex03 → ex04

🧭 Шаг 0: Запуск системы
bash
Копировать
Редактировать
cd vagrant-multihost-example
vagrant up
🧩 Шаг 1: Вход в первую машину ex01
bash
Копировать
Редактировать
vagrant ssh ex01
➡ Внутри:

bash
Копировать
Редактировать
cat ssh_history.txt
📌 Подсказка там приведёт к следующей команде:

bash
Копировать
Редактировать
ssh limited@172.22.22.102
🔐 Пароль:

nginx
Копировать
Редактировать
letmein
🧩 Шаг 2: На ex02 — получение root
После входа в limited@ex02, прочитай подсказку:

bash
Копировать
Редактировать
cat README.txt
ls
📌 Подсказка через директории: projects, old_logs, … → получирут
Вводим команду:

bash
Копировать
Редактировать
sudo -i
🧩 Шаг 3: Из ex02 (root) — подключение к ex03
bash
Копировать
Редактировать
ssh ctf@172.22.22.103
🔐 Пароль:

nginx
Копировать
Редактировать
ctfpass
🧩 Шаг 4: На ex03 — поиск и установка SSH-ключа
bash
Копировать
Редактировать
cat clue.txt
ls -a
ls /home/ctf/.hidden
📌 Там лежит приватный ключ:

bash
Копировать
Редактировать
mkdir -p ~/.ssh
cp /home/ctf/.hidden/id_rsa_user4 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
🧩 Шаг 5: Подключение к ex04 по ключу
bash
Копировать
Редактировать
ssh -i ~/.ssh/id_rsa access@172.22.22.104
🧩 Шаг 6: На ex04 — флаг
bash
Копировать
Редактировать
cat FLAG.txt
Ты увидишь:

css
Копировать
Редактировать
🎉 Поздравляем!
Вы добрались до последней машины.
Вот ваш финальный флаг:
FLAG{you_made_it_to_access_node}
🧼 Сброс, если хочешь пройти ещё раз
bash
Копировать
Редактировать
vagrant destroy -f
vagrant up
📌 Быстрая шпаргалка (всё в одном):
bash
Копировать
Редактировать
vagrant ssh ex01
ssh limited@172.22.22.102     # пароль: letmein
sudo -i
ssh ctf@172.22.22.103         # пароль: ctfpass
mkdir -p ~/.ssh
cp /home/ctf/.hidden/id_rsa_user4 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh -i ~/.ssh/id_rsa access@172.22.22.104
cat FLAG.txt
