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

class gps_msg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.Header = null;
      this.Latitude = null;
      this.Longitude = null;
      this.Altitude = null;
      this.HDOP = null;
      this.UTM_easting = null;
      this.UTM_northing = null;
      this.UTC = null;
      this.Zone = null;
      this.Letter = null;
    }
    else {
      if (initObj.hasOwnProperty('Header')) {
        this.Header = initObj.Header
      }
      else {
        this.Header = new std_msgs.msg.Header();
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
      if (initObj.hasOwnProperty('HDOP')) {
        this.HDOP = initObj.HDOP
      }
      else {
        this.HDOP = 0.0;
      }
      if (initObj.hasOwnProperty('UTM_easting')) {
        this.UTM_easting = initObj.UTM_easting
      }
      else {
        this.UTM_easting = 0.0;
      }
      if (initObj.hasOwnProperty('UTM_northing')) {
        this.UTM_northing = initObj.UTM_northing
      }
      else {
        this.UTM_northing = 0.0;
      }
      if (initObj.hasOwnProperty('UTC')) {
        this.UTC = initObj.UTC
      }
      else {
        this.UTC = 0.0;
      }
      if (initObj.hasOwnProperty('Zone')) {
        this.Zone = initObj.Zone
      }
      else {
        this.Zone = 0.0;
      }
      if (initObj.hasOwnProperty('Letter')) {
        this.Letter = initObj.Letter
      }
      else {
        this.Letter = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gps_msg
    // Serialize message field [Header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.Header, buffer, bufferOffset);
    // Serialize message field [Latitude]
    bufferOffset = _serializer.float64(obj.Latitude, buffer, bufferOffset);
    // Serialize message field [Longitude]
    bufferOffset = _serializer.float64(obj.Longitude, buffer, bufferOffset);
    // Serialize message field [Altitude]
    bufferOffset = _serializer.float64(obj.Altitude, buffer, bufferOffset);
    // Serialize message field [HDOP]
    bufferOffset = _serializer.float64(obj.HDOP, buffer, bufferOffset);
    // Serialize message field [UTM_easting]
    bufferOffset = _serializer.float64(obj.UTM_easting, buffer, bufferOffset);
    // Serialize message field [UTM_northing]
    bufferOffset = _serializer.float64(obj.UTM_northing, buffer, bufferOffset);
    // Serialize message field [UTC]
    bufferOffset = _serializer.float64(obj.UTC, buffer, bufferOffset);
    // Serialize message field [Zone]
    bufferOffset = _serializer.float64(obj.Zone, buffer, bufferOffset);
    // Serialize message field [Letter]
    bufferOffset = _serializer.string(obj.Letter, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gps_msg
    let len;
    let data = new gps_msg(null);
    // Deserialize message field [Header]
    data.Header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [Latitude]
    data.Latitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Longitude]
    data.Longitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Altitude]
    data.Altitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [HDOP]
    data.HDOP = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [UTM_easting]
    data.UTM_easting = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [UTM_northing]
    data.UTM_northing = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [UTC]
    data.UTC = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Zone]
    data.Zone = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Letter]
    data.Letter = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.Header);
    length += _getByteLength(object.Letter);
    return length + 68;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gps_driver/gps_msg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '238eeb0f42036c6fea94b573f3a4b4e0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header Header
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new gps_msg(null);
    if (msg.Header !== undefined) {
      resolved.Header = std_msgs.msg.Header.Resolve(msg.Header)
    }
    else {
      resolved.Header = new std_msgs.msg.Header()
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

    if (msg.HDOP !== undefined) {
      resolved.HDOP = msg.HDOP;
    }
    else {
      resolved.HDOP = 0.0
    }

    if (msg.UTM_easting !== undefined) {
      resolved.UTM_easting = msg.UTM_easting;
    }
    else {
      resolved.UTM_easting = 0.0
    }

    if (msg.UTM_northing !== undefined) {
      resolved.UTM_northing = msg.UTM_northing;
    }
    else {
      resolved.UTM_northing = 0.0
    }

    if (msg.UTC !== undefined) {
      resolved.UTC = msg.UTC;
    }
    else {
      resolved.UTC = 0.0
    }

    if (msg.Zone !== undefined) {
      resolved.Zone = msg.Zone;
    }
    else {
      resolved.Zone = 0.0
    }

    if (msg.Letter !== undefined) {
      resolved.Letter = msg.Letter;
    }
    else {
      resolved.Letter = ''
    }

    return resolved;
    }
};

module.exports = gps_msg;
