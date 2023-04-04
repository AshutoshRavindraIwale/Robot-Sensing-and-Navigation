#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy
import utm
import serial
import sys
from lab4_driver.msg import *
from lab4_driver.msg import gps_msg

## Define the driver method
def driver():
    pub = rospy.Publisher('gps', gps_msg, queue_size=10)
    rospy.init_node('gps_driver', anonymous=True)
    msg = gps_msg()
    
    
    args = rospy.myargv(argv = sys.argv)
    

    connected_port = args[1]
    serial_port = rospy.get_param('~port',connected_port)
    serial_baud = rospy.get_param('~baudrate',4800)

    ser = serial.Serial(serial_port, serial_baud, timeout = 3)
    
    while not rospy.is_shutdown():
        recieve = str(ser.readline()) #read lines from the serial port 
        
        # Read only GPGGA data which corresponds to GPS
        if "$GPGGA" in str(recieve):
            data = str(recieve).split(",")
            print(data)
            
            #time conversion
            UTC = float(data[1])
            t=UTC
            
            utc_hrs = t//10000
            utc_min = (t - (utc_hrs*10000))//100
            utc_sec = ((t - (utc_hrs*10000) - (utc_min*100)))//1
            utc_deci_sec = t-(t//1)
            
            
            utc_final_secs = (utc_hrs*3600 + utc_min*60 + utc_sec)
            utc_final_nsecs = (utc_deci_sec* (10**9))
            #print(utc_hrs,utc_min,utc_sec,utc_deci_sec,utc_final_secs,utc_final_nsecs)
            
            lat = float(data[2])
            lat_deg = int(lat/100)
            lat_min = float(lat) - (lat_deg*100)
            lat_conv = float(lat_deg + lat_min/60)
            if data[3]=='S':
                lat_conv = lat_conv * (-1)
            
            long = float(data[4])
            long_deg = int(long/100)
            long_min = float(long) - (long_deg*100)
            long_conv = float(long_deg + long_min/60)
            if data[5]=='W':
                long_conv = long_conv * (-1)
            hdop = float(data[8])    
            alt = float(data[9])
            
            newlatlong = utm.from_latlon(lat_conv,long_conv)
            #print(f'UTM_East, UTM_north, Zone, Letter: {newlatlong}')
            
            
            msg.Header.stamp.secs = int(utc_final_secs)
            msg.Header.stamp.nsecs = int(utc_final_nsecs)
            msg.Header.frame_id = 'GPS1_FRAME'
            msg.Latitude = lat_conv
            msg.Longitude = long_conv
            msg.HDOP = hdop
            msg.Altitude = alt
            msg.UTM_easting = newlatlong[0]
            msg.UTM_northing = newlatlong[1]
            msg.UTC = UTC
            msg.Zone = newlatlong[2]
            msg.Letter = newlatlong[3]

            pub.publish(msg)
            

if __name__ == '__main__':
    try:
        driver()
    except rospy.ROSInterruptException:
        pass
