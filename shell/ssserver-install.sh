#!/bin/bash

# the next line is an example
# ./ssserver-install.sh AM\!@12 38
# this means password is AM!@12 and server port is 38

echo "————————————install python——————————————"
yum -y install epel-release
yum -y install python-pip
yum clean all

echo "————————————install shadowsocks server——————————————"
pip install --upgrade pip
pip install shadowsocks

if [ ! -n "$1" ]; then
    password="abcd1234"
else
    password=$1
fi

if [ ! -n "$2" ]; then
    port=38
else
    port=$2
fi


echo "your password is \"${password}\" your port is \"${port}\""

config="{\n\t\"server\": \"0.0.0.0\",\n\t\"server_port\": ${port},\n\t\"local_address\": \"127.0.0.1\",\n\t\"local_port\": 1080,\n\t\"password\": \"${password}\",\n\t\"timeout\": 2000,\n\t\"method\": \"aes-256-cfb\",\n\t\"fast_open\": false\n}"

echo "————————————config shadowsocks server——————————————"

echo -e ${config} >> /etc/shadowsocks.json

echo "————————————config shadowsocks service——————————————"

serviceScript="[Unit]\nDescription=Shadowsocks\n[Service]\nTimeoutStartSec=0\nExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json\n[Install]\nWantedBy=multi-user.target\n"
echo -e ${serviceScript} >> /etc/systemd/system/shadowsocks.service

systemctl enable shadowsocks.service
systemctl start shadowsocks
systemctl status shadowsocks

echo "————————————config firewall——————————————"

firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --reload
firewall-cmd --query-port=${port}/tcp

