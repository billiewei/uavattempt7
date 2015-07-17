#include <QApplication>
#include <QQmlApplicationEngine>

#include "addresspagehandler.h"
#include "menupagehandler.h"
#include "vendorpagehandler.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<AddressPageHandler>("HKUST",1,0,"AddressPageHandler");
    qmlRegisterType<MenuPageHandler>("HKUST",1,0,"MenuPageHandler");
    qmlRegisterType<VendorPageHandler>("HKUST",1,0,"VendorPageHandler");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
