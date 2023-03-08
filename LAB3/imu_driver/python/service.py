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
    c_y = math.cos(yaw_radian * 0.5)
    s_y = math.sin(yaw_radian * 0.5)
    c_p = math.cos(pitch_radian * 0.5)
    s_p = math.sin(pitch_radian * 0.5)
    c_r = math.cos(roll_radian * 0.5)
    s_r = math.sin(roll_radian * 0.5)

    qw = c_y * c_p * c_r + s_y * s_p * s_r
    qx = c_y * c_p * s_r - s_y * s_p * c_r
    qy = s_y * c_p * s_r + c_y * s_p * c_r
    qz = s_y * c_p * c_r - c_y * s_p * s_r

    return Quaternion(x=qx, y=qy, z=qz, w=qw)


if __name__ == '__main__':
    euler_to_quaternion_server()
