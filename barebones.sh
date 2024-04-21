#!/bin/sh

# (ignore): current_file=$0
# (ignore): cd "$(dirname "$current_file")"


#sudo su -
#apt update
#apt full-upgrade

#this file was in Downloads

# switched to Generic 101-key PC

# command for testing camera: libcamera-hello
# command for camera image: libcamera-jpeg -o test.jpg
# command to install vscode: sudo apt install code 

# camera fix -> edit /boot/firmware/config.txt
# sudo nano /boot/firmware/config.txt
# edits below:
# display_auto_detect=0
# dtoverlay=imx708


sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
cd ~

git clone https://github.com/ultralytics/yolov5
cd yolov5

#pip install libraries
sudo rm /usr/lib/python3.11/EXTERNALLY-MANAGED
pip install -r requirements.txt --user
pip install torchvision 
pip install pymavlink

#mv installs to /.local/python3/dist-packages /usr/local/lib/python3.9/dist-packages/yolov5
cd ~
cd .local/lib/python3.11/site-packages/
sudo mv ./* /usr/local/lib/python3.11/dist-packages

#########################################################
echo "complete!"