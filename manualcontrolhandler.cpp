#include "manualcontrolhandler.h"



ManualControlHandler::ManualControlHandler(QQuickItem* parent):
    QQuickItem(parent), m_log(""){
    serial = new MavSerialPort(this);
    initSerialPort();
    initSerialConnections();
}
QString ManualControlHandler::log(){
    return m_log;
}

void ManualControlHandler::setLog(QString l){
    m_log = l;
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
  //  connect(console, SIGNAL(getData(QByteArray)), this, SLOT(writeData(QByteArray)));
    connect(serial, SIGNAL(flightLogReady()), this, SLOT(writeFlightLog()));
}

void ManualControlHandler::readData(){
    QByteArray data = serial->readAll();
    serial->mavRead(&data);
}

void ManualControlHandler::writeFlightLog(){
    setLog(QString(serial->statustext.text));
}

