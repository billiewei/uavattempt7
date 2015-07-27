#ifndef MANUALCONTROLHANDLER
#define MANUALCONTROLHANDLER

#include <QtCore/QtGlobal>
#include <QQuickItem>
#include "mavserialport.h"

class ManualControlHandler : public QQuickItem {

    Q_OBJECT

    // Registers the item "log" as a QML property
    Q_PROPERTY(QString log READ log WRITE setLog NOTIFY logChanged)
    Q_PROPERTY(int x READ x WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ y WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int z READ z WRITE setZ NOTIFY zChanged)
    Q_PROPERTY(int r READ r WRITE setR NOTIFY rChanged)

    public:
        ManualControlHandler(QQuickItem* parent = 0);
        QString log() const;
        int x() const;
        int y() const;
        int z() const;
        int r() const;
        void setLog(QString l);
        void setX(int x);
        void setY(int y);
        void setZ(int z);
        void setR(int r);

    public slots:
        void readData();
        void writeFlightLog();

    signals:
        void logChanged();
        void xChanged();
        void yChanged();
        void zChanged();
        void rChanged();

    private:
        MavSerialPort* serial;
        QString m_log;
        int m_x;
        int m_y;
        int m_z;
        int m_r;
        void initSerialPort();
        void initSerialConnections();

};

#endif // MANUALCONTROLHANDLER

