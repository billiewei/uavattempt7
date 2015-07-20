#include "vendorhandler.h"

VendorHandler::VendorHandler(QQuickItem *parent): QQuickItem(parent),
    vendor_delivery(0),
  vendor_latitude(22.3362536), vendor_longitude(114.2629409)
{   order_valid[0] = true;
    order_valid[1] = false;
    order_valid[2] = false;
    order_name[0] = "Vinh N.";
    order_name[1] = "";
    order_name[2] = "";
    order_street[0] = "Hong Fung House";
    order_street[1] = "";
    order_street[2] = "";
    order_city[0] = "";
    order_city[1] = "";
    order_city[2] = "";
    order_state[0] = "";
    order_state[1] = "";
    order_state[2] = "";
    order_region[0] = "Hong Kong";
    order_region[1] = "";
    order_region[2] = "";
    order_time[0] = "08:23";
    order_time[1] = "";
    order_time[2] = "";
    order_zip[0] = 0;
    order_zip[1] = 0;
    order_zip[2] = 0;
    order_price[0] = 50;
    order_price[1] = 0;
    order_price[2] = 0;

}

void VendorHandler::pass2to1(){
    setValid1(true);
    setName1(name2());
    setStreet1(street2());
    setCity1(city2());
    setState1(state2());
    setRegion1(region2());
    setTime1(time2());
    setZip1(zip2());
    setPrice1(price2());
}

void VendorHandler::pass3to2(){
    setValid2(true);
    setName2(name3());
    setStreet2(street3());
    setCity2(city3());
    setState2(state3());
    setRegion2(region3());
    setTime2(time3());
    setZip2(zip3());
    setPrice2(price3());
}

void VendorHandler::reset1(){
    setValid1(false);
    setName1("");
    setStreet1("");
    setCity1("");
    setState1("");
    setRegion1("");
    setTime1("");
    setZip1(0);
    setPrice1(0);
}

void VendorHandler::reset2(){
    setValid2(false);
    setName2("");
    setStreet2("");
    setCity2("");
    setState2("");
    setRegion2("");
    setTime2("");
    setZip2(0);
    setPrice2(0);
}

void VendorHandler::reset3(){
    setValid3(false);
    setName3("");
    setStreet3("");
    setCity3("");
    setState3("");
    setRegion3("");
    setTime3("");
    setZip3(0);
    setPrice3(0);
}

int VendorHandler::delivery(){
    return vendor_delivery;
}

bool VendorHandler::valid1(){
    return order_valid[0];
}

bool VendorHandler::valid2(){
    return order_valid[1];
}

bool VendorHandler::valid3(){
    return order_valid[2];
}

double VendorHandler::latitude(){
    return vendor_latitude;
}

double VendorHandler::longitude(){
    return vendor_longitude;
}

QString VendorHandler::name1(){
    return order_name[0];
}

QString VendorHandler::name2(){
    return order_name[1];
}

QString VendorHandler::name3(){
    return order_name[2];
}

QString VendorHandler::street1(){
    return order_street[0];
}

QString VendorHandler::street2(){
    return order_street[1];
}

QString VendorHandler::street3(){
    return order_street[2];
}

QString VendorHandler::city1(){
    return order_city[0];
}

QString VendorHandler::city2(){
    return order_city[1];
}

QString VendorHandler::city3(){
    return order_city[2];
}

QString VendorHandler::state1(){
    return order_state[0];
}

QString VendorHandler::state2(){
    return order_state[1];
}

QString VendorHandler::state3(){
    return order_state[2];
}

QString VendorHandler::region1(){
    return order_region[0];
}

QString VendorHandler::region2(){
    return order_region[1];
}

QString VendorHandler::region3(){
    return order_region[2];
}

QString VendorHandler::time1(){
    return order_time[0];
}

QString VendorHandler::time2(){
    return order_time[1];
}

QString VendorHandler::time3(){
    return order_time[2];
}

int VendorHandler::zip1(){
    return order_zip[0];
}

int VendorHandler::zip2(){
    return order_zip[1];
}

int VendorHandler::zip3(){
    return order_zip[2];
}

double VendorHandler::price1(){
    return order_price[0];
}

double VendorHandler::price2(){
    return order_price[1];
}

double VendorHandler::price3(){
    return order_price[2];
}

void VendorHandler::setDelivery(int d){
    if(vendor_delivery != d){
        vendor_delivery = d;
        emit deliveryChanged();
    }
}

