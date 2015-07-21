#ifndef VENDORHANDLER_H
#define VENDORHANDLER_H

#include <QQuickItem>
#include <QString>

class VendorHandler : public QQuickItem {
    Q_OBJECT
    Q_PROPERTY(int delivery READ delivery WRITE setDelivery NOTIFY deliveryChanged)
    Q_PROPERTY(bool valid1 READ valid1 WRITE setValid1 NOTIFY valid1Changed)
    Q_PROPERTY(bool valid2 READ valid2 WRITE setValid2 NOTIFY valid2Changed)
    Q_PROPERTY(bool valid3 READ valid3 WRITE setValid3 NOTIFY valid3Changed)
    Q_PROPERTY(QString name1 READ name1 WRITE setName1 NOTIFY name1Changed)
    Q_PROPERTY(QString name2 READ name2 WRITE setName2 NOTIFY name2Changed)
    Q_PROPERTY(QString name3 READ name3 WRITE setName3 NOTIFY name3Changed)
    Q_PROPERTY(QString street1 READ street1 WRITE setStreet1 NOTIFY street1Changed)
    Q_PROPERTY(QString street2 READ street2 WRITE setStreet2 NOTIFY street2Changed)
    Q_PROPERTY(QString street3 READ street3 WRITE setStreet3 NOTIFY street3Changed)
    Q_PROPERTY(QString city1 READ city1 WRITE setCity1 NOTIFY city1Changed)
    Q_PROPERTY(QString city2 READ city2 WRITE setCity2 NOTIFY city2Changed)
    Q_PROPERTY(QString city3 READ city3 WRITE setCity3 NOTIFY city3Changed)
    Q_PROPERTY(QString state1 READ state1 WRITE setState1 NOTIFY state1Changed)
    Q_PROPERTY(QString state2 READ state2 WRITE setState2 NOTIFY state2Changed)
    Q_PROPERTY(QString state3 READ state3 WRITE setState3 NOTIFY state3Changed)
    Q_PROPERTY(QString region1 READ region1 WRITE setRegion1 NOTIFY region1Changed)
    Q_PROPERTY(QString region2 READ region2 WRITE setRegion2 NOTIFY region2Changed)
    Q_PROPERTY(QString region3 READ region3 WRITE setRegion3 NOTIFY region3Changed)
    Q_PROPERTY(QString time1 READ time1 WRITE setTime1 NOTIFY time1Changed)
    Q_PROPERTY(QString time2 READ time2 WRITE setTime2 NOTIFY time2Changed)
    Q_PROPERTY(QString time3 READ time3 WRITE setTime3 NOTIFY time3Changed)
    Q_PROPERTY(int zip1 READ zip1 WRITE setZip1 NOTIFY zip1Changed)
    Q_PROPERTY(int zip2 READ zip2 WRITE setZip2 NOTIFY zip2Changed)
    Q_PROPERTY(int zip3 READ zip3 WRITE setZip3 NOTIFY zip3Changed)
    Q_PROPERTY(double price1 READ price1 WRITE setPrice1 NOTIFY price1Changed)
    Q_PROPERTY(double price2 READ price2 WRITE setPrice2 NOTIFY price2Changed)
    Q_PROPERTY(double price3 READ price3 WRITE setPrice3 NOTIFY price3Changed)

    Q_PROPERTY(double latitude READ latitude WRITE setLatitude NOTIFY latitudeChanged)
    Q_PROPERTY(double longitude READ longitude WRITE setLongitude NOTIFY longitudeChanged)

    public:
        VendorHandler(QQuickItem* parent = 0);
        Q_INVOKABLE void pass2to1();
        Q_INVOKABLE void pass3to2();
        Q_INVOKABLE void reset1();
        Q_INVOKABLE void reset2();
        Q_INVOKABLE void reset3();

    signals:
        void deliveryChanged();
        void valid1Changed();
        void valid2Changed();
        void valid3Changed();
        void latitudeChanged();
        void longitudeChanged();
        void name1Changed();
        void name2Changed();
        void name3Changed();
        void street1Changed();
        void street2Changed();
        void street3Changed();
        void city1Changed();
        void city2Changed();
        void city3Changed();
        void state1Changed();
        void state2Changed();
        void state3Changed();
        void region1Changed();
        void region2Changed();
        void region3Changed();
        void time1Changed();
        void time2Changed();
        void time3Changed();
        void zip1Changed();
        void zip2Changed();
        void zip3Changed();
        void price1Changed();
        void price2Changed();
        void price3Changed();

    public slots:

    private:
        bool order_valid[3];
        QString order_name[3];
        QString order_street[3];
        QString order_city[3];
        QString order_state[3];
        QString order_region[3];
        QString order_time[3];
        int order_zip[3];
        double order_price[3];

        double vendor_latitude;
        double vendor_longitude;
        //0  none
        //1 - order1
        //2 - order2
        //3 - order3
        int vendor_delivery;

        int delivery();
        bool valid1();
        bool valid2();
        bool valid3();
        double latitude();
        double longitude();
        QString name1();
        QString name2();
        QString name3();
        QString street1();
        QString street2();
        QString street3();
        QString city1();
        QString city2();
        QString city3();
        QString state1();
        QString state2();
        QString state3();
        QString region1();
        QString region2();
        QString region3();
        QString time1();
        QString time2();
        QString time3();
        int zip1();
        int zip2();
        int zip3();
        double price1();
        double price2();
        double price3();

        void setDelivery(int d);
        void setValid1(bool v);
        void setValid2(bool v);
        void setValid3(bool v);
        void setLatitude(double l);
        void setLongitude(double l);
        void setName1(QString n);
        void setName2(QString n);
        void setName3(QString n);
        void setStreet1(QString s);
        void setStreet2(QString s);
        void setStreet3(QString s);
        void setCity1(QString c);
        void setCity2(QString c);
        void setCity3(QString c);
        void setState1(QString s);
        void setState2(QString s);
        void setState3(QString s);
        void setRegion1(QString r);
        void setRegion2(QString r);
        void setRegion3(QString r);
        void setTime1(QString t);
        void setTime2(QString t);
        void setTime3(QString t);
        void setZip1(int z);
        void setZip2(int z);
        void setZip3(int z);
        void setPrice1(double p);
        void setPrice2(double p);
        void setPrice3(double p);
};

/**
    Text {
        id: order1_click
        text: "0"
        visible: false
    }
    Text {
        id: order1_name
        text: "Vinh N."
        visible: false
    }
    Text {
        id: order1_street
        text: "Hong Fung House"
        visible: false
    }
    Text {
        id: order1_city
        text: "Hong Kong"
        visible: false
    }
    Text {
        id: order1_state
        text: ""
        visible: false
    }
    Text {
        id: order1_zip
        text: ""
        visible:false
    }
    Text {
        id: order1_totalprice
        text: "50.00"
        visible: false
    }
    Text {
        id: order1_deliveryfee
        text: "$4.00"
        visible: false
    }
    Text {
        id: order1_grandtotal
        text: (order1_totalprice.text*1.08) + 4
        visible: false
    }
    Text {
        id: order1_order
        text: "1 Fried Chicken\n5 Fish & Chips"
        visible: false
    }
    Text {
        id: order1_number
        text: "2"
        visible: false
    }
    Text {
        id: order1_country
        text: "Hong Kong"
        visible: false
    }
    Text {
        id: order1_time
        y: order1.y
        text: "08:23"
        visible: order1.visible
        anchors.right: parent.right
        anchors.rightMargin: page.width * 0.1
        font.family: "Avenir"
        font.letterSpacing: 2
    }
  */

#endif // VENDERHANDLER_H
