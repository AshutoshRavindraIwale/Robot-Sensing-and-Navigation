;; Auto-generated. Do not edit!


(when (boundp 'gps_driver::gps_msgs)
  (if (not (find-package "GPS_DRIVER"))
    (make-package "GPS_DRIVER"))
  (shadow 'gps_msgs (find-package "GPS_DRIVER")))
(unless (find-package "GPS_DRIVER::GPS_MSGS")
  (make-package "GPS_DRIVER::GPS_MSGS"))

(in-package "ROS")
;;//! \htmlinclude gps_msgs.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass gps_driver::gps_msgs
  :super ros::object
  :slots (_header _Latitude _Longitude _Altitude _Utm_easting _Utm_northing _Zone _ZoneLetter ))

(defmethod gps_driver::gps_msgs
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:Latitude __Latitude) 0.0)
    ((:Longitude __Longitude) 0.0)
    ((:Altitude __Altitude) 0.0)
    ((:Utm_easting __Utm_easting) 0.0)
    ((:Utm_northing __Utm_northing) 0.0)
    ((:Zone __Zone) "")
    ((:ZoneLetter __ZoneLetter) "")
    )
   (send-super :init)
   (setq _header __header)
   (setq _Latitude (float __Latitude))
   (setq _Longitude (float __Longitude))
   (setq _Altitude (float __Altitude))
   (setq _Utm_easting (float __Utm_easting))
   (setq _Utm_northing (float __Utm_northing))
   (setq _Zone (string __Zone))
   (setq _ZoneLetter (string __ZoneLetter))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:Latitude
   (&optional __Latitude)
   (if __Latitude (setq _Latitude __Latitude)) _Latitude)
  (:Longitude
   (&optional __Longitude)
   (if __Longitude (setq _Longitude __Longitude)) _Longitude)
  (:Altitude
   (&optional __Altitude)
   (if __Altitude (setq _Altitude __Altitude)) _Altitude)
  (:Utm_easting
   (&optional __Utm_easting)
   (if __Utm_easting (setq _Utm_easting __Utm_easting)) _Utm_easting)
  (:Utm_northing
   (&optional __Utm_northing)
   (if __Utm_northing (setq _Utm_northing __Utm_northing)) _Utm_northing)
  (:Zone
   (&optional __Zone)
   (if __Zone (setq _Zone __Zone)) _Zone)
  (:ZoneLetter
   (&optional __ZoneLetter)
   (if __ZoneLetter (setq _ZoneLetter __ZoneLetter)) _ZoneLetter)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float64 _Latitude
    8
    ;; float64 _Longitude
    8
    ;; float64 _Altitude
    8
    ;; float64 _Utm_easting
    8
    ;; float64 _Utm_northing
    8
    ;; string _Zone
    4 (length _Zone)
    ;; string _ZoneLetter
    4 (length _ZoneLetter)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float64 _Latitude
       (sys::poke _Latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Longitude
       (sys::poke _Longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Altitude
       (sys::poke _Altitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Utm_easting
       (sys::poke _Utm_easting (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Utm_northing
       (sys::poke _Utm_northing (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _Zone
       (write-long (length _Zone) s) (princ _Zone s)
     ;; string _ZoneLetter
       (write-long (length _ZoneLetter) s) (princ _ZoneLetter s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float64 _Latitude
     (setq _Latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Longitude
     (setq _Longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Altitude
     (setq _Altitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Utm_easting
     (setq _Utm_easting (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Utm_northing
     (setq _Utm_northing (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _Zone
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _Zone (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _ZoneLetter
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _ZoneLetter (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get gps_driver::gps_msgs :md5sum-) "24b26b8fd53a7bd4e0d9472d76a514cd")
(setf (get gps_driver::gps_msgs :datatype-) "gps_driver/gps_msgs")
(setf (get gps_driver::gps_msgs :definition-)
      "Header header
float64 Latitude
float64 Longitude
float64 Altitude
float64 Utm_easting
float64 Utm_northing
string Zone
string ZoneLetter

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



(provide :gps_driver/gps_msgs "24b26b8fd53a7bd4e0d9472d76a514cd")


