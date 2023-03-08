#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import math
import numpy as np
import rospy
from imu_driver.srv import ConvertToQuaternion, ConvertToQuaternionResponse


class Quaternion:
    def __init__(self, x=0, y=0, z=0, w=1):
        self.x = x
        self.y = y
        self.z = z
        self.w = w


def handle_convert_to_quaternion(req):
    roll = req.roll
    pitch = req.pitch
    yaw = req.yaw

    quaternion = euler_to_quaternion(roll, pitch, yaw)

    return ConvertToQuaternionResponse(
        x=quaternion.x, y=quaternion.y, z=quaternion.z, w=quaternion.w)


def euler_to_quaternion_server():
    rospy.init_node('euler_to_quaternion_server')
    s = rospy.Service('euler_to_quaternion', ConvertToQuaternion, handle_convert_to_quaternion)
    rospy.spin()


def euler_to_quaternion(roll, pitch, yaw):
    yaw_radian = yaw*np.pi/180;
    pitch_radian = pitch*np.pi/180;
    roll_radian = roll*np.pi/180;
    cy = math.cos(yaw_radian * 0.5)
    sy = math.sin(yaw_radian * 0.5)
    cp = math.cos(pitch_radian * 0.5)
    sp = math.sin(pitch_radian * 0.5)
    cr = math.cos(roll_radian * 0.5)
    sr = math.sin(roll_radian * 0.5)

    qw = cy * cp * cr + sy * sp * sr
    qx = cy * cp * sr - sy * sp * cr
    qy = sy * cp * sr + cy * sp * cr
    qz = sy * cp * cr - cy * sp * sr

    return Quaternion(x=qx, y=qy, z=qz, w=qw)


if __name__ == '__main__':
    euler_to_quaternion_server()
