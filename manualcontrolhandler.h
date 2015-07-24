#ifndef MANUALCONTROLHANDLER
#define MANUALCONTROLHANDLER

#include <QtCore/QtGlobal>
#include <QQuickItem>

#include <QMainWindow>
#include <QHBoxLayout>
#include <QPlainTextEdit>
#include <QVBoxLayout>
#include <QGridLayout>
#include <QGroupBox>
#include <QComboBox>
#include <QSlider>
#include <QLabel>
#include <QPushButton>
#include <QRadioButton>

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

    private:
        MavSerialPort* serial;
        QString m_log;

      //  void initSerialConnections();

    private slots:

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

