#!/bin/bash
hostn=$(cat /etc/hostname)
newhost=master-rolands-jankovskis
hostnamectl set-hostname $newhost
hostname $newhost
sudo sed -i "s/$hostn/$newhost/g" /etc/hosts
sudo sed -i "s/127.0.0.1 localhost/127.0.0.1 localhost\n127.0.0.1 $newhost/g" /etc/hosts
sudo sed -i "s/$hostn/$newhost/g" /etc/hostname
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
sudo mv /etc/ansible/hosts /etc/ansible/hosts.bak
printf '[servers]\n\n[webservers]\n\n[database]' | sudo tee /etc/ansible/hosts -a

sudo reboot