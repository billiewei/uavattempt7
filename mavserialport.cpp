#include "mavserialport.h"
#include "mavlink/v1.0/mavlink_msg_test_uorb.h"

int MavSerialPort::packageDrops = 0;
uint8_t MavSerialPort::msgReceived = false;

MavSerialPort::MavSerialPort(QObject* parent):
    QSerialPort(parent),system_id(0),component_id(0),
    target_system(1),target_component(0),
    x(0), y(0), z(0), r(0){

    timer = new QTimer(this);
    //connect(timer, SIGNAL(timeout()),this, SLOT(send_set_attitude_target()));
    connect(timer, SIGNAL(timeout()),this, SLOT(send_manual_control()));
    timer->start(200); //will move this to connect button
}

void MavSerialPort::setX(int t){
    x = (int16_t)t;
}

void MavSerialPort::setY(int t){
    y = (int16_t)t;
}

void MavSerialPort::setZ(int t){
    z = (int16_t)t;
}

void MavSerialPort::setR(int t){
    r = (int16_t)t;
}

void MavSerialPort::setLat(int32_t l){
    lat = l / 10000000.0;
}

void MavSerialPort::setLon(int32_t l){
    lon = l / 10000000.0;
}

void MavSerialPort::setAlt(int32_t a){
    relative_alt = a / 1000;
}

double MavSerialPort::latitude() const{
    return lat;
}

double MavSerialPort::longitude() const{
    return lon;
}

double MavSerialPort::relative_altitude() const{
    return relative_alt;
}

//11
void MavSerialPort::send_set_mode(){
    QByteArray ba;
  //  uint32_t custom_mode; ///< The new autopilot-specific mode. This field can be ignored by an autopilot.
  //  uint8_t target_system; ///< The system setting the mode
  //  uint8_t base_mode; ///< The new base mode

    write(ba);
}
//69
void MavSerialPort::send_manual_control(){
    mavlink_message_t msg;
    uint8_t buffer[2048];

    ///< X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle.
    ///< Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle.
    ///< Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle.
    ///< R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with counter-clockwise being 1000 and clockwise being -1000, and the yaw of a vehicle.

    uint16_t buttons = 0b0000000000000000; ///< A bitfield corresponding to the joystick buttons' current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1.


    mavlink_msg_manual_control_pack(0, 0, &msg, target_system, x, y, z, r, buttons);
    int size = mavlink_msg_to_send_buffer(buffer, &msg);

    QByteArray ba((char*)buffer,size);

    write(ba);
}
//76
void MavSerialPort::send_command_long(uint16_t CMD_ID, uint8_t confirmation, float f1, float f2, float f3, float f4, float f5, float f6, float f7){
    mavlink_message_t msg;
    uint8_t buffer[2048];

    mavlink_msg_command_long_pack(system_id, component_id, &msg, target_system, target_component,
                                  CMD_ID, confirmation, f1, f2, f3, f4, f5, f6, f7);

    int size = mavlink_msg_to_send_buffer(buffer, &msg);
    QByteArray ba((char*)buffer,size);
    write(ba);
}

//81
void MavSerialPort::send_manual_setpoint(){

    mavlink_message_t msg;
    uint8_t buffer[2048];

//todo: timestamp
    uint32_t time_boot_ms = 100000; ///< Timestamp in milliseconds since system boot
    float roll = 0; ///< Desired roll rate in radians per second
    float pitch = 0; ///< Desired pitch rate in radians per second
    float yaw = 1; ///< Desired yaw rate in radians per second
    float thrust = 0.2; ///< Collective thrust, normalized to 0 .. 1
    uint8_t mode_switch = 0; ///< Flight mode switch position, 0.. 255
    uint8_t manual_override_switch = 0; ///< Override mode switch position, 0.. 255
    mavlink_msg_manual_setpoint_pack(0,0, &msg, time_boot_ms, roll, pitch, yaw, thrust, mode_switch, manual_override_switch);


    // Pack a message to send it over a serial byte stream
    // MAVLINK_HELPER uint16_t
    // return MAVLINK_NUM_NON_PAYLOAD_BYTES + (uint16_t)msg->len;
    //(uint8_t *buffer, const mavlink_message_t *msg)

    int size = mavlink_msg_to_send_buffer(buffer, &msg);

    QByteArray ba((char*)buffer,size);

    write(ba);

    qDebug() << "send out manual setpoint\n";
}

