#!/bin/bash
hostn=$(cat /etc/hostname)
newhost=master-rolands-jankovskis
hostnamectl set-hostname $newhost
hostname $newhost
sudo sed -i "s/$hostn/$newhost/g" /etc/hosts
sudo sed -i "s/127.0.0.1 localhost/127.0.0.1 localhost\n127.0.0.1 $newhost/g" /etc/hosts
sudo sed -i "s/$hostn/$newhost/g" /etc/hostname