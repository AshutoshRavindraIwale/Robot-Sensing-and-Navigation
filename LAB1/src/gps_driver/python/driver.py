import rospy
import math
import argparse
import time
from std_msgs.msg import Header
from gps_driver.msg import gps_msg
import sys

def Latitude_convertion(Nmeastr, direction):
    # Extract the degrees, minutes, and hemisphere from the NMEA string
  if type(Nmeastr)==str:
    deg = int(Nmeastr[:2])
    min = float(Nmeastr[2:])
    #hemisphere = nmea_string[-1]
   
    # Convert the minutes to decimal degrees
    decideg = deg + min / 60
  
   
   
    # If the hemisphere is 'S' or 'W', negate the value
    if direction in ['S', 'W']:
        decideg = -decideg
   
    return decideg

def Longitutde_convertion(nmea_string, direction):
    # Extract the degrees, minutes, and hemisphere from the NMEA string
  if type(nmea_string)==str:
    deg = int(nmea_string[:3])
    min = float(nmea_string[3:])
    
   
    # Convert the minutes to decimal degrees
    decideg = deg + min / 60
 
   
    # If the hemisphere is 'S' or 'W', negate the value
    if direction in ['S', 'W']:
        decideg = -decideg
        print(".....")
   
    return decideg

import serial
Parse_gpsdata = argparse.ArgumentParser(description='GPS Driver')
Parse_gpsdata.add_argument('Port', type=str, help='Serial Port of the GPS Puck')
args = Parse_gpsdata.parse_args(rospy.myargv(argv=sys.argv[1:]))
serialPort = serial.Serial(args.Port, baudrate=4800, timeout=3)
# Create a serial connection to the GPS puck using the port specified in the argument
serialPort = serial.Serial(args.Port, baudrate=4800, timeout=3)    


   
# Create a serial connection to the GPS puck using the port specified in the argument


try:
    while not rospy.is_shutdown():
        line_ = serialPort.readline()
        
        sub_string = "GPGGA" 
       
        stripping= line_.decode('utf-8').strip()  
        
        if sub_string in stripping:
               
            
            seperation = stripping.split(',')
        
            UTC = (seperation[1])
            Latitude = (seperation[2])
            Longitude = (seperation[4])
            HDOP = (seperation[8])
            Altitude = (seperation[9])

            Latitude = Latitude_convertion(Latitude, seperation[3])
            Longitude = Longitutde_convertion(Longitude, seperation[5])
            
            import utm
            UTM_easting, UTM_northing, Zone, Letter = utm.from_latlon(Latitude,Longitude)
            print(Latitude, Longitude, Altitude, HDOP, UTM_easting, UTM_northing, UTC, Zone, Letter)

            UTC = float(UTC)
            UTC_hour = int(UTC/10000)
            UTC_minutes = int((UTC - UTC_hour*10000)/100)
            UTC_seconds = int(UTC - UTC_hour*10000 - UTC_minutes*100)
            UTC_total_seconds = float(UTC_hour*3600 + UTC_minutes*60 + UTC_seconds)
            UTC_nano_seconds = int((UTC - UTC_hour*10000 - UTC_minutes*100 - UTC_seconds)*(10**9))
            

            pub = rospy.Publisher('gps', gps_msg, queue_size=10)
            rospy.init_node('gps_publisher', anonymous=True)
            rate = rospy.Rate(10)  # 10 Hz
            msg = gps_msg()
            msg.Header.stamp.secs = int(UTC_total_seconds)
            msg.Header.stamp.nsecs = UTC_nano_seconds
            msg.Header.frame_id = "GPS1_Frame"
            msg.Latitude = Latitude
            msg.Longitude = Longitude
            msg.Altitude = float(Altitude)
            msg.HDOP = float(HDOP)
            msg.UTM_easting = UTM_easting
            msg.UTM_northing = UTM_northing
            msg.UTC = float(UTC)
            msg.Zone = Zone
            msg.Letter = Letter
            rospy.loginfo(msg)
            pub.publish(msg)
            rate.sleep()
           
           
        

   

except rospy.ROSInterruptException:
    port.close()
