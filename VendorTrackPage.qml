import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtPositioning 5.2
import QtLocation 5.3

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true
    Image {
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.05
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.width*0.05
        width: page.width*.10
        height: page.width*.10
        source: "qrc:/logo.png"
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: page.height * 0.03
        anchors.top: parent.top
        text: "TRACK ORDER"
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Plugin {
        id: osmplugin1
        name:"osm"
    }
    Item {
        id: tracking_drone
        anchors.horizontalCenter: parent.horizontalCenter
        y: page.height * 0.08
        width: page.width * 0.8
        height: page.width * 0.6

        Text {
            id: targetlatitude
            visible: false
        }
        Text {
            id: targetlongitude
            visible: false
        }
        // Customer Address
        Address {
            id: fromAddress
            street: if (vendor_handler.delivery == 1) {vendor_handler.street1}
                    else if (vendor_handler.delivery == 2) {vendor_handler.street2}
                    else if (vendor_handler.delivery == 3) {vendor_handler.street3}
            city: if (vendor_handler.delivery == 1) {vendor_handler.city1}
                  else if (vendor_handler.delivery == 2) {vendor_handler.city2}
                  else if (vendor_handler.delivery == 3) {vendor_handler.city3}
            country: if (vendor_handler.delivery == 1) {vendor_handler.region1}
                     else if (vendor_handler.delivery == 2) {vendor_handler.region2}
                     else if (vendor_handler.delivery == 3) {vendor_handler.region3}
            state : if (vendor_handler.delivery == 1) {vendor_handler.state1}
                    else if (vendor_handler.delivery == 2) {vendor_handler.state2}
                    else if (vendor_handler.delivery == 3) {vendor_handler.state3}
            postalCode: if (vendor_handler.delivery == 1) {vendor_handler.zip1}
                        else if (vendor_handler.delivery == 2) {vendor_handler.zip2}
                        else if (vendor_handler.delivery == 3) {vendor_handler.zip3}
        }
        Map {
            id: map2
            plugin: osmplugin1
            width: tracking_drone.width
            height: tracking_drone.height
            zoomLevel: mapslider1.value
            center {
                latitude: vendor_handler.latitude
                longitude: vendor_handler.longitude
            }
            gesture.flickDeceleration: 3000
            gesture.enabled: true

            // ORIGIN POINT
            MapCircle {
                id: point
                radius: if (mapslider1.value < 13) {200}
                        else {30}
                color: "#3938FF" // Origin Point will be in blue
                border.color: "#000000"
                border.width: 2
                opacity: 0.6
                center {
                    latitude: vendor_handler.latitude
                    longitude: vendor_handler.longitude
                }
            }
            // DRONE POINT
            MapCircle {
                radius:
                    if (mapslider1.value > 13) {5}
                    else if (mapslider1.value = 13) {20}
                    else if (mapslider1.value > 12 & mapslider1.value < 13) {200}
                    else {1000}
                color: "#FF0F47" // Shows drone point in red
                opacity: 0.6
                border.width: 2
                border.color: "#000000"
                center {
                    latitude: manual_control_handler.latitude
                    longitude: manual_control_handler.longitude
                }
            }
            // IDEAL FLIGHT PATH
            MapPolyline {
                id: polyline2
                line.width: 3
                line.color: "#000000"
                path: [
                    { latitude: vendor_handler.latitude, longitude: vendor_handler.longitude },
                    { latitude: targetlatitude.text, longitude: targetlongitude.text }
                ]
            }
            // ACUTAL FLIGHT PATH
            MapPolyline {
               id: actual_flight_path
               line.width: 3
               line.color: 'red'
               path: [
                   { latitude: -27, longitude: 153.0 },
                   { latitude: -27, longitude: 154.1 },
                   { latitude: -28, longitude: 153.5 },
                   { latitude: -29, longitude: 153.5 }
               ]
               }
            // Gets coordinates from the customer address
            GeocodeModel {
                id: geocodeModel1
                plugin: osmplugin1
                autoUpdate: true
                query: fromAddress
                onLocationsChanged: {
                    map2.center.latitude = get(0).coordinate.latitude
                    map2.center.longitude = get(0).coordinate.longitude
                    targetlatitude.text = get(0).coordinate.latitude
                    targetlongitude.text = get(0).coordinate.longitude
                }
            }
            Component {
                id: pointDelegate1
                // DESTINATION POINT
                MapCircle {
                    id: point2
                    radius: if (mapslider1.value < 13) {200}
                            else {30}
                    color: "#C638FF"
                    border.color: "#000000"
                    border.width: 2
                    opacity: 0.6
                    center {
                        latitude: targetlatitude.text
                        longitude: targetlongitude.text
                    }
                }
            }
            MapItemView {
                model: geocodeModel1
                delegate: pointDelegate1
            }
        }

    }
    Slider {
        id: mapslider1
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.top: parent.top
        anchors.topMargin: tracking_drone.y
        height: map2.height
        value: 15
        maximumValue: 19
        minimumValue: 2
        tickmarksEnabled: false
        updateValueWhileDragging: true
        visible: true
        orientation: Qt.Vertical

    }
    Text {
        id: currentdronecoordinates
        y: tracking_drone.y + tracking_drone.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Current Drone Latitude: " + '<br>' + "Current Drone Longitude: "
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        y: tracking_drone.y + tracking_drone.height + 20
        anchors.right: parent.right
        anchors.rightMargin: 50
        text: manual_control_handler.latitude.toFixed(8) + '<br>' + manual_control_handler.longitude.toFixed(8)
        font.family: "Avenir"
        font.letterSpacing: 2
        z: currentdronecoordinates.z + 3
    }
    Text {
        id: currentdistance_label
        y: currentdronecoordinates.y + currentdronecoordinates.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Current Distance:"
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: currentdistance
        anchors.right: parent.right
        anchors.rightMargin: 50
        y: currentdronecoordinates.y + currentdronecoordinates.height + 20
        text: Math.floor(6371000*Math.acos(Math.sin(vendor_handler.latitude*0.0174532925) * Math.sin(targetlatitude.text*0.0174532925) + Math.cos(vendor_handler.latitude*0.0174532925) * Math.cos(targetlatitude.text*0.0174532925) * Math.cos (targetlongitude.text*0.0174532925 - vendor_handler.longitude*0.0174532925))) + " m"
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: deliverystatus
        y: currentdistance.y + currentdistance.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Current Status:"
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: display_deliverystatus
        anchors.right: parent.right
        anchors.rightMargin: 50
        y: currentdistance.y + currentdistance.height + 20
        text:
            if (delivered_validationsign.source == "checkgrey.png" & returned_validationsign.source == "checkgrey.png") {"Delivering"}
            else if (delivered_validationsign.source == "checkgreen.png" & returned_validationsign.source == "checkgrey.png") {"Returning"}
            else if (returned_validationsign.source == "checkgreen.png") {"Returned"}
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: delivered
        y: deliverystatus.y + deliverystatus.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Delivered"
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Image {
        id: delivered_validationsign
        y: delivered.y - 5
        height: delivered.height + 10
        width: delivered.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 50
        source:
            if (Math.abs(targetlatitude.text - manual_control_handler.latitude) < 0.0002 & Math.abs(targetlongitude.text - manual_control_handler.longitude) < 0.0002) {"checkgreen.png"}
        else {"checkgrey.png"}

    }
    Text {
        id: returned
        y: delivered.y + delivered.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: qsTr("Returned")
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Image {
        id: returned_validationsign
        y: returned.y - 5
        height: returned.height + 10
        width: returned.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 50
        source:
            if (Math.abs(vendor_handler.latitude - manual_control_handler.latitude) < 0.0002 & Math.abs(vendor_handler.longitude - manual_control_handler.longitude) < 0.0002) {"checkgreen.png"}
        else {"checkgrey.png"}

    }
    Text {
        id: currentbattery
        anchors.left: parent.left
        anchors.leftMargin: 50
        y: returned.y + returned.height + 20
        text: if (((manual_control_handler.voltage - 13500) / 31).toFixed(1) > 0) {
                  "Current Battery: "+ ((manual_control_handler.voltage - 13500) / 31).toFixed(1) + "%"}
              else {"Current Battery: 0%"}
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Rectangle {
        id: battery1
        anchors.right: parent.right
        anchors.rightMargin: 50
        y: currentbattery.y
        width: 75
        height: currentbattery.height
        color: "#00000000"
        border.width: 2
    }
    Rectangle {
        id: batteryfill
        x: battery1.x + 5
        y: battery1.y + 5
        width: if (((manual_control_handler.voltage - 13500) / 31) > 0.0) {
                    (battery1.width - 10.0)*(((manual_control_handler.voltage - 13500) / 3100))}
               else {0}
        color: if (((manual_control_handler.voltage - 13500) / 31) >= 85.00) {"#65E01F"}
               else if (((manual_control_handler.voltage - 13500) / 31) >= 60.00) {"#FF790A"}
               else if (((manual_control_handler.voltage - 13500) / 31) < 60.00) {"#D60000"}
        height: battery1.height - 10
        visible: true
    }
    Button {
        id: return_to_manual
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height * 0.14
        visible: true
        text: "Manual control"
        width: cancelreturn.width
        onClicked: {
            vendor_track_page.visible = false
            manual_control_page.visible = true
        }
    }
    Button {
        id: view_other_orders
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height * 0.09
        visible: true
        text: "View other orders"
        width: cancelreturn.width
        onClicked: {
            vendor_track_page.visible = false
            pending_order_page.visible = true
            if (delivered_validationsign.source == "checkgreen.png" | returned_validationsign.source == "checkgreen.png") {
                if (vendor_handler.delivery == 1) {
                    vendor_handler.reset1()
                    vendor_handler.delivery = 0
                    if (vendor_handler.valid2) {
                        vendor_handler.pass2to1()
                        vendor_handler.reset2()
                    }
                    if (vendor_handler.valid3) {
                        vendor_handler.pass3to2()
                        vendor_handler.reset3()
                    }

                }
                else if (vendor_handler.delivery == 2) {
                    vendor_handler.reset2()
                    vendor_handler.delivery = 0
                    if (vendor_handler.valid3) {
                        vendor_handler.pass3to2()
                        vendor_handler.reset3()}
                }
                else if (vendor_handler.delivery == 3) {
                    vendor_handler.reset3()
                    vendor_handler.delivery = 0
                }
            }
        }
    }
    Button {
        id: cancelreturn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height * 0.04
        visible: if (returned_validation.text == "Y") {false} else {true}
        text: "Cancel Order and Return"
        onClicked: {
            // ********* Puts drone into return mode ******** //
            manual_control_handler.setFlightMode(0)
            display_deliverystatus.text = "Returning"
            delivered_validationsign.source == "checkgrey.png"
        }
    }
}

