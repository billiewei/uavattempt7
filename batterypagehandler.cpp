#include "batterypagehandler.h"

BatteryPageHandler::BatteryPageHandler(QQuickItem *parent):
    QQuickItem(parent), battery_percent(100)
{

}

int BatteryPageHandler::percentage(){
    return battery_percent;
}

void BatteryPageHandler::setPercentage(int p){
    if(battery_percent != p){
        battery_percent = p;
        emit percentageChanged();
    }
}
