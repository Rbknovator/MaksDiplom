#!/bin/bash

useradd -m access

mkdir -p /home/access/.ssh
cp /vagrant/provisioning/keys/id_rsa_user4.pub /home/access/.ssh/authorized_keys
chmod 600 /home/access/.ssh/authorized_keys
chown -R access:access /home/access/.ssh

# Блокируем доступ по паролю
passwd -l access

# Финальное сообщение
cat <<EOF > /home/access/FLAG.txt
🎉 Поздравляем!
Вы добрались до последней машины.

Вот ваш финальный флаг:

    FLAG{you_made_it_to_access_node}
EOF

chown access:access /home/access/FLAG.txt
chmod 644 /home/access/FLAG.txt
