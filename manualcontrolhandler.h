#ifndef MANUALCONTROLHANDLER
#define MANUALCONTROLHANDLER

#include <QtCore/QtGlobal>
#include <QQuickItem>
#include "mavserialport.h"

class Console;
class MavSerialPort;

class ManualControlHandler : public QQuickItem {

    Q_OBJECT

    // Registers the item "log" as a QML property
    Q_PROPERTY(QString log READ log WRITE setLog NOTIFY logChanged)

    public:
        ManualControlHandler(QQuickItem* parent = 0);
        QString log();
        void setLog(QString l);

    public slots:
        void readData();
        void writeFlightLog();

    private:
        MavSerialPort* serial;
        QString m_log;

        void initSerialPort();
        void initSerialConnections();


      //  void initSerialConnections();

    //slots:

     //   void openSerialPort();
     //   void closeSerialPort();

    signals:
        void logChanged();

        /**
        void throttleChanged();
        void yawChanged();
        void pitchChanged();
        void rollChanged();
        */
};

#endif // MANUALCONTROLHANDLER