//84
void MavSerialPort::send_position_target_local_ned(){
    mavlink_message_t msg;
    uint8_t buffer[2048];

    uint32_t time_boot_ms = 10000; ///< Timestamp in milliseconds since system boot
    float x = 1; ///< X Position in NED frame in meters
    float y = 0; ///< Y Position in NED frame in meters
    float z = 0; ///< Z Position in NED frame in meters (note, altitude is negative in NED)
    float vx = 0; ///< X velocity in NED frame in meter / s
    float vy = 1; ///< Y velocity in NED frame in meter / s
    float vz = 0; ///< Z velocity in NED frame in meter / s
    float afx = 0; ///< X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
    float afy = 0; ///< Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
    float afz = 1; ///< Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
    float yaw =1; ///< yaw setpoint in rad
    float yaw_rate = 3; ///< yaw rate setpoint in rad/s
    uint16_t type_mask = 0; ///< Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
    uint8_t coordinate_frame = 0; ///

    mavlink_msg_set_position_target_local_ned_pack(system_id, component_id, &msg, time_boot_ms, target_system, target_component, coordinate_frame, type_mask, x, y, z, vx, vy, vz, afx, afy, afz, yaw, yaw_rate);

    int size = mavlink_msg_to_send_buffer(buffer, &msg);

    QByteArray ba((char*)buffer,size);

    write(ba);
    qDebug() << "send out set position target local ned\n";
}

// #177
void MavSerialPort::send_test_urob(){

    mavlink_message_t msg;
    uint8_t buffer[1024];

    uint64_t timestamp = 2015;
    uint64_t shuai = 2016;

    mavlink_msg_test_uorb_pack(2,2, &msg, timestamp,shuai);

    int size = mavlink_msg_to_send_buffer(buffer, &msg);
    QByteArray ba((char*)buffer,size);
    write(ba);
    qDebug() << "send out test_uorb\n";
}

/** Set Mode */
void MavSerialPort::set_mode_offboard(){
     send_command_long(MAV_CMD_DO_SET_MODE,0,MAV_MODE_FLAG_SAFETY_ARMED + MAV_MODE_FLAG_CUSTOM_MODE_ENABLED, PX4_CUSTOM_MAIN_MODE_OFFBOARD,0,0,0,0,0);
}

void MavSerialPort::set_mode_disarm(){
    send_command_long(MAV_CMD_DO_SET_MODE,0,MAV_MODE_PREFLIGHT,0,0,0,0,0,0);
    //preflight mode is all zeros
    qDebug() << "MODE_PREFLIGHT";
}

void MavSerialPort::set_mode_arm(){
    send_command_long(MAV_CMD_DO_SET_MODE,0,MAV_MODE_FLAG_SAFETY_ARMED,0,0,0,0,0,0);
    qDebug() << "MODE_FLAG_SAFETY_ARMED";
}

void MavSerialPort::set_mode_return(){
    send_command_long(MAV_CMD_DO_SET_MODE,0, MAV_MODE_FLAG_SAFETY_ARMED + MAV_MODE_FLAG_CUSTOM_MODE_ENABLED,PX4_CUSTOM_MAIN_MODE_AUTO_RTL, 0,0,0,0,0);
    qDebug() << "PX4_CUSTOM_SUB_MODE_AUTO_RTL";
}

void MavSerialPort::set_mode_manual(){
    send_command_long(MAV_CMD_DO_SET_MODE,0, MAV_MODE_FLAG_SAFETY_ARMED + MAV_MODE_FLAG_CUSTOM_MODE_ENABLED, PX4_CUSTOM_MAIN_MODE_MANUAL,0,0,0,0,0);
    qDebug() << "PX4_CUSTOM_MAIN_MODE_MANUAL";

}

void MavSerialPort::set_mode_assist_altctl(){
    send_command_long(MAV_CMD_DO_SET_MODE,0, MAV_MODE_FLAG_SAFETY_ARMED + MAV_MODE_FLAG_CUSTOM_MODE_ENABLED, PX4_CUSTOM_MAIN_MODE_ALTCTL,0,0,0,0,0);
    qDebug() << "PX4_CUSTOM_MAIN_MODE_ALTCTL";
}

void MavSerialPort::set_mode_assist_posctl(){
    send_command_long(MAV_CMD_DO_SET_MODE,0, MAV_MODE_FLAG_SAFETY_ARMED + MAV_MODE_FLAG_CUSTOM_MODE_ENABLED, PX4_CUSTOM_MAIN_MODE_POSCTL,0,0,0,0,0);
    qDebug() << "PX4_CUSTOM_MAIN_MODE_POSCTL";
}

void MavSerialPort::set_mode_auto_mission(){
    send_command_long(MAV_CMD_DO_SET_MODE,0, MAV_MODE_FLAG_SAFETY_ARMED + MAV_MODE_FLAG_CUSTOM_MODE_ENABLED, PX4_CUSTOM_MAIN_MODE_AUTO,0,0,0,0,0);
    qDebug() << "PX4_CUSTOM_MAIN_MODE_AUTO";
}

void MavSerialPort::set_mode_auto_loiter(){
    send_command_long(MAV_CMD_DO_SET_MODE,0, MAV_MODE_FLAG_SAFETY_ARMED + MAV_MODE_FLAG_CUSTOM_MODE_ENABLED, PX4_CUSTOM_MAIN_MODE_AUTO_LOITER, 0,0,0,0,0);
    qDebug() << "PX4_CUSTOM_MAIN_MODE_AUTO_LOITER";
}

