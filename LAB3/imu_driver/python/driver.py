#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy
import utm
import serial
import sys
import numpy as np
from datetime import datetime
from imu_driver.msg import *
from imu_driver.msg import Vectornav
from imu_driver.srv import ConvertToQuaternion, ConvertToQuaternionResponse

def euler_to_quaternion(roll, pitch, yaw):
    rospy.wait_for_service('euler_to_quaternion')
    try:
        convert = rospy.ServiceProxy('euler_to_quaternion', ConvertToQuaternion)
        response = convert(roll, pitch, yaw)
        return response.x, response.y, response.z, response.w
    except rospy.ServiceException as e:
        print("Service call failed: ", e)


def driver():
    pub = rospy.Publisher('imu', Vectornav, queue_size=10)
    rospy.init_node('driver', anonymous=True)
    #rate = rospy.Rate(40)
    msg = Vectornav()

    args = rospy.myargv(argv = sys.argv)
    if len(args) != 2:
        print("error")
        sys.exit(1)

    connected_port = args[1]
    serial_port = rospy.get_param('~port',connected_port)
    serial_baud = rospy.get_param('~baudrate',115200)


    ser = serial.Serial(serial_port, serial_baud, timeout = 3)
    ser.write(b"$VNWRG,07,40*xx")
    while not rospy.is_shutdown():
        recieve = str(ser.readline())
        # recieve = recieve.decode('utf-8')

        if "$VNYMR" in str(recieve):
            data = str(recieve).split(",")
            print(data)

            now = rospy.get_rostime()
            rospy.loginfo("Current time %i %i", now.secs, now.nsecs)
            #now = datetime.now()
            #current_time = now.strftime("%H:%M:%S")
            #print("Current Time =", current_time)

            yaw = float(data[1])
            pitch = float(data[2])
            roll = float(data[3])
            magX = float(data[4])
            magY = float(data[5])
            magZ = float(data[6])
            accX = float(data[7])
            accY = float(data[8])
            accZ = float(data[9])
            gyroX = float(data[10])
            gyroY = float(data[11])
            gyroZ = float(data[12][0:9])

    
            msg.header.stamp.secs = int(now.secs)
            msg.header.stamp.nsecs = int(now.nsecs)
            msg.header.frame_id = 'IMU1_Frame'
            msg.IMU.orientation.x, msg.IMU.orientation.y, msg.IMU.orientation.z, msg.IMU.orientation.w = euler_to_quaternion(
                roll, pitch, yaw)
            msg.IMU.linear_acceleration.x = accX
            msg.IMU.linear_acceleration.y = accY
            msg.IMU.linear_acceleration.z = accZ
            msg.IMU.angular_velocity.x = gyroX
            msg.IMU.angular_velocity.y = gyroY
            msg.IMU.angular_velocity.z = gyroZ
            msg.MagField.magnetic_field.x = magX
            msg.MagField.magnetic_field.y = magY
            msg.MagField.magnetic_field.z = magZ
            msg.VNYMR = recieve

            pub.publish(msg)
           


if __name__ == '__main__':
    try:
        driver()
    except rospy.ROSInterruptException:
        pass
