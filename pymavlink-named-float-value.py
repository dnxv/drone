#credit goes to Jordan

import time
from pymavlink import mavutil
import random
import os

# Wait for the connection to be established
def wait_conn(device):
    msg = None
    global boot_time

    while msg is None:
        device.mav.ping_send(
            int((time.time() - boot_time) * 1e6),
            0,
            0,
            0
        )
        msg = device.recv_match()
        time.sleep(0.5)

# Main function
if __name__ == "__main__":
    boot_time = time.time()

    # Make the connection use MAVLink 2.0
    os.environ['MAVLINK20'] = "1"

    # Connect to the vehicle
    drone = mavutil.mavlink_connection('com7', source_system=1, source_component=10)
    wait_conn(drone)

    # Send a random float every second
    while True:
        drone.mav.named_value_float_send(
            int((time.time() - boot_time) * 1e3),
            'test_float'.encode(),
            random.random()
        )

        time.sleep(1)