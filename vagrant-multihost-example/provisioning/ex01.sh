#!/bin/bash

# Создаём пользователя
useradd -m student
echo "student:student123" | chpasswd

# Добавляем подсказку в файл
cat <<EOF > /home/student/ssh_history.txt
История SSH

SSH — это способ подключения к удалённым системам.
Может быть, рядом есть такая? Попробуй посмотреть соседние IP.
Возможно, тебе нужно просто попробовать команду:
ssh имя_пользователя@ip_соседней_машины
EOF

chmod 644 /home/student/ssh_history.txt
chown student:student /home/student/ssh_history.txt
