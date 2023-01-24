#!/bin/bash
#
# https://github.com/GitKitNet/
#
# Copyright (c) 2013 GitKitNet. Released under the MIT License.
#
# OpenVPN в Ubuntu 20.04 / 18.04 / 16.04

sudo apt update
sudo apt upgrade
sudo apt-get install -y wget curl git traceroute

cd ~ 
wget https://raw.githubusercontent.com/ITcxUA/gkn/main/openvpn/openvpn-install.sh -O openvpn-install.sh && \
   chmod +x openvpn-install.sh && \
   ./openvpn-install.sh


## ================================= INFO ==================================
# Which protocol do you want for OpenVPN connections?: 1
# What port do you want OpenVPN listening to?: 1194
# Which DNS do you want to use with the VPN?: 1
# Finally, tell me your name for the client certificate: client
# Press any key to continue...: <Enter>
## =========================================================================


cat  >/etc/openvpn/openvpn/server.conf
ip ad | grep tun0
ip route | grep tun0
traceroute 10.8.0.1

#  Создайте профиль пользователя OpenVPN (файл .ovpn)
./openvpn-install.sh 

exit 0
