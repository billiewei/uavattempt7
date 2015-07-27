#include "addresspagehandler.h"

AddressPageHandler::AddressPageHandler(QQuickItem* parent):
    QQuickItem(parent), m_name(""), m_street(""),
    m_city(""), m_state(""), m_region(""), m_email(""),
    m_zip(0), m_phone(0)
{

}

QString AddressPageHandler::name() {
    return m_name;
}

QString AddressPageHandler::street() {
    return m_street;
}

QString AddressPageHandler::city() {
    return m_city;
}

QString AddressPageHandler::state() {
    return m_state;
}

QString AddressPageHandler::region() {
    return m_region;
}

QString AddressPageHandler::email() {
    return m_email;
}

int AddressPageHandler::zip() {
    return m_zip;
}

int AddressPageHandler::phone() {
    return m_phone;
}

void AddressPageHandler::setName(QString n) {
    if( m_name.compare(n)){
        m_name = n;
        emit nameChanged();
    }
}

void AddressPageHandler::setStreet(QString s) {
    if( m_street.compare(s)){
        m_street = s;
        emit streetChanged();
    }
}

void AddressPageHandler::setCity(QString c) {
    if(m_city.compare(c)){
        m_city = c;
        emit cityChanged();
    }
}

void AddressPageHandler::setState(QString s) {
    if(m_state.compare(s)){
        m_state = s;
        emit stateChanged();
    }
}

void AddressPageHandler::setRegion(QString r) {
    if( m_region.compare(r) ){
        m_region = r;
        emit regionChanged();
    }
}

void AddressPageHandler::setEmail(QString e) {
    if( m_email.compare(e)){
        m_email = e;
        emit emailChanged();
    }
}

void AddressPageHandler::setZip(int z) {
    if(m_zip != z){
        m_zip = z;
        emit zipChanged();
    }
}

void AddressPageHandler::setPhone(int p) {
    if( m_phone != p){
        m_phone = p;
        emit phoneChanged();
    }
}