void MavSerialPort::set_mode_auto_delivery(){
    send_command_long(MAV_CMD_DO_SET_MODE,0, MAV_MODE_FLAG_SAFETY_ARMED + MAV_MODE_FLAG_CUSTOM_MODE_ENABLED, PX4_CUSTOM_MAIN_MODE_AUTO_DELIVERY,0,0,0,0,0);
    qDebug() << "PX4_CUSTOM_MAIN_MODE_DELIVERY";
}

//0
void MavSerialPort::heartbeat_handler(){
    mavlink_msg_heartbeat_decode(&message, &heartbeat);
    emit heartbeatReceived();
}

//1
void MavSerialPort::sys_status_handler(){
  //  qDebug() << "MAVLINK_MSG_ID_SYS_STATUS\n";
    mavlink_msg_sys_status_decode(&message, &sys_status);

    emit batteryChanged(sys_status.voltage_battery);
}

//30
void MavSerialPort::attitude_handler(){
  //  qDebug() << "MAVLINK_MSG_ID_ATTITUDE\n";
    mavlink_msg_attitude_decode(&message, &attitude);
    emit timeChanged();
    emit attitudeChanged();
}

//32
void MavSerialPort::local_position_ned_handler(){
   // qDebug() << "MAVLINK_MSG_ID_LOCAL_POSITION_NED\n";
    mavlink_msg_local_position_ned_decode(&message, &local_position_ned);
    emit localChanged();

}

//33
void MavSerialPort::global_position_int_handler(){
  //  qDebug() << "MAVLINK_MSG_ID_GLOBAL_POSITION_INT\n";
    mavlink_msg_global_position_int_decode(&message, &global_position_int);
    setLat(global_position_int.lat);
    setLon(global_position_int.lon);
    setAlt(global_position_int.relative_alt);
    emit globalChanged();
}

//105
void MavSerialPort::highres_imu_handler(){
  //  qDebug() << "MAVLINK_MSG_HIGHRES_IMU";
    mavlink_msg_highres_imu_decode(&message, &highres_imu);
    emit IMUChanged();
}

//253
void MavSerialPort::statustext_handler(){
    mavlink_msg_statustext_decode(&message, &statustext);
    emit flightLogReady();
}

void MavSerialPort::mavRead(QByteArray* ba){
    unsigned char *buf;
    buf = (unsigned char*)ba->data();

    //kernel part of the code
    for(int i = 0 ; i < ba->size(); i++){
        //does it matter if i change it to COMM_0 ?
        msgReceived = mavlink_parse_char(MAVLINK_COMM_1, buf[i], &message, &status);
        if(msgReceived){
            mavDecode(message);
            msgReceived = false;
        }
    }
}

void MavSerialPort::mavDecode(mavlink_message_t &message){
    switch (message.msgid){
    //0
    case MAVLINK_MSG_ID_HEARTBEAT:
        heartbeat_handler();
        break;

    //1
    case MAVLINK_MSG_ID_SYS_STATUS:
        sys_status_handler();
        break;

    //24
    case MAVLINK_MSG_ID_GPS_RAW_INT:
 //       gps_raw_int_handler();
        break;

    //30
    case MAVLINK_MSG_ID_ATTITUDE:
        attitude_handler();
        break;

    //32
    case MAVLINK_MSG_ID_LOCAL_POSITION_NED:
        local_position_ned_handler();
        break;

    //33
    case MAVLINK_MSG_ID_GLOBAL_POSITION_INT:
        global_position_int_handler();
        break;

    //42
    case MAVLINK_MSG_ID_MISSION_CURRENT:
        // mission_current_handler();
        break;

    //74
    case MAVLINK_MSG_ID_VFR_HUD:
        //vfr_hud_handler();
        break;

    //81
    case MAVLINK_MSG_ID_MANUAL_SETPOINT:
        //manual_setpoint_handler();
        break;

    //83
    case MAVLINK_MSG_ID_ATTITUDE_TARGET:
        //attitude_target_handler();
        break;

    //85
    case MAVLINK_MSG_ID_POSITION_TARGET_LOCAL_NED:
        // position_target_local_ned_handler();
        break;

    //87
    case MAVLINK_MSG_ID_POSITION_TARGET_GLOBAL_INT:
        // position_target_global_int_handler();
        break;

    //105
    case MAVLINK_MSG_ID_HIGHRES_IMU:
        highres_imu_handler();
        break;

    //147
    case MAVLINK_MSG_ID_BATTERY_STATUS:
       // battery_status_handler();
        break;

    //253
    case MAVLINK_MSG_ID_STATUSTEXT:
        statustext_handler();
        break;

    default:
        // qDebug() << "new message:" << (int)message.msgid;
        break;

    } // end of switch
}
