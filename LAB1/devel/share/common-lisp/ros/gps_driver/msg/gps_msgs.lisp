; Auto-generated. Do not edit!


(cl:in-package gps_driver-msg)


;//! \htmlinclude gps_msgs.msg.html

(cl:defclass <gps_msgs> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (Latitude
    :reader Latitude
    :initarg :Latitude
    :type cl:float
    :initform 0.0)
   (Longitude
    :reader Longitude
    :initarg :Longitude
    :type cl:float
    :initform 0.0)
   (Altitude
    :reader Altitude
    :initarg :Altitude
    :type cl:float
    :initform 0.0)
   (Utm_easting
    :reader Utm_easting
    :initarg :Utm_easting
    :type cl:float
    :initform 0.0)
   (Utm_northing
    :reader Utm_northing
    :initarg :Utm_northing
    :type cl:float
    :initform 0.0)
   (Zone
    :reader Zone
    :initarg :Zone
    :type cl:string
    :initform "")
   (ZoneLetter
    :reader ZoneLetter
    :initarg :ZoneLetter
    :type cl:string
    :initform ""))
)

(cl:defclass gps_msgs (<gps_msgs>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gps_msgs>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gps_msgs)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gps_driver-msg:<gps_msgs> is deprecated: use gps_driver-msg:gps_msgs instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <gps_msgs>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gps_driver-msg:header-val is deprecated.  Use gps_driver-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'Latitude-val :lambda-list '(m))
(cl:defmethod Latitude-val ((m <gps_msgs>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gps_driver-msg:Latitude-val is deprecated.  Use gps_driver-msg:Latitude instead.")
  (Latitude m))

(cl:ensure-generic-function 'Longitude-val :lambda-list '(m))
(cl:defmethod Longitude-val ((m <gps_msgs>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gps_driver-msg:Longitude-val is deprecated.  Use gps_driver-msg:Longitude instead.")
  (Longitude m))

(cl:ensure-generic-function 'Altitude-val :lambda-list '(m))
(cl:defmethod Altitude-val ((m <gps_msgs>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gps_driver-msg:Altitude-val is deprecated.  Use gps_driver-msg:Altitude instead.")
  (Altitude m))

(cl:ensure-generic-function 'Utm_easting-val :lambda-list '(m))
(cl:defmethod Utm_easting-val ((m <gps_msgs>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gps_driver-msg:Utm_easting-val is deprecated.  Use gps_driver-msg:Utm_easting instead.")
  (Utm_easting m))

(cl:ensure-generic-function 'Utm_northing-val :lambda-list '(m))
(cl:defmethod Utm_northing-val ((m <gps_msgs>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gps_driver-msg:Utm_northing-val is deprecated.  Use gps_driver-msg:Utm_northing instead.")
  (Utm_northing m))

(cl:ensure-generic-function 'Zone-val :lambda-list '(m))
(cl:defmethod Zone-val ((m <gps_msgs>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gps_driver-msg:Zone-val is deprecated.  Use gps_driver-msg:Zone instead.")
  (Zone m))

(cl:ensure-generic-function 'ZoneLetter-val :lambda-list '(m))
(cl:defmethod ZoneLetter-val ((m <gps_msgs>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gps_driver-msg:ZoneLetter-val is deprecated.  Use gps_driver-msg:ZoneLetter instead.")
  (ZoneLetter m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gps_msgs>) ostream)
  "Serializes a message object of type '<gps_msgs>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Latitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Longitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Altitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Utm_easting))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Utm_northing))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'Zone))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'Zone))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'ZoneLetter))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'ZoneLetter))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gps_msgs>) istream)
  "Deserializes a message object of type '<gps_msgs>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Latitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Longitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Altitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Utm_easting) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Utm_northing) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'Zone) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'Zone) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ZoneLetter) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'ZoneLetter) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gps_msgs>)))
  "Returns string type for a message object of type '<gps_msgs>"
  "gps_driver/gps_msgs")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gps_msgs)))
  "Returns string type for a message object of type 'gps_msgs"
  "gps_driver/gps_msgs")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gps_msgs>)))
  "Returns md5sum for a message object of type '<gps_msgs>"
  "24b26b8fd53a7bd4e0d9472d76a514cd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gps_msgs)))
  "Returns md5sum for a message object of type 'gps_msgs"
  "24b26b8fd53a7bd4e0d9472d76a514cd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gps_msgs>)))
  "Returns full string definition for message of type '<gps_msgs>"
  (cl:format cl:nil "Header header~%float64 Latitude~%float64 Longitude~%float64 Altitude~%float64 Utm_easting~%float64 Utm_northing~%string Zone~%string ZoneLetter~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gps_msgs)))
  "Returns full string definition for message of type 'gps_msgs"
  (cl:format cl:nil "Header header~%float64 Latitude~%float64 Longitude~%float64 Altitude~%float64 Utm_easting~%float64 Utm_northing~%string Zone~%string ZoneLetter~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gps_msgs>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     8
     8
     8
     8
     4 (cl:length (cl:slot-value msg 'Zone))
     4 (cl:length (cl:slot-value msg 'ZoneLetter))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gps_msgs>))
  "Converts a ROS message object to a list"
  (cl:list 'gps_msgs
    (cl:cons ':header (header msg))
    (cl:cons ':Latitude (Latitude msg))
    (cl:cons ':Longitude (Longitude msg))
    (cl:cons ':Altitude (Altitude msg))
    (cl:cons ':Utm_easting (Utm_easting msg))
    (cl:cons ':Utm_northing (Utm_northing msg))
    (cl:cons ':Zone (Zone msg))
    (cl:cons ':ZoneLetter (ZoneLetter msg))
))
