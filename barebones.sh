#!/bin/sh

# current_file=$0
# cd "$(dirname "$current_file")"

sudo apt-get update

git clone https://github.com/ultralytics/yolov5
cd yolov5

#pip install -r requirements.txt
pip install -r requirements.txt --user
pip install torchvision 
pip install pymavlink

#mv installs to /.local/python3/dist-packages /usr/local/lib/python3.9/dist-packages/yolov5
cd /.local/lib/python3.10/site-packages/
sudo mv ./* /usr/local/lib/python3.10/dist-packages

#########################################################
echo "complete!"