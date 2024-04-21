# Break down problem
```
problem: we need to combine yolov5 and pymavlink to send a value to GCS. 
The value needs to relate to what the yolov5 cv model detects to help 
the pilot find the target.

broken down:
- yolov5 saves images not videos
  (NOTE: COMMENTED view_img line)
  - python detect.py --weights yolov5s.pt --source 0  
    --weights best.pt --conf-thres 65 --max-det 1 --save-txt --save-csv --save-conf --save-crop
  (might need to run tcp connection for camera, src: https://docs.ultralytics.com/guides/raspberry-pi/#modify-detectpy)
  - libcamera-vid -n -t 0 --width 1280 --height 960 --framerate 1 --inline --listen -o tcp://127.0.0.1:8888
  - python3 detect.py --source tcp://127.0.0.1:8888 --view-img 
      --weights best.pt --conf-thres 65 --max-det 1 --save-txt --save-csv --save-conf --save-crop

- setup remote VNC on pi
  - (remote, might not work) https://www.youtube.com/watch?v=7vA5utwzY0E (done)
  - (w/ screen) https://www.youtube.com/watch?v=HEywFsFrj3I (done)

- need to download missionplanner log files

- setup yolov5 w/ camera/rpi
  - bash script to install requirements/commands?
  - test camera
    - command: libcamera-hello -t 25000
  - test pymavlink barebones with GCS (b)
    - need microUSB from pi to cube
    - need to find usb name (e.g. /dev/ttyAMA0)
      - command: ls /dev/tty*
      - alternative: udpin:localhost:14551
    - need to try qgroundcontrol

  - test barebones detect.py with our model (b)
    - try to get model from roboflow (b)
    - some used --source 0 
      - command: ls /dev/video* -l
  - obtain focal length -> fov, bounding box (b)
  - test dummy-base for errors compiling at least
  - check math on this

  loop (for testing):
    - add code to detect.py
      - bounding box (search dummy-base: line 203 Bounding boxes here???) (xyxy)
      - uses nested for loop
    - add failsafe? (ask about just using GCS for waypoint)

    - obtain focal length -> fov, bounding box
    - calculate relative yaw/pseudocode

    - send data via mavlink message
    - display value on GCS (Qgroundcontrol)

    - save GCS logs
```
Note: ((bounding_box_center - (camera_resolution / 2)) / camera_resolution) * camera_fov

--- 
# How to use
- mission planner or qgroundcontrol (both work because Mavlink Protocol is middle-layer)
- prepare python script on raspberry pi
  - yolov5, pymavlink, dronekit
    - Mavlink: NAMED_VALUE_FLOAT
  - connect to drone 1 not 255
  - connect via usb or telem2
- 
- telemetry modules
  - GCS (pins)
  - microUSB
- connect battery
- Mission planner
  - telemetry logs
  - setup > advanced > 2nd button (MAVLINK Inspector)
    - connect to drone 1 not 255
- Run python file

```
#Basic 
sudo python3 detect.py --weights 3-27-13-best.pt --source 0

#Advanced
libcamera-vid -n -t 0 --width 1280 --height 960 --framerate 1 --inline --listen -o tcp://127.0.0.1:8888

python3 detect.py --source tcp://127.0.0.1:8888 --view-img --weights best.pt --conf-thres 65 --max-det 1 --save-txt --save-csv --save-conf --save-crop

```

# Installations (Optional Bash barebones.sh)
```
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
```

# Tests and their output
```python client.py```
```
Example: x.x.x.x:12000
```

# Architecture/Design
```
dummy-base.py
step 1: parse through arguments like weights, confidence threshold, save-txt/cvs/img
step 1.5: connect to drone (Pi sends via USB/serial to cube. Cube sends data stream via telemtry radio to GCS)
step 2: load model
    - note: might need to comment out this line: (save_dir / "labels" if save_txt else save_dir).mkdir(parents=True, 
step 3: run inference
step 4: process predictions
step 5: show results (img feed)
    - runs in a nested for loop

#template
def method(arg1, arg2, arg3):
  """
  description
  
  Returns:
    None
  Example:
    >>> mesg, addr, port, seqRange = 'Howdy', localhost, 12000, 10
    >>> send(mesg, addr, port, seqRange)
  """