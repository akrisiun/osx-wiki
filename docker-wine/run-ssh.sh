
#    && echo -e "AllowUsers git\n" >> /etc/ssh/sshd_config \
#    && echo -e "Port 22\n" >> /etc/ssh/sshd_config

mkdir /var/run/sshd
/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config

