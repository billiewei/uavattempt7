#ifndef MENUPAGEHANDLER_H
#define MENUPAGEHANDLER_H

#include <QQuickItem>
#include <QString>

class MenuPageHandler : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(int num1 READ num1 WRITE setNum1 NOTIFY num1Changed)
    Q_PROPERTY(int num2 READ num2 WRITE setNum2 NOTIFY num2Changed)
    Q_PROPERTY(int num3 READ num3 WRITE setNum3 NOTIFY num3Changed)
    Q_PROPERTY(int num4 READ num4 WRITE setNum4 NOTIFY num4Changed)
    Q_PROPERTY(double total READ total WRITE setTotal NOTIFY totalChanged)
    Q_PROPERTY(int weight READ weight WRITE setWeight NOTIFY weightChanged)

public:
    MenuPageHandler(QQuickItem* parent = 0);
    void setNum1(int n);
    void setNum2(int n);
    void setNum3(int n);
    void setNum4(int n);
    void setTotal(double t);
    void setWeight(int w);

    int num1();
    int num2();
    int num3();
    int num4();
    double total();
    int weight();

signals:
    void num1Changed();
    void num2Changed();
    void num3Changed();
    void num4Changed();
    void totalChanged();
    void weightChanged();


public slots:


private:

    int item1_weight;
    int item1_num;
    double item1_price;

    int item2_weight;
    int item2_num;
    double item2_price;

    int item3_weight;
    int item3_num;
    double item3_price;

    int item4_weight;
    int item4_num;
    double item4_price;

    double total_price;
    int total_weight;

    int calculate_total_weight();
    double calculate_total_price();

};

#endif // MENUPAGEHANDLER_H
