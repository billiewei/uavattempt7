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
        asynchronous : true
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
        Text {
            id: currentlatitude
            text: vendor_handler.latitude//"22.3362536"
            visible: false
        }
        Text {
            id: currentlongitude
            text: vendor_handler.longitude// "114.2629409"
            visible: false
        }
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
                latitude: 22.3362535
                longitude: 114.2629409
            }
            gesture.flickDeceleration: 3000
            gesture.enabled: true

            // HOME
            MapCircle {
                id: point
                radius: if (mapslider1.value < 13) {200}
                        else {30}
                color: "#46a2da"
                border.color: "#000000"
                border.width: 2
                opacity: 0.7
                center {
                    latitude: currentlatitude.text
                    longitude: currentlongitude.text
                }
            }
            MapCircle {
                radius:
                    if (map2.zoomLevel > 13) {5}
                    else if (map2.zoomLevel = 13) {20}
                    else if (map2.zoomLevel > 12 & map2.zoomLevel < 13) {100}
                    else if (map2.zoomLevel > 10 & map2.zoomLevel <= 12) {400}
                    else if (map2.zoomLevel > 8 & map2.zoomLevel <= 8) {1000}
                    else if (map2.zoomLevel <= 8) {10000}
                color: "#FFDF3D"
                opacity: 0.6
                border.width: 1
                border.color: "#000000"
                center {
                    latitude: manual_control_handler.latitude
                    longitude: manual_control_handler.longitude
                }
            }
            MapPolyline {
                line.width: 3
                line.color: 'green'
                path: [
                    { latitude: currentlatitude.text, longitude: currentlongitude.text },
                    { latitude: targetlatitude.text, longitude: targetlongitude.text }
                ]
            }
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
                MapCircle {
                    id: point2
                    radius: if (mapslider1.value < 13) {200}
                            else {30}
                    color: "#65E01F"
                    border.color: "#000000"
                    border.width: 2
                    opacity: 0.70
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
        value: 17
        maximumValue: 19
        minimumValue: 2
        tickmarksEnabled: false
        updateValueWhileDragging: true
        visible: true
        orientation: Qt.Vertical
    }
    Text {
        id: distance
        text: Math.floor(6371000*Math.acos(Math.sin(currentlatitude.text*0.0174532925) * Math.sin(targetlatitude.text*0.0174532925) + Math.cos(currentlatitude.text*0.0174532925) * Math.cos(targetlatitude.text*0.0174532925) * Math.cos (targetlongitude.text*0.0174532925 - currentlongitude.text*0.0174532925))) + " m"
        visible: false
        y: 400
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
        id: currentdistance
        y: currentdronecoordinates.y + currentdronecoordinates.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Current Distance:"
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: display_distance
        anchors.right: parent.right
        anchors.rightMargin: 50
        y: currentdronecoordinates.y + currentdronecoordinates.height + 20
        text: distance.text
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: deliverystatus
        y: currentdistance.y + currentdistance.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: qsTr("Current Status:")
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: display_deliverystatus
        anchors.right: parent.right
        anchors.rightMargin: 50
        y: currentdistance.y + currentdistance.height + 20
        text: if (delivered_validation.text != "Y" & delivered_validation.text != "N") {qsTr("Delivering")}
              else if (delivered_validation.text == "Y" & returned_validation.text != "Y") {qsTr ("Returning")}
              else if (returned_validation.text == "Y") {qsTr ("Returned")}
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: delivered
        y: deliverystatus.y + deliverystatus.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: qsTr("Delivered")
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    TextField {
        id: delivered_validation
        y: delivered.y
        x: delivered.x + delivered.width + 70
        height: delivered.height
        width: page.width * 0.4
        placeholderText: "Test Y or N"
    }
    Image {
        id: delivered_validationsign
        y: delivered.y - 5
        height: delivered.height + 10
        width: delivered.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 50
        source: if (delivered_validation.text == "Y") {"checkgreen.png"}
                else if (delivered_validation.text == "N" || delivered_validation.text == ""){"checkgrey.png"}
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
    TextField {
        id: returned_validation
        y: returned.y
        x: returned.x + returned.width + 70
        height: returned.height
        width: page.width * 0.4
        placeholderText: "Test Y or N"
    }
    Image {
        id: returned_validationsign
        y: returned.y - 5
        height: returned.height + 10
        width: returned.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 50
        source: if (returned_validation.text == "Y") {"checkgreen.png"}
                else if (returned_validation.text == "N" || returned_validation.text == ""){"checkgrey.png"}
    }
    Text {
        id: currentbattery
        anchors.left: parent.left
        anchors.leftMargin: 50
        y: returned.y + returned.height + 20
        text: "Current Battery:"
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
        color: if (battery_page_handler.percentage < 60) {"#D60000"}
               else if (battery_page_handler.percentage >=60 & battery_page_handler.percentage < 85) {"#FF790A"}
               else if (battery_page_handler.percentage >= 85) {"#65E01F"}
        width: (battery1.width - 10) * battery_page_handler.percentage / 100
        height: battery1.height - 10
        visible: true
    }
    Button {
        id: view_other_orders
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height * 0.10
        visible: true
        text: "View other orders"
        width: cancelreturn.width
        onClicked: {
            vendor_track_page.visible = false
            pending_order_page.visible = true
            if (display_deliverystatus.text == "Returned" | delivered_validation.text == "Y" | delivered_validation.text == "y"
                    | returned_validation.text == "Y" | returned_validation.text == "y") {
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
            delivered_validation.text = ""
            returned_validation.text = ""
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
            display_deliverystatus.text = "Returning"
            if (delivered_validation.text != "Y") {delivered_validation.text = "N"}
        }
    }
}

