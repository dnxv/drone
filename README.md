# Break down problem
```
problem: we need to combine yolov5 and pymavlink to send a value to GCS. 
The value needs to relate to what the yolov5 cv model detects to help 
the pilot find the target.

broken down:
- saves images not videos
  - python detect.py --weights yolov5s.pt --source 0  
    --weights best.pt --conf-thres 65 --max-det 1 --save-txt --save-csv --save-conf --save-crop

- setup remote VNC?
  - (remote, might not work) https://www.youtube.com/watch?v=7vA5utwzY0E (b)
  - (w/ screen) https://www.youtube.com/watch?v=HEywFsFrj3I (b)

- setup yolov5 on camera/rpi
  - bash script to install requirements/commands?
  - test pymavlink barebones with GCS (b)
  - test barebones detect.py with our model (b)
    - try to get model from roboflow
  - obtain focal length -> fov, bounding box (b)
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

--- 
# How to use
- mission planner
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
sudo python3 detect.py --weights 3-27-13-best.pt --source 0
```

# Install stuff
```
#comment here
code here
```

# Tests and their output
```python client.py```
```
Example: x.x.x.x:12000
```

# Architecture/Design
```
def method(arg1, arg2, arg3):
  """
  description
  
  Returns:
    None
  Example:
    >>> mesg, addr, port, seqRange = 'Howdy', localhost, 12000, 10
    >>> send(mesg, addr, port, seqRange)
  """