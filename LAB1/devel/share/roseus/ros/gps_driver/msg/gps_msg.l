;; Auto-generated. Do not edit!


(when (boundp 'gps_driver::gps_msg)
  (if (not (find-package "GPS_DRIVER"))
    (make-package "GPS_DRIVER"))
  (shadow 'gps_msg (find-package "GPS_DRIVER")))
(unless (find-package "GPS_DRIVER::GPS_MSG")
  (make-package "GPS_DRIVER::GPS_MSG"))

(in-package "ROS")
;;//! \htmlinclude gps_msg.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass gps_driver::gps_msg
  :super ros::object
  :slots (_Header _Latitude _Longitude _Altitude _HDOP _UTM_easting _UTM_northing _UTC _Zone _Letter ))

(defmethod gps_driver::gps_msg
  (:init
   (&key
    ((:Header __Header) (instance std_msgs::Header :init))
    ((:Latitude __Latitude) 0.0)
    ((:Longitude __Longitude) 0.0)
    ((:Altitude __Altitude) 0.0)
    ((:HDOP __HDOP) 0.0)
    ((:UTM_easting __UTM_easting) 0.0)
    ((:UTM_northing __UTM_northing) 0.0)
    ((:UTC __UTC) 0.0)
    ((:Zone __Zone) 0.0)
    ((:Letter __Letter) "")
    )
   (send-super :init)
   (setq _Header __Header)
   (setq _Latitude (float __Latitude))
   (setq _Longitude (float __Longitude))
   (setq _Altitude (float __Altitude))
   (setq _HDOP (float __HDOP))
   (setq _UTM_easting (float __UTM_easting))
   (setq _UTM_northing (float __UTM_northing))
   (setq _UTC (float __UTC))
   (setq _Zone (float __Zone))
   (setq _Letter (string __Letter))
   self)
  (:Header
   (&rest __Header)
   (if (keywordp (car __Header))
       (send* _Header __Header)
     (progn
       (if __Header (setq _Header (car __Header)))
       _Header)))
  (:Latitude
   (&optional __Latitude)
   (if __Latitude (setq _Latitude __Latitude)) _Latitude)
  (:Longitude
   (&optional __Longitude)
   (if __Longitude (setq _Longitude __Longitude)) _Longitude)
  (:Altitude
   (&optional __Altitude)
   (if __Altitude (setq _Altitude __Altitude)) _Altitude)
  (:HDOP
   (&optional __HDOP)
   (if __HDOP (setq _HDOP __HDOP)) _HDOP)
  (:UTM_easting
   (&optional __UTM_easting)
   (if __UTM_easting (setq _UTM_easting __UTM_easting)) _UTM_easting)
  (:UTM_northing
   (&optional __UTM_northing)
   (if __UTM_northing (setq _UTM_northing __UTM_northing)) _UTM_northing)
  (:UTC
   (&optional __UTC)
   (if __UTC (setq _UTC __UTC)) _UTC)
  (:Zone
   (&optional __Zone)
   (if __Zone (setq _Zone __Zone)) _Zone)
  (:Letter
   (&optional __Letter)
   (if __Letter (setq _Letter __Letter)) _Letter)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _Header
    (send _Header :serialization-length)
    ;; float64 _Latitude
    8
    ;; float64 _Longitude
    8
    ;; float64 _Altitude
    8
    ;; float64 _HDOP
    8
    ;; float64 _UTM_easting
    8
    ;; float64 _UTM_northing
    8
    ;; float64 _UTC
    8
    ;; float64 _Zone
    8
    ;; string _Letter
    4 (length _Letter)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _Header
       (send _Header :serialize s)
     ;; float64 _Latitude
       (sys::poke _Latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Longitude
       (sys::poke _Longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Altitude
       (sys::poke _Altitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _HDOP
       (sys::poke _HDOP (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _UTM_easting
       (sys::poke _UTM_easting (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _UTM_northing
       (sys::poke _UTM_northing (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _UTC
       (sys::poke _UTC (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Zone
       (sys::poke _Zone (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _Letter
       (write-long (length _Letter) s) (princ _Letter s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _Header
     (send _Header :deserialize buf ptr-) (incf ptr- (send _Header :serialization-length))
   ;; float64 _Latitude
     (setq _Latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Longitude
     (setq _Longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Altitude
     (setq _Altitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _HDOP
     (setq _HDOP (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _UTM_easting
     (setq _UTM_easting (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _UTM_northing
     (setq _UTM_northing (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _UTC
     (setq _UTC (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Zone
     (setq _Zone (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _Letter
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _Letter (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get gps_driver::gps_msg :md5sum-) "238eeb0f42036c6fea94b573f3a4b4e0")
(setf (get gps_driver::gps_msg :datatype-) "gps_driver/gps_msg")
(setf (get gps_driver::gps_msg :definition-)
      "Header Header
float64 Latitude
float64 Longitude
float64 Altitude
float64 HDOP
float64 UTM_easting
float64 UTM_northing
float64 UTC
float64 Zone
string Letter
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :gps_driver/gps_msg "238eeb0f42036c6fea94b573f3a4b4e0")


