#ifndef VENDORPAGEHANDLER_H
#define VENDORPAGEHANDLER_H

#include <QQuickItem>
#include <QString>

class VendorPageHandler : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(bool order1 READ order1 WRITE setOrder1 NOTIFY order1Changed)
    Q_PROPERTY(bool order2 READ order2 WRITE setOrder2 NOTIFY order2Changed)
    Q_PROPERTY(bool order3 READ order3 WRITE setOrder3 NOTIFY order3Changed)
public:
    VendorPageHandler(QQuickItem* parent = 0);
    bool order1();
    bool order2();
    bool order3();
    void setOrder1(bool o);
    void setOrder2(bool o);
    void setOrder3(bool o);

signals:
    void order1Changed();
    void order2Changed();
    void order3Changed();

public slots:

private:
    bool order_valid[3];
};

#endif // VENDERPAGEHANDLER_H
