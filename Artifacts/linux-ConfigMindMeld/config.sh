#!/usr/bin/env bash

# update the os
sudo apt update && sudo apt dist-upgrade -y

# install and config iptables
#sudo apt install -y iptables-persistent
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 13514 -j ACCEPT
sudo iptables -A INPUT -p icmp -m icmp --icmp-type 0 -j ACCEPT
sudo iptables -A INPUT -p icmp -m icmp --icmp-type 3 -j ACCEPT
sudo iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
sudo iptables -A INPUT -p icmp -m icmp --icmp-type 11 -j ACCEPT
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo bash -c "iptables-save > /etc/iptables/rules.v4"
sudo ip6tables -A INPUT -i lo -j ACCEPT
sudo ip6tables -P INPUT DROP
sudo ip6tables -P FORWARD DROP
sudo bash -c "ip6tables-save > /etc/iptables/rules.v6"

# adding the repo GPG key
 wget -qO - https://minemeld-updates.panw.io/gpg.key | sudo apt-key add -

# adding the MineMeld APT repo
sudo add-apt-repository "deb http://minemeld-updates.panw.io/ubuntu xenial-minemeld main"
sudo apt update

# installing nginx and redis
sudo apt install -y nginx redis-server

# installing MindMeld
sudo apt install -o Dpkg::Options::="--force-overwrite" -y minemeld
echo "MineMeld installation done"
