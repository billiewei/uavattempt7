#include <QApplication>
#include <QQmlApplicationEngine>

#include "addresspagehandler.h"
#include "batterypagehandler.h"
#include "menupagehandler.h"
#include "vendorhandler.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<AddressPageHandler>("HKUST",1,0,"AddressPageHandler");
    qmlRegisterType<MenuPageHandler>("HKUST",1,0,"MenuPageHandler");
    qmlRegisterType<VendorHandler>("HKUST",1,0,"VendorHandler");
    qmlRegisterType<BatteryPageHandler>("HKUST",1,0,"BatteryPageHandler");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
