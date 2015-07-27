#include "manualcontrolhandler.h"

ManualControlHandler::ManualControlHandler(QQuickItem* parent):
    QQuickItem(parent), m_log(""),
    m_x(0), m_y(0), m_z(0), m_r(0){
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

void ManualControlHandler::setLog(QString l){
    if(m_log.compare(l)){
        m_log = l;
        emit logChanged();
    }
}

void ManualControlHandler::setX(int x){
    if(m_x != x){
        m_x = x;
 //       serial->setX(int16_t(x));
        emit xChanged(x);
    }
}

void ManualControlHandler::setY(int y){
    if(m_y != y){
        m_y = y;
   //     serial->setY(int16_t(y));
        emit yChanged(y);
    }
}

void ManualControlHandler::setZ(int z){
    if(m_z != z){
        m_z = z;
   //     serial->setZ(int16_t(z));
        emit zChanged(z);
    }
}

void ManualControlHandler::setR(int r){
    if(m_r != r){
        m_r = r;
   //     serial->setR(int16_t(r));
        emit rChanged(r);
    }
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
       serial->stopTimer();
       serial->close();
    }
}

void ManualControlHandler::initSerialConnections(){
    connect(serial, SIGNAL(readyRead()), this, SLOT(readData()));
    connect(serial, SIGNAL(flightLogReady()), this, SLOT(writeFlightLog()));
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

// Controls flight modes
void ManualControlHandler::setFlightMode(int m){
    if (0) {serial->set_mode_return();}
    else if (1) {
        serial->set_mode_manual();
        qDebug() << "Mode has been set to manual.";
    }
    else if (2) {
        serial->set_mode_assist_altctl();
        qDebug() << "Mode has been set to alt control.";
    }
    else if (3) {
        serial->set_mode_assist_posctl();
        qDebug() << "Mode has been set to pos control.";
    }
    else if (4) {
        serial->set_mode_auto_mission();
        qDebug() << "Mode has been set to auto mission.";
    }
    else if (5) {
        serial->set_mode_auto_loiter();
        qDebug() << "Mode has been set to auto loiter.";
    }
}
