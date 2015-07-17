#include "vendorpagehandler.h"

VendorPageHandler::VendorPageHandler(QQuickItem *parent): QQuickItem(parent)
{

}

bool VendorPageHandler::order1(){
    return m_order1;
}

bool VendorPageHandler::order2(){
    return m_order2;
}

bool VendorPageHandler::order3(){
    return m_order3;
}

void VendorPageHandler::setOrder1(bool o){
    if(m_order1 != o){
        m_order1 = o;
        emit order1Changed();
    }
}

void VendorPageHandler::setOrder2(bool o){
    if(m_order2 != o){
        m_order2 = o;
        emit order2Changed();
    }
}

void VendorPageHandler::setOrder3(bool o){
    if
}
