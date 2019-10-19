#!/bin/bash


echo Updating Raspbian
echo
sudo apt update
sudo apt upgrade --yes
sudo apt install vim --yes
echo 
echo Done updating Rapsbian

echo
echo installing Fanshim

cd
git clone https://github.com/pimoroni/fanshim-python
cd fanshim-python
sudo ./install.sh
cd examples
sudo ./install-service.sh --on-threshold 65 --off-threshold 55 --delay 2
cd
echo 
echo Done installing Fanshim

echo Installing Latest Node-Red
echo
cd lab-config 
bash update-nodejs-and-nodered.sh

echo
echo Done installing Node Red


echo updating Node Red to support Amazon Echo and Project
echo 
sudo cp /home/pi/lab-config/lib/systemd/system/nodered.service /lib/systemd/system
sudo systemctl enable --now nodered.service
sudo systemctl stop nodered.service
cp /home/pi/lab-config/node-red /home/pi/.node-red
sudo systemctl start nodered.service

echo done updating Node Red
echo
echo copying boot config
sudo cp /home/pi/boot /boot

echo
echo reboot to activate

cd ~/lab-config
git pull
cp -r /home/tux/lab-config/srv/* /srv/
