
(cl:in-package :asdf)

(defsystem "gps_driver-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "gps_msg" :depends-on ("_package_gps_msg"))
    (:file "_package_gps_msg" :depends-on ("_package"))
  ))