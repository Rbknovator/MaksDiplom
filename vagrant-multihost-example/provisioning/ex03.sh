#!/bin/bash

useradd -m ctf
echo "ctf:ctfpass" | chpasswd

# Прячем ключ в скрытой директории
mkdir -p /home/ctf/.hidden
cp /vagrant/provisioning/keys/id_rsa_user4 /home/ctf/.hidden/id_rsa_user4
chmod 600 /home/ctf/.hidden/id_rsa_user4
chown -R ctf:ctf /home/ctf/.hidden

# Подсказка
cat <<EOF > /home/ctf/clue.txt
Файл спрятан. Но обычная команда 'ls' его не покажет.

Попробуй:

    ls -a

Когда найдёшь нужный файл, скопируй его:

    cp /home/ctf/.hidden/id_rsa_user4 ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa

И подключись:

    ssh -i ~/.ssh/id_rsa access@172.22.22.104
EOF

chmod 644 /home/ctf/clue.txt
chown ctf:ctf /home/ctf/clue.txt
