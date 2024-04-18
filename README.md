# Break down problem
```
problem: we need to combine yolov5 and pymavlink to send a value to GCS. 
The value needs to relate to what the yolov5 cv model detects to help 
the pilot find the target.


- understand detect.py
  - bounding box
- need to combine detect.py, mavlink, dronekit
- pseudocode
- calculate FOV
- test rasp pi, python, libraries, camera, CV, pymavlink
  - libraries: pymavlink, cv2, 
- might need to record footage to decode drone flight?

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