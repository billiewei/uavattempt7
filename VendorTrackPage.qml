import QtQuick 2.0
import QtQuick.Controls 1.3
import QtPositioning 5.2
import QtLocation 5.3

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true
    Image {
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        width: 50
        height: 50
        source: "qrc:/logo.png"
        asynchronous : true
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 50
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
        y: 120
        width: page.width * 1.15
        height: page.width * 0.9
        z: 10

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
            text: "22.3362536"
            visible: false
        }

        Text {
            id: currentlongitude
            text: "114.2629409"
            visible: false
        }

        Map {
            id: tracking_drone_map
            plugin: osmplugin1
            width: tracking_drone.width
            height: tracking_drone.height
            zoomLevel: mapslider1.value
            center {
                latitude: 22.3362535
                longitude: 114.2629409
            }

            MapPolyline {
                line.width: 3
                line.color: 'green'
                path: [
                    { latitude: currentlatitude.text, longitude: currentlongitude.text },
                    { latitude: targetlatitude.text, longitude: targetlongitude.text }
                ]
            }

            MapItemView {
                model: geocodeModel1
                delegate: pointDelegate1
            }

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

            GeocodeModel {
                id: geocodeModel1
                plugin: osmplugin1
                autoUpdate: true
                query: fromAddress
                onLocationsChanged: {

                        tracking_drone_map.center.latitude = get(0).coordinate.latitude
                        tracking_drone_map.center.longitude = get(0).coordinate.longitude
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

            Address {
                id :fromAddress
                street: if (deliver.text == "1") {order1_street.text}
                        else if (deliver.text == "2") {order2_street.text}
                        else if (deliver.text == "3") {order3_street.text}
                city: if (deliver.text == "1") {order1_city.text}
                      else if (deliver.text == "2") {order2_city.text}
                      else if (deliver.text == "3") {order3_city.text}
                country: if (deliver.text == "1") {order1_country.text}
                         else if (deliver.text == "2") {order2_country.text}
                         else if (deliver.text == "3") {order3_country.text}
                state : if (deliver.text == "1") {order1_state.text}
                        else if (deliver.text == "2") {order2_state.text}
                        else if (deliver.text == "3") {order3_state.text}
                postalCode: if (deliver.text == "1") {order1_zip.text}
                            else if (deliver.text == "2") {order2_zip.text}
                            else if (deliver.text == "3") {order3_zip.text}
            }
        }

    }
    Slider {
        id: mapslider1
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.top: parent.top
        anchors.topMargin: tracking_drone.y
        height: tracking_drone_map.height
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
        id: currentdistance
        y: tracking_drone.y + tracking_drone.height + 25
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Current Distance:"
        font.family: "Avenir"
        horizontalAlignment: Text.AlignHCenter
        font.letterSpacing: 2
    }
    Text {
        id: display_distance
        anchors.right: parent.right
        anchors.rightMargin: 50
        y: tracking_drone.y + tracking_drone.height + 25
        text: distance.text
        font.family: "Avenir"
        horizontalAlignment: Text.AlignHCenter
        font.letterSpacing: 2
    }
    Text {
        id: deliverystatus
        y: currentdistance.y + currentdistance.height + 25
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: qsTr("Current Status:")
        font.family: "Avenir"
        horizontalAlignment: Text.AlignHCenter
        font.letterSpacing: 2
    }
    Text {
        id: display_deliverystatus
        anchors.right: parent.right
        anchors.rightMargin: 50
        y: currentdistance.y + currentdistance.height + 25
        text: if (delivered_validation.text != "Y" & delivered_validation.text != "N") {qsTr("Delivering")}
              else if (delivered_validation.text == "Y" & returned_validation.text != "Y") {qsTr ("Returning")}
              else if (returned_validation.text == "Y") {qsTr ("Returned")}
        font.family: "Avenir"
        horizontalAlignment: Text.AlignHCenter
        font.letterSpacing: 2
    }
    Text {
        id: delivered
        y: deliverystatus.y + deliverystatus.height + 35
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: qsTr("Delivered")
        font.family: "Avenir"
        horizontalAlignment: Text.AlignHCenter
        font.letterSpacing: 2
    }
    TextField {
        id: delivered_validation
        y: delivered.y
        x: delivered.x + delivered.width + 70
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
        y: delivered.y + delivered.height + 30
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: qsTr("Returned")
        font.family: "Avenir"
        horizontalAlignment: Text.AlignHCenter
        font.letterSpacing: 2
    }
    TextField {
        id: returned_validation
        y: returned.y
        x: returned.x + returned.width + 70
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
        y: returned.y + returned.height + 35
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
        height: 30
        color: "#00000000"
        border.width: 2
    }
    Rectangle {
        id: battery_red2
        x: battery1.x + 5
        y: battery1.y + 5
        color: "#D60000"
        width: (battery1.width - 10) * percentage.text / 100
        height: battery1.height - 10
        visible: if (percentage.text < 60) {true}
                 else {false}
    }
    Rectangle {
        id: battery_orange2
        x: battery1.x + 5
        y: battery1.y + 5
        color: "#FF790A"
        width: (battery1.width - 10) * percentage.text / 100
        height: battery1.height - 10
        visible: if (percentage.text >=60 & percentage.text < 85) {true}
                 else {false}
    }
    Rectangle {
        id: battery_green2
        x: battery1.x + 5
        y: battery1.y + 5
        color: "#65E01F"
        width: (battery1.width - 10) * percentage.text / 100
        height: battery1.height - 10
        visible: if (percentage.text >= 85) {true}
                 else {false}
    }
    Button {
        id: view_other_orders
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.width * 0.4
        visible: true
        text: "View other orders"
        width: cancelreturn.width
        onClicked: {
            page.state = "pendingorderswindowstate"
            delivered_validation.text = ""
            returned_validation.text = ""
            if(deliver.text == "1" & (display_deliverystatus.text == "Returned" | delivered_validation.text == "Y")) {
               order1_name.text = order2_name.text
               order1_city.text = order2_city.text
               order1_number.text = order2_number.text
               order1_state.text = order2_state.text
               order1_zip.text = order2_zip.text
               order1_street.text = order2_street.text
               order1_order.text = order2_order.text
               order1_totalprice.text = order2_totalprice.text
               order1_deliveryfee.text = order2_deliveryfee.text
               order1_grandtotal.text = order2_grandtotal.text
               order1_click.text = "0"
               order1_time.text = order2_time.text

               order2_name.text = order3_name.text
               order2_city.text = order3_city.text
               order2_number.text = order3_number.text
               order2_state.text = order3_state.text
               order2_zip.text = order3_zip.text
               order2_street.text = order3_street.text
               order2_order.text = order3_order.text
               order2_totalprice.text = order3_totalprice.text
               order2_deliveryfee.text = order3_deliveryfee.text
               order2_grandtotal.text = order3_grandtotal.text
               order2_click.text = "0"
               order2_time.text = ""
            }
            if(deliver.text == "2" & (display_deliverystatus.text == "Returned" | delivered_validation.text == "Y")) {


               order2_name.text = order3_name.text
               order2_city.text = order3_city.text
               order2_number.text = order3_number.text
               order2_state.text = order3_state.text
               order2_zip.text = order3.zip.text
               order2_street.text = order3_street.text
               order2_order.text = order3_order.text
               order2_totalprice.text = order3_totalprice.text
               order2_deliveryfee.text = order3_deliveryfee.text
               order2_grandtotal.text = order3_grandtotal.text
               order2_click.text = "0"
               order2_time.text = order3_time.text

               order3_name.text = orderb_name.text
               order3_city.text = orderb_city.text
               order3_number.text = orderb_number.text
               order3_state.text = ""
               order3_zip.text = ""
               order3_street.text = orderb_street.text
               order3_order.text = orderb_order.text
               order3_totalprice.text = orderb_totalprice.text
               order3_deliveryfee.text = orderb_deliveryfee.text
               order3_grandtotal.text = orderb_grandtotal.text
               order3_click.text = "0"
               order3_time.text = ""
            }
            if(deliver.text == "3" & (display_deliverystatus.text == "Returned" | delivered_validation.text == "Y")) {


               order3_name.text = orderb_name.text
               order3_city.text = orderb_city.text
               order3_number.text = orderb_number.text
               order3_state.text = ""
               order3_street.text = orderb_street.text
               order3_order.text = orderb_order.text
               order3_totalprice.text = orderb_totalprice.text
               order3_deliveryfee.text = orderb_deliveryfee.text
               order3_grandtotal.text = orderb_grandtotal.text
               order3_click.text = "0"
               order3_time.text = ""
            }
           pendingorders.visible = true

           //trackorders.visible = false
        }
    }
    Button {
        id: cancelreturn
        anchors.horizontalCenter: parent.horizontalCenter
        y: view_other_orders.y + view_other_orders.height + 40
        visible: if (returned_validation.text == "Y") {false} else {true}
        text: "Cancel Order and Return"
        onClicked: {
            display_deliverystatus.text = "Returning"
            if (delivered_validation.text != "Y") {delivered_validation.text = "N"}
        }
    }
}

