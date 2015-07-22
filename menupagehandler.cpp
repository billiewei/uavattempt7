#include "menupagehandler.h"

MenuPageHandler::MenuPageHandler(QQuickItem *parent):QQuickItem(parent),
    // Item weights and prices for calculation
    item1_weight(100), item1_num(0), item1_price(7.0),
    item2_weight(150), item2_num(0), item2_price(6.0),
    item3_weight(200), item3_num(0), item3_price(9.0),
    item4_weight(160), item4_num(0), item4_price(8.0),
    total_price(0), total_weight(0){

}

void MenuPageHandler::setNum1(int n){
    if (item1_num != n) {
        item1_num = n;
        setTotal(calculate_total_price());
        setWeight(calculate_total_weight());
        emit num1Changed();
    }
}

void MenuPageHandler::setNum2(int n){
    if (item2_num != n) {
        item2_num = n;
        setTotal(calculate_total_price());
        setWeight(calculate_total_weight());
        emit num2Changed();
    }
}

void MenuPageHandler::setNum3(int n){
    if (item3_num != n) {
        item3_num = n;
        setTotal(calculate_total_price());
        setWeight(calculate_total_weight());
        emit num3Changed();
    }
}

void MenuPageHandler::setNum4(int n){
    if (item4_num != n) {
        item4_num = n;
        setTotal(calculate_total_price());
        setWeight(calculate_total_weight());
        emit num4Changed();
    }
}


void MenuPageHandler::setTotal(double t){
    if ( abs(total_price - t) > 0.1 ) {
        total_price = t;
        emit totalChanged();
    }
}

void MenuPageHandler::setWeight(int w){
    if ( total_weight != w ) {
        total_weight = w;
        emit weightChanged();
    }
}


int MenuPageHandler::num1(){
    return item1_num;
}

int MenuPageHandler::num2(){
    return item2_num;
}

int MenuPageHandler::num3(){
    return item3_num;
}

int MenuPageHandler::num4(){
    return item4_num;
}

double MenuPageHandler::total(){
    return total_price;
}

int MenuPageHandler::weight(){
    return total_weight;
}

double MenuPageHandler::calculate_total_price(){
    return item1_price * item1_num +
           item2_price * item2_num +
           item3_price * item3_num +
           item4_price * item4_num;
}

int MenuPageHandler::calculate_total_weight(){
    return item1_weight * item1_num +
           item2_weight * item2_num +
           item3_weight * item3_num +
           item4_weight * item4_num;
}

