import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtPositioning 5.2
import QtLocation 5.3
import QtQml 2.2
import QtQuick.Particles 2.0
import QtQml 2.2
import HKUST 1.0

ApplicationWindow {
    id: page
    title: qsTr("Kee WahWah Bakery")
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

    AboutPage {
        id: about_page
        visible: false
    }

    AddressPage {
        id: address_page
        visible: false
        //need a address_page_handler
        AddressPageHandler{
            id: address_page_handler
        }
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

    ConfirmationPage{
        id: confirmation_page
        visible: false
    }

    CustomerTrackPage {
        id: customer_track_page
        visible: false
    }

    DroneApproaching {
        id: drone_approaching_page
        visible: false
    }

    DroneLocationPage {
        id: drone_location_page
        visible: false
    }

    MalfunctioningCustNotification {
        id: malfunctioning_customer_notification
        visible: false
    }

    MalfunctioningPage {
        id: malfunctioning_page
        visible: false
    }

    ManualControlPage {
        id: manual_control_page
        visible: false
        ManualControlHandler{
            id: manual_control_handler
            log: "hello world"
            /**
            qrc:/main.qml:116: TypeError: Property 'append' of object QQuickRectangle(0x7fabadb5b170) is not a function
            [sdlog2] log dir: /fs/microsd/log/sess192
            qrc:/main.qml:116: TypeError: Property 'append' of object QQuickRectangle(0x7fabadb5b170) is not a function
            [sdlog2] starting: log001.px4log
            the signal is Received
            the function append is wrongly used
            qrc:/main.qml:124: TypeError: Cannot call method 'append' of undefined
            */       
            onLogChanged: manual_control_page.writeFlightLog(log)
            //onLogChanged: manual_control_page
        }
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

    OpeningPage {
        id: opening_page
        visible: true
    }

    PaymentPage {
        id: payment_page
        visible: false
    }

    PendingOrderPage{
        id: pending_order_page
        visible: false
    }

    ReceivedOrderCheck {
        id: received_order_check_page
        visible: false
    }

    VendorHandler{
        id: vendor_handler
    }

    VendorTrackPage {
        id: vendor_track_page
        visible: false
    }

}




