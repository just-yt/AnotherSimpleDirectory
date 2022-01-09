#!/bin/bash
apt update
apt install dialog
apt install mariadb-client


######### creation et configuration de l'autologin
mkdir -pv /etc/systemd/system/getty@tty1.service.d/
touch /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "[Service]">/etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "ExecStart=">>/etc/systemd/system/getty@tty1.service.d/autologin.conf
###remplacer eleve par le nom d'utilisateur local de la machine
echo "ExecStart=-/sbin/agetty --autologin eleve --noclear %I 38400 linux">>/etc/systemd/system/getty@tty1.service.d/autologin.conf
systemctl enable getty@tty1.service

echo "startx" >> /home/eleve/.bashrc

##############installation des programmes #########


#remplacer par l'adresse du serveur
echo "192.168.16.80	directory-logon" >> /etc/hosts
mkdir /opt/mylogon/
cp logon.sh /opt/mylogon/logon.sh
chmod a+x /opt/mylogon/logon.sh
cp logon.conf /opt/mylogon/logon.conf
chmod a+x /opt/mylogon/logon.conf
cp rc.local /etc/rc.local
chmod a+x /etc/rc.local
rm *

##########suppression de lightdm ###############
apt remove lightdm
reboot