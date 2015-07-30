#ifndef MAVSERIALPORT_H
#define MAVSERIALPORT_H

#include <QSerialPort>
#include <QByteArray>
#include <QString>
#include <QDebug>
#include <QTimer>

#include "mavlink/v1.0/common/mavlink.h"
#include "mavlink/v1.0/pixhawk/mavlink.h"
#include "px4_custom_mode.h"


class MavSerialPort: public QSerialPort {
    Q_OBJECT

public:
    QTimer* timer;
    MavSerialPort(QObject* parent);

    void mavRead(QByteArray* ba);
    void mavDecode(mavlink_message_t &message);

    double latitude() const;
    double longitude() const;
    double relative_altitude() const;

    //0
    inline void heartbeat_handler();
    //1
    inline void sys_status_handler();
    //30
    inline void attitude_handler();
    //32
    inline void local_position_ned_handler();
    //33
    inline void global_position_int_handler();
    //105
    inline void highres_imu_handler();
    //253
    inline void statustext_handler();

    static int packageDrops; //do we need this?
    static uint8_t msgReceived; // do we need this?

    mavlink_message_t message;
    mavlink_status_t status;

    //0
    mavlink_heartbeat_t heartbeat;
    //1
    mavlink_sys_status_t sys_status;
    //30
    mavlink_attitude_t attitude;
    //32
    mavlink_local_position_ned_t local_position_ned;
    //33
    mavlink_global_position_int_t global_position_int;
    //105
    mavlink_highres_imu_t highres_imu;
    //253
    mavlink_statustext_t statustext;

signals:
    void heartbeatReceived();//message #0 HEARTBEAT
    void batteryChanged(int v); //message #1 SYS_STATUS

    void timeChanged();
    void localChanged();
    void globalChanged();

    void IMUChanged();
    void attitudeChanged();

    void flightLogReady();

public slots:

    /** react to control sliders */
    void setX(int t);
    void setY(int t);
    void setZ(int t);
    void setR(int t);

    void setLat(int32_t l);
    void setLon(int32_t l);
    void setAlt(int32_t a);

    /** Set Mode */
    void set_mode_disarm();
    void set_mode_arm();
    void set_mode_offboard();
    void set_mode_return();
    void set_mode_manual();
    void set_mode_assist_altctl();
    void set_mode_assist_posctl();
    void set_mode_auto_mission();
    void set_mode_auto_loiter();
    void set_mode_auto_delivery();

    //11
    void send_set_mode();
    //69
    void send_manual_control();
    //81
    void send_manual_setpoint();
    //84
    void send_position_target_local_ned();
    //177
    void send_test_urob();

private:

    uint8_t system_id;//ID of the sending system
    uint8_t component_id;//ID of the sending component
    uint8_t target_system;//ID of receiving system. px4 by default is 1
    uint8_t target_component;//ID of receiving component. 0 for all component

    /** global position int
     * filtered global position with GPS and accelerometers
     */

    double lat; //correct latitude
    double lon; //correct longitude
    double relative_alt; //correct altitude above ground in meter

    int16_t x;
    int16_t y;
    int16_t z;
    int16_t r;

    //76
    void send_command_long(uint16_t CMD_ID, uint8_t confirmation, float f1, float f2, float f3, float f4, float f5, float f6, float f7);
};
#endif // MAVSERIALPORT_H

