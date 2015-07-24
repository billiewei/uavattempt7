#include "manualcontrolhandler.h"



ManualControlHandler::ManualControlHandler(QQuickItem* parent): QQuickItem(parent){
    serial = new MavSerialPort(this);

  //initSerialConnections();
}
QString ManualControlHandler::log(){
    return m_log;
}

void ManualControlHandler::setLog(QString l){
    m_log = l;
}


/**
void ManualControlHandler::initSerialConnections(){
    connect(serial, SIGNAL(error(QSerialPort::SerialPortError)), this,
        SLOT(handleError(QSerialPort::SerialPortError)));
    connect(serial, SIGNAL(readyRead()), this, SLOT(readData()));
    connect(console, SIGNAL(getData(QByteArray)), this, SLOT(writeData(QByteArray)));
}
*/
