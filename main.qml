import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtPositioning 5.2
import QtLocation 5.3
import QtQml 2.2

import HKUST 1.0

ApplicationWindow {
    id: page
    title: qsTr("UAV Control App")
    width: 500
    height: 800
    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("A&bout")
                onTriggered: {
                    about_page.visible = true
                    address_page.visible = false
                    battery_status_page.visible = false
                    confirmation_page.visible = false
                    customer_track_page.visible = false
                    drone_location_page.visible = false
                    malfunctioning_page.visible = false
                    menu_page.visible = false
                    opening_page.visible = false
                    payment_page.visible = false
                    pending_order_page.visible = false
                    vendor_track_page.visible = false
                }
            }
            MenuItem {
                text: qsTr("Op&en")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("Exi&t")
                onTriggered: Qt.quit();
            }
        }
    }

    OpeningPage {
        id: opening_page
        visible: true
    }

    AboutPage {
        id: about_page
        visible: false
    }

    VendorHandler{
        id: vendor_handler
        name1: "Vinh N."
        name2: ""
        name3: ""
        street1: ""
        street2: ""
        street3: ""
        city1: ""
        city2: ""
        city3: ""
        state1: ""
        state2: ""
        state3: ""
        region1: "Hong Kong"
        region2: ""
        region3: ""

    }

    PendingOrderPage{
        id: pending_order_page
        visible: false
    }
      // Battery Status Window (vendor side)
    BatteryStatusPage{
        id: battery_status_page
        visible: false
        BatteryPageHandler {
            id: battery_page_handler
            percentage: 100
        }
    }

    VendorTrackPage {
        id: vendor_track_page
        visible: false
    }

    MalfunctioningPage {
        id: malfunctioning_page
        visible: false
    }

    DroneLocationPage {
        id: drone_location_page
        visible: false
    }

    MenuPage{
        id: menu_page
        visible: false
        //need a menu_page_handler
        MenuPageHandler{
            id: menu_page_handler
            num1: 0
            num2: 0
            num3: 0
            num4: 0
            total: 0
        }
    }

    AddressPage {
        id: address_page
        visible: false
        //need a address_page_handler
        AddressPageHandler{
            id: address_page_handler
            name:""
            street:""
            city:""
            state:""
            email:""
            zip:0
            phone:0
        }
    }

    PaymentPage {
        id: payment_page
        visible: false
    }

    ConfirmationPage{
        id: confirmation_page
        visible: false
    }

    CustomerTrackPage {
        id: customer_track_page
        visible: false
    }
}




