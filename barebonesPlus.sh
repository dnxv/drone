#!/bin/sh

# current_file=$0
# cd "$(dirname "$current_file")"

sudo apt-get update -y

#yolov5
git clone https://github.com/ultralytics/yolov5
cd yolov5
#pip install -r requirements.txt
pip install -r requirements.txt --user
pip install torchvision 
pip install pymavlink

#ardupilot
sudo apt-get install git
sudo apt-get install gitk git-gui
git clone --recurse-submodules https://github.com/ArduPilot/ardupilot.git
cd ardupilot
Tools/environment_install/install-prereqs-ubuntu.sh -y
. ~/.profile

#dronekit
cd ~
git clone https://github.com/dronekit/dronekit-python
cd dronekit-python
sudo python setup.py install

#mv installs to /.local/python3/dist-packages /usr/local/lib/python3.9/dist-packages/yolov5
cd /.local/lib/python3.10/site-packages/
sudo mv ./* /usr/local/lib/python3.10/dist-packages

#########################################################
echo "complete!"