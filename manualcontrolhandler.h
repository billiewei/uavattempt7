#ifndef MANUALCONTROLHANDLER
#define MANUALCONTROLHANDLER

#include <QQuickItem>

class ManualControlHandler : public QQuickItem {

    public:
    public slots:
    private:
    signals:
        void armingstateChange();
        void throttleChanged();
        void yawChanged();
        void pitchChanged();
        void rollChanged();
};

#endif // MANUALCONTROLHANDLER

