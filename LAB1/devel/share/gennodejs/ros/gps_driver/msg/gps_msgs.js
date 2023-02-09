// Auto-generated. Do not edit!

// (in-package gps_driver.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class gps_msgs {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.Latitude = null;
      this.Longitude = null;
      this.Altitude = null;
      this.Utm_easting = null;
      this.Utm_northing = null;
      this.Zone = null;
      this.ZoneLetter = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('Latitude')) {
        this.Latitude = initObj.Latitude
      }
      else {
        this.Latitude = 0.0;
      }
      if (initObj.hasOwnProperty('Longitude')) {
        this.Longitude = initObj.Longitude
      }
      else {
        this.Longitude = 0.0;
      }
      if (initObj.hasOwnProperty('Altitude')) {
        this.Altitude = initObj.Altitude
      }
      else {
        this.Altitude = 0.0;
      }
      if (initObj.hasOwnProperty('Utm_easting')) {
        this.Utm_easting = initObj.Utm_easting
      }
      else {
        this.Utm_easting = 0.0;
      }
      if (initObj.hasOwnProperty('Utm_northing')) {
        this.Utm_northing = initObj.Utm_northing
      }
      else {
        this.Utm_northing = 0.0;
      }
      if (initObj.hasOwnProperty('Zone')) {
        this.Zone = initObj.Zone
      }
      else {
        this.Zone = '';
      }
      if (initObj.hasOwnProperty('ZoneLetter')) {
        this.ZoneLetter = initObj.ZoneLetter
      }
      else {
        this.ZoneLetter = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gps_msgs
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [Latitude]
    bufferOffset = _serializer.float64(obj.Latitude, buffer, bufferOffset);
    // Serialize message field [Longitude]
    bufferOffset = _serializer.float64(obj.Longitude, buffer, bufferOffset);
    // Serialize message field [Altitude]
    bufferOffset = _serializer.float64(obj.Altitude, buffer, bufferOffset);
    // Serialize message field [Utm_easting]
    bufferOffset = _serializer.float64(obj.Utm_easting, buffer, bufferOffset);
    // Serialize message field [Utm_northing]
    bufferOffset = _serializer.float64(obj.Utm_northing, buffer, bufferOffset);
    // Serialize message field [Zone]
    bufferOffset = _serializer.string(obj.Zone, buffer, bufferOffset);
    // Serialize message field [ZoneLetter]
    bufferOffset = _serializer.string(obj.ZoneLetter, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gps_msgs
    let len;
    let data = new gps_msgs(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [Latitude]
    data.Latitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Longitude]
    data.Longitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Altitude]
    data.Altitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Utm_easting]
    data.Utm_easting = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Utm_northing]
    data.Utm_northing = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Zone]
    data.Zone = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [ZoneLetter]
    data.ZoneLetter = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += _getByteLength(object.Zone);
    length += _getByteLength(object.ZoneLetter);
    return length + 48;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gps_driver/gps_msgs';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '24b26b8fd53a7bd4e0d9472d76a514cd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new gps_msgs(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.Latitude !== undefined) {
      resolved.Latitude = msg.Latitude;
    }
    else {
      resolved.Latitude = 0.0
    }

    if (msg.Longitude !== undefined) {
      resolved.Longitude = msg.Longitude;
    }
    else {
      resolved.Longitude = 0.0
    }

    if (msg.Altitude !== undefined) {
      resolved.Altitude = msg.Altitude;
    }
    else {
      resolved.Altitude = 0.0
    }

    if (msg.Utm_easting !== undefined) {
      resolved.Utm_easting = msg.Utm_easting;
    }
    else {
      resolved.Utm_easting = 0.0
    }

    if (msg.Utm_northing !== undefined) {
      resolved.Utm_northing = msg.Utm_northing;
    }
    else {
      resolved.Utm_northing = 0.0
    }

    if (msg.Zone !== undefined) {
      resolved.Zone = msg.Zone;
    }
    else {
      resolved.Zone = ''
    }

    if (msg.ZoneLetter !== undefined) {
      resolved.ZoneLetter = msg.ZoneLetter;
    }
    else {
      resolved.ZoneLetter = ''
    }

    return resolved;
    }
};

module.exports = gps_msgs;
