#include "addresspagehandler.h"

AddressPageHandler::AddressPageHandler(QQuickItem* parent):
    QQuickItem(parent)
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
    m_name = n;
    qDebug() << "address name is changed";
    emit nameChanged();
}

void AddressPageHandler::setStreet(QString s) {
    m_street = s;
    emit streetChanged();
}

void AddressPageHandler::setCity(QString c) {
    m_city = c;
    emit cityChanged();
}

void AddressPageHandler::setState(QString s) {
    m_state = s;
    emit stateChanged();
}

void AddressPageHandler::setRegion(QString r) {
    m_region = r;
    emit regionChanged();
}

void AddressPageHandler::setEmail(QString e) {
    m_email = e;
    emit emailChanged();
}

void AddressPageHandler::setZip(int z) {
    m_zip = z;
    emit zipChanged();
}

void AddressPageHandler::setPhone(int p) {
    m_phone = p;
    emit phoneChanged();
}

