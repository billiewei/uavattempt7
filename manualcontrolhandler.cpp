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
        emit xChanged();
    }
}

void ManualControlHandler::setY(int y){
    if(m_y != y){
        m_y = y;
        emit yChanged();
    }
}

void ManualControlHandler::setZ(int z){
    if(m_z != z){
        m_z = z;
        emit zChanged();
    }
}

void ManualControlHandler::setR(int r){
    if(m_r != r){
        m_r = r;
        emit rChanged();
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
       serial->close();
    }
}

void ManualControlHandler::initSerialConnections(){
    connect(serial, SIGNAL(readyRead()), this, SLOT(readData()));
    connect(serial, SIGNAL(flightLogReady()), this, SLOT(writeFlightLog()));
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

