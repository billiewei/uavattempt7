#ifndef MANUALCONTROLHANDLER
#define MANUALCONTROLHANDLER

#include <QtCore/QtGlobal>
#include <QQuickItem>
#include <QPushButton>
#include <QRadioButton>
#include <QSlider>
#include <QLabel>
#include "mavserialport.h"

class ManualControlHandler : public QQuickItem {

    Q_OBJECT

    // flight log
    Q_PROPERTY(QString log READ log WRITE setLog NOTIFY logChanged)

    // control sliders
    Q_PROPERTY(int x READ x WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ y WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int z READ z WRITE setZ NOTIFY zChanged)
    Q_PROPERTY(int r READ r WRITE setR NOTIFY rChanged)

    // battery estimation
    Q_PROPERTY(int voltage READ voltage WRITE setVoltage NOTIFY voltageChanged)

    // GPS for map
    Q_PROPERTY(double latitude READ latitude WRITE setLatitude NOTIFY latitudeChanged)
    Q_PROPERTY(double longitude READ longitude WRITE setLongitude NOTIFY longitudeChanged)
    Q_PROPERTY(double height READ height WRITE setHeight NOTIFY heightChanged)

    public:
        ManualControlHandler(QQuickItem* parent = 0);
        QString log() const;
        int x() const;
        int y() const;
        int z() const;
        int r() const;
        int voltage() const;
        float latitude() const;
        float longitude() const;
        double height() const;
        inline double m_time() const;
        inline double m_battery() const; //Remaining battery percentage

    public slots:
        void readData();
        void writeFlightLog();
        void setArmed(bool armed);
        void setFlightMode(int m);
        void setLog(QString l);
        void updateLocation();

        void setX(int x);
        void setY(int y);
        void setZ(int z);
        void setR(int r);
        void setVoltage(int v);
        void setLatitude(double l);
        void setLongitude(double l);
        void setHeight(double h);

    signals:
        void logChanged();
        void xChanged(int x);
        void yChanged(int y);
        void zChanged(int z);
        void rChanged(int r);
        void voltageChanged(int v);
        void latitudeChanged(double l);
        void longitudeChanged(double l);
        void heightChanged(double h);

    private:
        MavSerialPort* serial;
        QString m_log;
        int m_x;
        int m_y;
        int m_z;
        int m_r;
        int m_voltage; //unit: mV

        float m_latitude;
        float m_longitude;
        double m_height;

        void initSerialPort();
        void initSerialConnections();
};

#endif // MANUALCONTROLHANDLER