void VendorHandler::setValid1(bool v){
    if(order_valid[0] != v){
        order_valid[0] = v;
        emit valid1Changed();
    }
}

void VendorHandler::setValid2(bool v){
    if(order_valid[1] != v){
        order_valid[1] = v;
        emit valid2Changed();
    }
}

void VendorHandler::setValid3(bool v
                              ){
    if(order_valid[2] != v){
        order_valid[2] = v;
        emit valid3Changed();
    }
}

void VendorHandler::setLatitude(double l){
    if(abs(vendor_latitude - l) > 0.1){
        vendor_latitude = l;
        emit latitudeChanged();
    }
}

void VendorHandler::setLongitude(double l){
    if(abs(vendor_longitude - l) > 0.1){
        vendor_longitude = l;
        emit longitudeChanged();
    }
}

void VendorHandler::setName1(QString n){
    if(order_name[0].compare(n)){
        order_name[0] = n;
        emit name1Changed();
    }
}

void VendorHandler::setName2(QString n){
    if(order_name[1].compare(n)){
        order_name[1] = n;
        emit name2Changed();
    }
}

void VendorHandler::setName3(QString n){
    if(order_name[2].compare(n)){
        order_name[2] = n;
        emit name3Changed();
    }
}

void VendorHandler::setStreet1(QString s){
    if(order_street[0].compare(s)){
        order_street[0] = s;
        emit street1Changed();
    }
}

void VendorHandler::setStreet2(QString s){
    if(order_street[1].compare(s)){
        order_street[1] = s;
        emit street2Changed();
    }
}

void VendorHandler::setStreet3(QString s){
    if(order_street[2].compare(s)){
        order_street[2] = s;
        emit street3Changed();
    }
}

void VendorHandler::setCity1(QString c){
    if(order_city[0].compare(c)){
        order_city[0] = c;
        emit city1Changed();
    }
}

void VendorHandler::setCity2(QString c){
    if(order_city[1].compare(c)){
        order_city[1] = c;
        emit city2Changed();
    }
}

void VendorHandler::setCity3(QString c){
    if(order_city[2].compare(c)){
        order_city[2] = c;
        emit city3Changed();
    }
}

void VendorHandler::setState1(QString s){
    if(order_state[0].compare(s)){
        order_state[0] = s;
        emit state1Changed();
    }
}

void VendorHandler::setState2(QString s){
    if(order_state[1].compare(s)){
        order_state[1] = s;
        emit state2Changed();
    }
}

void VendorHandler::setState3(QString s){
    if(order_state[2].compare(s)){
        order_state[2] = s;
        emit state3Changed();
    }
}

void VendorHandler::setRegion1(QString r){
    if(order_region[0].compare(r)){
        order_region[0] = r;
        emit region1Changed();
    }
}

void VendorHandler::setRegion2(QString r){
    if(order_region[1].compare(r)){
        order_region[1] = r;
        emit region2Changed();
    }
}

void VendorHandler::setRegion3(QString r){
    if(order_region[2].compare(r)){
        order_region[2] = r;
        emit region3Changed();
    }
}

void VendorHandler::setTime1(QString t){
    if(order_time[0].compare(t)){
        order_time[0] = t;
        emit time1Changed();
    }
}

void VendorHandler::setTime2(QString t){
    if(order_time[1].compare(t)){
        order_time[1] = t;
        emit time2Changed();
    }
}

void VendorHandler::setTime3(QString t){
    if(order_time[2].compare(t)){
        order_time[2] = t;
        emit time3Changed();
    }
}

void VendorHandler::setZip1(int z){
    if(order_zip[0] != z){
        order_zip[0] = z;
        emit zip1Changed();
    }
}

void VendorHandler::setZip2(int z){
    if(order_zip[0] != z){
        order_zip[0] = z;
        emit zip1Changed();
    }
}

void VendorHandler::setZip3(int z){
    if(order_zip[1] != z){
        order_zip[1] = z;
        emit zip2Changed();
    }
}

void VendorHandler::setPrice1(double p){
    if(abs(order_price[0]-p)){
        order_price[0] = p;
        emit price1Changed();
    }
}

void VendorHandler::setPrice2(double p){
    if(abs(order_price[1]-p)){
        order_price[1] = p;
        emit price2Changed();
    }
}

void VendorHandler::setPrice3(double p){
    if(abs(order_price[2]-p)){
        order_price[2] = p;
        emit price3Changed();
    }
}

