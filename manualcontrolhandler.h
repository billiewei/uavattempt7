#ifndef MANUALCONTROLHANDLER
#define MANUALCONTROLHANDLER

#include <QtCore/QtGlobal>
#include <QQuickItem>

#include <QMainWindow>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QGridLayout>
#include <QGroupBox>
#include <QComboBox>
#include <QSlider>
#include <QLabel>
#include <QPushButton>
#include <QRadioButton>

class ManualControlHandler : public QQuickItem {

    Q_OBJECT
//    Q_PROPERTY(QString armingstate READ armingstate WRITE onSetArming NOTIFY armingStateChanged)

//    serial = new MavSerialPort(this);

    public:
        enum ARM_STATE {DISARMED = 0, ARMED = 1} arm_state;
    public slots:
    private:
        QRadioButton* armingstatetoggle;

        /** Manual control sliders */
        int throttle_control;
        int yaw_control;
        int pitch_control;
        int roll_control;

        QSlider* throttleSlider;
        QSlider* yawSlider;
        QSlider* pitchSlider;
        QSlider* rollSlider;
        QLabel* throttleValue;
        QLabel* yawValue;
        QLabel* pitchValue;
        QLabel* rollValue;

    private slots:
        void onSetArming();

    signals:
        void armingStateChanged(ARM_STATE s);
        void throttleChanged();
        void yawChanged();
        void pitchChanged();
        void rollChanged();
};

#endif // MANUALCONTROLHANDLER

