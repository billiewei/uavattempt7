#include "manualcontrolhandler.h"
#include <cmath>

ManualControlHandler::ManualControlHandler(QQuickItem* parent):
    QQuickItem(parent), m_log(""),
    m_x(0), m_y(0), m_z(0), m_r(0),
    m_voltage(), m_latitude(), m_longitude(), m_height(0){
    serial = new MavSerialPort(this);
    initSerialPort();
    initSerialConnections();
}

QString ManualControlHandler::log() const{
    return m_log;
}

int ManualControlHandler::x() const{
    return m_x;
}
int ManualControlHandler::y() const{
    return m_y;
}
int ManualControlHandler::z() const{
    return m_z;
}
int ManualControlHandler::r() const{
    return m_r;
}

int ManualControlHandler::voltage() const{
    return m_voltage;
}

double ManualControlHandler::latitude() const{
    return m_latitude;
}

double ManualControlHandler::longitude() const{
    return m_longitude;
}

double ManualControlHandler::height() const{
    return m_height;
}

void ManualControlHandler::setLog(QString l){
    if(m_log.compare(l)){
        m_log = l;
        emit logChanged();
    }
}

void ManualControlHandler::setX(int x){
    if(m_x != x){
        m_x = x;
        emit xChanged(x);
    }
}

void ManualControlHandler::setY(int y){
    if(m_y != y){
        m_y = y;
        emit yChanged(y);
    }
}

void ManualControlHandler::setZ(int z){
    if(m_z != z){
        m_z = z;
        emit zChanged(z);
    }
}

void ManualControlHandler::setR(int r){
    if(m_r != r){
        m_r = r;
        emit rChanged(r);
    }
}

inline double ManualControlHandler::m_time() const{
    return (2/3)*(25.0 - std::exp(m_voltage - 13.48));
}

inline double ManualControlHandler::m_battery() const{
    qDebug() << "Battery levels should have been updated";
    return 13.48 - std::log((-1.5 * m_time()) + 25.0);
}

void ManualControlHandler::setVoltage(int v){
    if (m_voltage != v) {
        m_voltage = v;
        qDebug() << voltage();
        emit voltageChanged(v);
    }
}

void ManualControlHandler::setLatitude(double l){
        m_latitude = l;
        emit latitudeChanged(l);
}

void ManualControlHandler::setLongitude(double l){
        m_longitude = l;
        emit longitudeChanged(l);
}

void ManualControlHandler::setHeight(double h){
        m_height = h;
        emit heightChanged(h);
}

void ManualControlHandler::initSerialPort(){
    //note that apple products use absolute address
    //need to deal with open error
    serial->setPortName("/dev/cu.SLAB_USBtoUART");
    serial->setBaudRate(QSerialPort::Baud57600);
    serial->setDataBits(QSerialPort::Data8);
    serial->setParity(QSerialPort::NoParity);
    serial->setStopBits(QSerialPort::OneStop);
    serial->setFlowControl(QSerialPort::NoFlowControl);
    if (serial->open(QIODevice::ReadWrite)) {
       qDebug() << "serial port is open now";
    }else {
       qDebug() << "serial port open fails";
       serial->timer->stop();
       serial->close();
    }
}

void ManualControlHandler::initSerialConnections(){
    connect(serial, SIGNAL(readyRead()), this, SLOT(readData()));
    connect(serial, SIGNAL(flightLogReady()), this, SLOT(writeFlightLog()));
    connect(serial, SIGNAL(batteryChanged(int)), this, SLOT(setVoltage(int)));
    connect(serial, SIGNAL(globalChanged()), this, SLOT(updateLocation()));
    connect(this, SIGNAL(xChanged(int)), serial, SLOT(setX(int)));
    connect(this, SIGNAL(yChanged(int)), serial, SLOT(setY(int)));
    connect(this, SIGNAL(zChanged(int)), serial, SLOT(setZ(int)));
    connect(this, SIGNAL(rChanged(int)), serial, SLOT(setR(int)));
}

void ManualControlHandler::readData(){
    QByteArray data = serial->readAll();
    serial->mavRead(&data);
}

void ManualControlHandler::writeFlightLog(){
    setLog(QString(serial->statustext.text));
}

void ManualControlHandler::setArmed(bool armed){
    if (armed) {
        serial->set_mode_arm();
    }
    else {
        serial->set_mode_disarm();
    }
}

void ManualControlHandler::updateLocation(){
    setLatitude(serial->latitude());
    setLongitude(serial->longitude());
    setHeight(serial->relative_altitude());
}

// Controls flight modes
void ManualControlHandler::setFlightMode(int m){
    switch (m){
    case 0:
        serial->set_mode_return();
        qDebug() <<"*********MODE SET TO RETURN*********";
        break;
    case 1:
        serial->set_mode_manual();
        qDebug() << "*********MODE SET TO MANUAL*********";
        break;
    case 2:
        serial->set_mode_assist_altctl();
        qDebug() << "*********MODE SET TO ASSIST ALTCTL*********";
        break;
    case 3:
        serial->set_mode_assist_posctl();
        qDebug() << "*********MODE SET TO ASSIST POSTCTL*********";
        break;
    case 4:
        serial->set_mode_auto_mission();
        qDebug() << "*********MODE SET TO AUTO MISSION*********";
        break;
    case 5:
        serial->set_mode_auto_loiter();
        qDebug() << "*********MODE SET TO AUTO LOITER*********";
        break;
    case 6:
        serial->set_mode_auto_delivery();
        qDebug() << "*********MODE SET TO DELIVERY*********";
        break;
    }
}
