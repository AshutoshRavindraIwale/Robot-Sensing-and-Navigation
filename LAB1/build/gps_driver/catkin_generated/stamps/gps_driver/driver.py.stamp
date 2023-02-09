import rospy
import math
import argparse
import time
from std_msgs.msg import Header
from gps_driver.msg import gps_msg
import sys

def nmea_to_decimal(nmea_string, direction):
    # Extract the degrees, minutes, and hemisphere from the NMEA string
  if type(nmea_string)==str:
    degrees = int(nmea_string[:2])
    minutes = float(nmea_string[2:])
    #hemisphere = nmea_string[-1]
   
    # Convert the minutes to decimal degrees
    decimal_degrees = degrees + minutes / 60
  #else:
    #print("no good string")
   
    # If the hemisphere is 'S' or 'W', negate the value
    if direction in ['S', 'W']:
        decimal_degrees = -decimal_degrees
   
    return decimal_degrees

def nmea_to_decimal_long(nmea_string, direction):
    # Extract the degrees, minutes, and hemisphere from the NMEA string
  if type(nmea_string)==str:
    degrees = int(nmea_string[:3])
    minutes = float(nmea_string[3:])
    #hemisphere = nmea_string[-1]
    #print(hemisphere)
   
    # Convert the minutes to decimal degrees
    decimal_degrees = degrees + minutes / 60
  #else:
    #print("no good string")
   
    # If the hemisphere is 'S' or 'W', negate the value
    if direction in ['S', 'W']:
        decimal_degrees = -decimal_degrees
   
    return decimal_degrees

import serial
parser = argparse.ArgumentParser(description='GPS Driver')
parser.add_argument('Port', type=str, help='Serial Port of the GPS Puck')
args = parser.parse_args(rospy.myargv(argv=sys.argv[1:]))
serialPort = serial.Serial(args.Port, baudrate=4800, timeout=3)
# Create a serial connection to the GPS puck using the port specified in the argument
serialPort = serial.Serial(args.Port, baudrate=4800, timeout=3)    


   
# Create a serial connection to the GPS puck using the port specified in the argument


try:
    while not rospy.is_shutdown():
        line = serialPort.readline()
        #if type(line)==str:
        #    print(line)
        #else:
        #    print("no string")
        substr = "GPGGA".upper()  
        #print(substr)
        splitting= line.decode('utf-8').strip()  
        #print(splitting)
        if substr in splitting:
               
            #print(splitting)
            splitted = splitting.split(',')
        #print(splitted)
            UTC = (splitted[1])
            Latitude = (splitted[2])
            Longitude = (splitted[4])
            HDOP = (splitted[8])
            Altitude = (splitted[9])

            Latitude = nmea_to_decimal(Latitude, splitted[3])
            Longitude = nmea_to_decimal_long(Longitude, splitted[5])
            #print(Latitude, Longitude)
            import utm
            UTM_easting, UTM_northing, Zone, Letter = utm.from_latlon(Latitude,Longitude)
            print(Latitude, Longitude, Altitude, HDOP, UTM_easting, UTM_northing, UTC, Zone, Letter)

            UTC = float(UTC)
            UTC_hour = int(UTC/10000)
            #print(UTC_hour)
            UTC_minutes = int((UTC - UTC_hour*10000)/100)
            #print(UTC_minutes)
            UTC_seconds = int(UTC - UTC_hour*10000 - UTC_minutes*100)
            #print(UTC_seconds)
            UTC_total_seconds = float(UTC_hour*3600 + UTC_minutes*60 + UTC_seconds)
            #print(UTC_total_seconds)
            UTC_nano_seconds = int((UTC - UTC_hour*10000 - UTC_minutes*100 - UTC_seconds)*(10**9))
            #print(UTC_nano_seconds)

            def gps_publisher():
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
           
            if __name__ == '__main__':
                try:
                    gps_publisher()
                except rospy.ROSInterruptException:
                    pass
        

   

except rospy.ROSInterruptException:
    port.close()