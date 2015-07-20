#ifndef BATTERYPAGEHANDLER_H
#define BATTERYPAGEHANDLER_H

#include <QQuickItem>

class BatteryPageHandler : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int percentage READ percentage WRITE setPercentage NOTIFY percentageChanged)

public:
    BatteryPageHandler(QQuickItem* parent = 0);
    int percentage();
    void setPercentage(int p);

signals:
    void percentageChanged();

public slots:

private:
    int battery_percent;
};

#endif // BATTERYPAGEHANDLER_H
