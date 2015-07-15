import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtPositioning 5.2
import QtLocation 5.3
import QtQml 2.2

Item {
    id: page
    width: parent ? parent.width : 500
    height: parent ? parent.height : 800

    /********************************************************/
    // Login Window
    Window {
        id: openingwindow
        width: page.width
        height: page.height
        visible: true
        Image {
            id: logo
            visible: true
            anchors.horizontalCenter: parent.horizontalCenter
            y: 200
            width: 150
            height: 150
            source: "qrc:/logo.png"
            asynchronous : true
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            y: logo.y + logo.height + 100
            width: 150
            id: vendorButton
            text: "Vendor Login"
            onClicked: {
                page.state = "pendingorderswindowstate"
            }
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            y: vendorButton.y + vendorButton.height + 30
            width: 150
            id: userloginButton
            text: "Place an Order"
            onClicked: {
               page.state = "availableitemsstate"
            }
        }
    }

    /********************************************************/
    // Pending Orders Window (vendor side)
    Window {
        id: pendingorderswindow
        width: page.width
        height: page.height
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
            anchors.top: parent.top
            anchors.topMargin: 50
            text: "PENDING ORDERS"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: order1_click
            text: "0"
            visible: false
        }
        Text {
            id: order1_name
            text: "Vinh"
            visible: false
        }
        Text {
            id: order1_street
            text: "Hong Fung House"
            visible: false
        }
        Text {
            id: order1_city
            text: "Hong Kong"
            visible: false
        }
        Text {
            id: order1_state
            text: ""
            visible: false
        }
        Text {
            id: order1_zip
            text: ""
            visible:false
        }
        Text {
            id: order1_totalprice
            text: "50"
            visible: false
        }
        Text {
            id: order1_deliveryfee
            text: "$ 4.00"
            visible: false
        }
        Text {
            id: order1_grandtotal
            text: (order1_totalprice.text *1.08) + 4
            visible: false
        }
        Text {
            id: order1_order
            text: "1 Fried Chicken\n5 Fish & Chips"
            visible: false
        }
        Text {
            id: order1_number
            text: "2"
            visible: false
        }
        Text {
            id: order1_country
            text: "Hong Kong"
            visible: false
        }
        Text {
            id: order1_time
            y: order1.y
            text: ""
            visible: order1.visible
            anchors.right: parent.right
            anchors.rightMargin: 70
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: order1
            y: 150
            text: if (order1_click.text == "0") {order1_name.text + " \n\nItems: " + order1_number.text}
                  else if (order1_click.text == "1") {
                      order1_name.text + "\n\n" +
                      order1_order.text +
                      "\n\nTotal Price: $" + order1_totalprice.text +
                      "\nDelivery Fee: " + order1_deliveryfee.text +
                      "\nGrand Total: $" + order1_grandtotal.text +
                      "\n\nPaid" +
                      "\n\nAddress: " + "\n" + order1_street.text +
                      "\n" + order1_city.text + ", " + order1_state.text + " " + order1_zip.text +
                      "\n" + order1_country.text
                  }
            visible: if (order1_name.text == "") {false}
                     else {true}
            anchors.right: parent.right
            anchors.rightMargin: 35
            anchors.left: parent.left
            anchors.leftMargin: 35
            font.pixelSize: 12
            font.family: "Avenir"
            font.letterSpacing: 2

            MouseArea{
                id: order1_area
                anchors.fill: parent
                onClicked: if (order1_click.text == "0") {
                               order1_click.text = "1"
                               order2_click.text = "0"
                               order3_click.text = "0"
                           }
                           else if (order1_click.text == "1") {
                               order1_click.text = "0"
                               order3_click.text = "0"
                               order2_click.text = "0"
                           }
            }

            Button {
                id: deliverorder1_button
                y: if (order1_click.text == "1") {order1.y + order1.height - deliverorder1_button.height - 100}
                   else if (order2_click.text == "1") {order2.y + order2.height - deliverorder1_button.height - 100}
                   else if (order3_click.text == "1") {order3.y + order3.height - deliverorder1_button.height - 100}
                visible: if (order1_click.text == "0" & order2_click.text == "0" & order3_click.text == "0") {false}
                         else if (order1_click.text == "1" | order2_click.text == "1" | order3_click.text == "1") {true}
                text: "Deliver Order"
                onClicked: {
                     if (order1_click.text == "1") {
                         console.debug("Deliver Order 1")
                         deliver.text = "1"
                         page.state = "batterystatuswindowstate"
                     }
                     else if (order2_click.text == "1") {
                         console.debug("Deliver Order 2")
                         deliver.text = "2"
                         page.state = "batterystatuswindowstate"

                     }
                     else if (order3_click.text == "1"){
                         console.debug("Deliver Order 3")
                         deliver.text = "3"
                         page.state = "batterystatuswindowstate"
                     }

                     else {console.debug("Please select order.")}
                }
            }
        }
        Rectangle {
            id: order1_beforeline
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            y: order1.y - 20
            height: 1
            color: "#6E6E6E"
            border.width: 1
            border.color: "#6E6E6E"
        }
        Rectangle {
            id: order1_line
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            y: if (order1_click.text == "0" ) {order1.y + order1.height + 20}
               else if (order1_click.text == "1") {deliverorder1_button.y + deliverorder1_button.height + 170}
            height: 1
            color: "#6E6E6E"
            border.color: "#6E6E6E"
            border.width: 1
            visible: if (order1_name.text == "") {false}
                     else {true}
        }
        Text {
            id: deliver
            visible: false
        }

        Text {
            id: order2_click
            text: "0"
            visible: false
        }
        Text {
            id: order2_name
            text: ""
            visible: false
        }
        Text {
            id: order2_street
            text: ""
            visible: false
        }
        Text {
            id: order2_city
            text: ""
            visible: false
        }
        Text {
            id: order2_state
            text: ""
            visible: false
        }
        Text {
            id: order2_zip
            text: ""
            visible:false
        }
        Text {
            id: order2_totalprice
            text: "100"
            visible: false
        }
        Text {
            id: order2_deliveryfee
            text: "$ 4.00"
            visible: false
        }
        Text {
            id: order2_grandtotal
            text: (order2_totalprice.text*1.08) + 4
            visible: false
        }
        Text {
            id: order2_order
            text: "60 Egg Tarts"
            visible: false
        }
        Text {
            id: order2_number
            text: "1"
            visible: false
        }
        Text {
            id: order2_country
            text: ""
            visible: false
        }
        Text {
            id: order2_time
            y: order2.y
            text: ""
            visible: order2.visible
            anchors.right: parent.right
            anchors.rightMargin: 70
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: order2
            y: order1_line.y + 25
            text: if (order2_click.text == "0") {order2_name.text + " \n\nItems: " + order2_number.text}
                  else if (order2_click.text == "1"){
                  order2_name.text + "\n\n" +
                  order2_order.text +
                  "\n\nTotal Price: $" + order2_totalprice.text +
                  "\nDelivery Fee: " + order2_deliveryfee.text +
                  "\nGrand Total: $" + order2_grandtotal.text +
                  "\n\nPaid" +
                  "\n\nAddress: " + "\n" + order2_street.text +
                  "\n" + order2_city.text + ", " + order2_state.text + " " + order2_zip.text +
                  "\n" + order2_country.text
                  }
            visible: if (order2_name.text == ""){false}
                     else {true}
            anchors.right: parent.right
            anchors.rightMargin: 35
            anchors.left: parent.left
            anchors.leftMargin: 35
            font.pixelSize: 12
            font.family: "Avenir"
            font.letterSpacing: 2
            MouseArea{
                id: order2_area
                anchors.fill: parent
                onClicked: if (order2_click.text == "0") {
                               order2_click.text = "1"
                               order3_click.text = "0"
                               order1_click.text = "0"
                           }
                           else if (order2_click.text == "1") {
                               order3_click.text = "0"
                               order2_click.text = "0"
                               order1_click.text = "0"
                           }
            }
        }
        Rectangle {
            id: order2_line
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            y: if (order2_click.text == "0" ) {order2.y + order2.height + 20}
               else if (order2_click.text == "1") {deliverorder1_button.y + deliverorder1_button.height + 170}
            height: 1
            color: "#6E6E6E"
            border.width: 1
            border.color: "#6E6E6E"
            visible: if (order2_name.text == "") {false}
                     else {true}
        }

        Text {
            id: order3_click
            text: "0"
            visible: false
        }
        Text {
            id: order3_name
            text: ""
            visible: false
        }
        Text {
            id: order3_street
            text: ""
            visible: false
        }
        Text {
            id: order3_city
            text: ""
            visible: false
        }
        Text {
            id: order3_state
            text: ""
            visible: false
        }
        Text {
            id: order3_zip
            text: ""
            visible: false
        }
        Text {
            id: order3_totalprice
            text: ""
            visible: false
        }
        Text {
            id: order3_deliveryfee
            text: ""
            visible: false
        }
        Text {
            id: order3_grandtotal
            text: ""
            visible: false
        }
        Text {
            id: order3_order
            text: ""
            visible: false
        }
        Text {
            id: order3_number
            text: ""
            visible: false
        }
        Text {
            id: order3_country
            text: ""
            visible: false
        }
        Text {
            id: order3_time
            y: order3.y
            text: ""
            visible: order3.visible
            anchors.right: parent.right
            anchors.rightMargin: 70
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: order3
            y: order2_line.y + 25
            text: if (order3_click.text == "0") {order3_name.text + " \n\nItems: " + order3_number.text}
                  else if (order3_click.text == "1"){
                  order3_name.text + "\n\n" +
                  order3_order.text +
                  "\n\nTotal Price: $" + order3_totalprice.text +
                  "\nDelivery Fee: " + order3_deliveryfee.text +
                  "\nGrand Total: $" + order3_grandtotal.text +
                  "\n\nPaid" +
                  "\n\nAddress: " + "\n" + order3_street.text +
                  "\n" + order3_city.text + ", " + order3_state.text + " " + order3_zip.text +
                  "\n" + order3_country.text
                  }
            visible: if (order3_name.text == ""){false}
                     else {true}
            anchors.right: parent.right
            anchors.rightMargin: 35
            anchors.left: parent.left
            anchors.leftMargin: 35
            font.pixelSize: 12
            font.family: "Avenir"
            font.letterSpacing: 2

            MouseArea{
                id: order3_area
                anchors.fill: parent
                onClicked: if (order3_click.text == "0") {
                               order3_click.text = "1"
                               order2_click.text = "0"
                               order1_click.text = "0"
                           }
                           else if (order3_click.text == "1") {
                               order3_click.text = "0"
                               order2_click.text = "0"
                               order1_click.text = "0"
                           }
            }
        }
        Rectangle {
            id: order3_line
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            y: if (order3_click.text == "0" ) {order3.y + order3.height + 20}
               else if (order3_click.text == "1") {deliverorder1_button.y + deliverorder1_button.height + 170}
            height: 1
            color: "#6E6E6E"
            border.width: 1
            border.color: "#6E6E6E"
            visible: if (order3_name.text == "") {false}
                     else {true}
        }

        Text {
            id: orderb_click
            text: "0"
            visible: false
        }
        Text {
            id: orderb_name
            text: ""
            visible: false
        }
        Text {
            id: orderb_street
            text: " "
            visible: false
        }
        Text {
            id: orderb_city
            text: ""
            visible: false
        }
        Text {
            id: orderb_statezip
            text: ""
            visible: false
        }
        Text {
            id: orderb_totalprice
            text: ""
            visible: false
        }
        Text {
            id: orderb_deliveryfee
            text: ""
            visible: false
        }
        Text {
            id: orderb_grandtotal
            text: ""
            visible: false
        }
        Text {
            id: orderb_order
            text: ""
            visible: false
        }
        Text {
            id: orderb_number
            text: ""
        }
        Button {
            id: backButton4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            width: 150
            text: "Return to homepage"
            onClicked:
                page.state = ""
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 70
            width: 150
            text: "View Battery Status"
            onClicked:
                page.state = "batterystatuswindowstate"
        }
    }

    /********************************************************/
    // Battery Status Window 2 [ORDERS] (vendor side)
    Window {
        id: batterystatuswindow
        width: page.width
        height: page.height
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
            anchors.top: parent.top
            anchors.topMargin: 100
            text: "BATTERY STATUS"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        TextField {
            id: percentage
            y: 700
            text: "87"
            anchors.horizontalCenter: parent.horizontalCenter
            validator: IntValidator {bottom: 0; top: 100;}
            font.pixelSize: 20
            font.letterSpacing: 2
        }
        Text {
            id: batterypercent
            anchors.horizontalCenter: parent.horizontalCenter
            y: 160
            text: "Battery is at " + percentage.text + "%"
            font.letterSpacing: 2
            font.family: "Avenir"
        }
        Rectangle {
            id: rectangle1
            anchors.horizontalCenter: parent.horizontalCenter
            y: 260
            width: 270
            height: 90
            border.width: 3
            border.color: "#000"
        }
        Rectangle {
            id: battery_green
            x: rectangle1.x + 10
            y: rectangle1.y + 10
            width: 250 * percentage.text / 100
            height: rectangle1.height - 20
            color: "#65E01F"
            rotation: 0
            visible: {
                if (percentage.text >= 85){true}
                else {false}
            }
        }
        Rectangle {
            id: battery_orange
            x: rectangle1.x + 10
            y: rectangle1.y + 10
            width: 250 * percentage.text / 100
            height: rectangle1.height - 20
            color: "#FF790A"
            visible: {
                if (percentage.text < 85 & percentage.text >= 60) {true}
                else {false}
            }
        }
        Rectangle {
            id: battery_red
            x: rectangle1.x + 10
            y: rectangle1.y + 10
            width: 250 * percentage.text / 100
            height: rectangle1.height - 20
            color: "#D60000"
            visible: {
                if (percentage.text < 60) {true}
                else {false}
            }
        }
        Text {
            id: batteryinfo
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            y: 400
            width: 270
            wrapMode: Text.WordWrap
            font.letterSpacing: 2
            font.family: "Avenir"
            text: {
               if (battery_green.visible == true) {
                   "Drone has enough power. Ready for delivery."
               }
               else if (battery_orange.visible == true) {
                   "Drone may not have enough power to finish delivery. Please recharge or replace the battery."
               }
               else {
                   "Drone does not have enough power for delivery. Please recharge or replace the battery."
               }
            }
            color:
                if (battery_green.visible == true) {"#000"}
                else {"#E00000"}
        }
        Button {
            id: proceed_button
            anchors.horizontalCenter: parent.horizontalCenter
            y: rectangle1.y + rectangle1.height + 150
            width: 150
            visible: if (battery_green.visible == true) {true} else {false}
            text: "Proceed"
            onClicked:
                page.state = "trackorderswindowstate"
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            y: rectangle1.y + rectangle1.height + 150
            width: 200
            height: proceed_button.height
            color: "#D60000"
            visible: if (battery_green.visible == true) {false} else {true}
            radius: 5
            Text {
                color: "white"
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "Replace battery to proceed"
            }
        }
        Button {
            id: cancel_button
            anchors.horizontalCenter: parent.horizontalCenter
            y: proceed_button.y + proceed_button.height + 30
            width: 150
            visible: true
            text: "Cancel"
            onClicked:
                page.state = "pendingorderswindowstate"
        }
    }

    /********************************************************/
    // Vendor Track Order (vendor side)
    Window {
        id: trackorderswindow
        width: page.width
        height: page.height
        Image {
            visible: true
            x: 430
            y: 730
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
            y: 100
            width: 400
            height: 300
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
                width: 400
                height: 300
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
            x: tracking_drone.x + tracking_drone.width + 20
            y: tracking_drone.y + 5
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
            anchors.leftMargin: 70
            text: "Current Distance:"
            font.family: "Avenir"
            horizontalAlignment: Text.AlignHCenter
            font.letterSpacing: 2
        }
        Text {
            id: display_distance
            anchors.right: parent.right
            anchors.rightMargin: 70
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
            anchors.leftMargin: 70
            text: qsTr("Current Status:")
            font.family: "Avenir"
            horizontalAlignment: Text.AlignHCenter
            font.letterSpacing: 2
        }
        Text {
            id: display_deliverystatus
            anchors.right: parent.right
            anchors.rightMargin: 70
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
            y: deliverystatus.y + deliverystatus.height + 25
            anchors.left: parent.left
            anchors.leftMargin: 70
            text: qsTr("Delivered")
            font.family: "Avenir"
            horizontalAlignment: Text.AlignHCenter
            font.letterSpacing: 2
        }
        TextField {
            id: delivered_validation
            y: delivered.y
            x: delivered.x + delivered.width + 70
        }
        Image {
            id: delivered_validationsign
            y: delivered.y - 5
            height: delivered.height + 10
            width: delivered.height + 10
            anchors.right: parent.right
            anchors.rightMargin: 70
            source: if (delivered_validation.text == "Y") {"checkgreen.png"}
                    else if (delivered_validation.text == "N" || delivered_validation.text == ""){"checkgrey.png"}
        }
        Text {
            id: returned
            y: delivered.y + delivered.height + 20
            anchors.left: parent.left
            anchors.leftMargin: 70
            text: qsTr("Returned")
            font.family: "Avenir"
            horizontalAlignment: Text.AlignHCenter
            font.letterSpacing: 2
        }
        TextField {
            id: returned_validation
            y: returned.y
            x: returned.x + returned.width + 70
        }
        Image {
            id: returned_validationsign
            y: returned.y - 5
            height: returned.height + 10
            width: returned.height + 10
            anchors.right: parent.right
            anchors.rightMargin: 70
            source: if (returned_validation.text == "Y") {"checkgreen.png"}
                    else if (returned_validation.text == "N" || returned_validation.text == ""){"checkgrey.png"}
        }
        Text {
            id: currentbattery
            anchors.left: parent.left
            anchors.leftMargin: 70
            y: returned.y + returned.height + 30
            text: "Current Battery:"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Rectangle {
            id: battery1
            anchors.right: parent.right
            anchors.rightMargin: 70
            y: currentbattery.y - 4
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
            y: currentbattery.y + currentbattery.height + 50
            visible: true
            text: "View other orders"
            width: cancelreturn.width
            onClicked: {
                page.state = "pendingorderswindowstate"
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
            y: view_other_orders.y + view_other_orders.height + 20
            visible: if (returned_validation.text == "Y") {false} else {true}
            text: "Cancel Order and Return"
            onClicked: {
                display_deliverystatus.text = "Returning"
                if (delivered_validation.text != "Y") {delivered_validation.text = "N"}
            }
        }
    }

    /********************************************************/
    // Drone Malfunction Error Page (vendor side)
    Window {
        id: malfunctioningwindow
        width: page.width
        height: page.height
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
            id: malfunctioningpagetitle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 200
            text: "WARNING!"
            font.family: "Avenir"
            font.letterSpacing: 2
            font.bold: true
            color: "#D60000"
        }
        Text {
            id: malfunctioning_warning
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            width: 300
            y: malfunctioningpagetitle.y + malfunctioningpagetitle.height + 50
            font.family: "Avenir"
            font.letterSpacing: 2
            wrapMode: Text.WordWrap
            text: "The propeller is malfunctioning or the drone does not have enough power to deliver/return. \n\n Issue is dire. \n \n Please land the drone and retrieve it immediately."
        }
        Button {
            id: malfunctioning_landing
            anchors.horizontalCenter: parent.horizontalCenter
            y: malfunctioning_warning.y + malfunctioning_warning.height + 50
            width: 150
            text: "Proceed"
            onClicked:
                page.state = "dronelocationwindowstate"
        }
    }

    /********************************************************/
    // Drone Location Page (vendor side)
    Window {
        id: dronelocationwindow
        width: page.width
        height: page.height
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
            id: dronelocation_title
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            text: qsTr("CURRENT DRONE LOCATION")
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Map {
            id: tracking_dronelocation_map
            anchors.horizontalCenter: parent.horizontalCenter
            y: dronelocation_title.y + dronelocation_title.height + 50
            width: 400
            height: 400
            plugin: osmplugin
            zoomLevel: (maximumZoomLevel)*0.95
            center {
                latitude: 22.3362535
                longitude: 114.2629409
            }
        }
        Button {
            id: beep
            anchors.horizontalCenter: parent.horizontalCenter
            width: retrieved.width
            y: tracking_dronelocation_map.y + tracking_dronelocation_map.height + 35
            visible: true
            text: "BEEP"
        }
        Button {
            id: retrieved
            anchors.horizontalCenter: parent.horizontalCenter
            y: beep.y + beep.height + 20
            visible: true
            text: "Click to confirm drone retrieval"
            onClicked:
                page.state = "pendingorderswindowstate"
        }
    }

    /********************************************************/
    //Menu Window (user side)
    Window {
        id: availableitemswindow
        width: page.width
        height: page.height
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
            id: availableitemswindowtitle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            text: "AVAILABLE ITEMS"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Rectangle {
            id: item1
            anchors.horizontalCenter: parent.horizontalCenter
            y: availableitemswindowtitle.y + 50
            width: page.width
            height: 90
            border.color: "#ADADAD"
            border.width: 0.5
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            TextField {
                id: quantity1
                anchors.right: parent.right
                anchors.rightMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                width: 60
                validator: IntValidator {bottom: 0; top: 9;}
                placeholderText: "0"
            }
            Text {
                id: itemname1
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "Water Balloon"
                font.family: "Avenir"
            }
            Text {
                id: itemweight1
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "100"
                font.family: "Avenir"
            }
            Text {
                x: itemweight1.x + itemweight1.width + 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "g"
                font.family: "Avenir"
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 150
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "$"
                font.family: "Avenir"
            }
            Text {
                id: itemprice1
                anchors.left: parent.left
                anchors.leftMargin: 160
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "2.15"
                font.family: "Avenir"
            }
        }
        Rectangle {
            id: item2
            anchors.horizontalCenter: parent.horizontalCenter
            y: item1.y + item1.height
            width: page.width
            height: 90
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            TextField {
                id: quantity2
                anchors.right: parent.right
                anchors.rightMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                width: 60
                validator: IntValidator {bottom: 0; top: 9;}
                placeholderText: "0"
            }
            Text {
                id: itemname2
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "Okra"
                font.family: "Avenir"
            }
            Text {
                id: itemweight2
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "100"
                font.family: "Avenir"
            }
            Text {
                x: itemweight2.x + itemweight2.width + 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "g"
                font.family: "Avenir"
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 150
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "$"
                font.family: "Avenir"
            }
            Text {
                id: itemprice2
                anchors.left: parent.left
                anchors.leftMargin: 160
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "2.20"
                font.family: "Avenir"
            }
        }
        Rectangle {
            id: item3
            anchors.horizontalCenter: parent.horizontalCenter
            y: item2.y + item2.height
            width: page.width
            height: 90
            border.color: "#ADADAD"
            border.width: 0.5
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            TextField {
                id: quantity3
                anchors.right: parent.right
                anchors.rightMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                width: 60
                validator: IntValidator {bottom: 0; top: 9;}
                placeholderText: "0"
            }
            Text {
                id: itemname3
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "Iced Coffee"
                font.family: "Avenir"
            }
            Text {
                id: itemweight3
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "200"
                font.family: "Avenir"
            }
            Text {
                x: itemweight3.x + itemweight3.width + 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "g"
                font.family: "Avenir"
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 150
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "$"
                font.family: "Avenir"
            }
            Text {
                id: itemprice3
                anchors.left: parent.left
                anchors.leftMargin: 160
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "5.00"
                font.family: "Avenir"
            }
        }
        Rectangle {
            id: item4
            anchors.horizontalCenter: parent.horizontalCenter
            y: item3.y + item3.height
            width: page.width
            height: 90
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            TextField {
                id: quantity4
                anchors.right: parent.right
                anchors.rightMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                width: 60
                validator: IntValidator {bottom: 0; top: 9;}
                placeholderText: "0"
            }
            Text {
                id: itemname4
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "Mangoes"
                font.family: "Avenir"
            }
            Text {
                id: itemweight4
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "100"
                font.family: "Avenir"
            }
            Text {
                x: itemweight4.x + itemweight4.width + 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "g"
                font.family: "Avenir"
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 150
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "$"
                font.family: "Avenir"
            }
            Text {
                id: itemprice4
                anchors.left: parent.left
                anchors.leftMargin: 160
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "3.00"
                font.family: "Avenir"
            }
        }
        Rectangle {
            id: totalbox
            anchors.horizontalCenter: parent.horizontalCenter
            y: item4.y + item4.height
            width: page.width
            height: 90
            border.color: "#ADADAD"
            border.width: 0.5
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            Text {
                id: totalweighttext
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "Total Weight:"
                font.family: "Avenir"
                font.pixelSize: 12
                style: Text.Normal
            }
            Text {
                id: totalpricetext
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "Total Price:"
                font.family: "Avenir"
            }
            Text {
                id: maxweighttext
                x: totalweight.x + totalweight.width + 10
                anchors.top: parent.top
                anchors.topMargin: 25
                text: "/ 400 g"
                font.family: "Avenir"
            }
            Text {
                id: dollarsign5
                anchors.left: parent.left
                anchors.leftMargin: 150
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: "$"
                font.family: "Avenir"
            }
            Text {
                id: totalweight
                color:
                    if (totalweight.text > 400) {"#D60000"}
                    else {"black"}
                font.family: "Avenir"
                anchors.left: parent.left
                anchors.leftMargin: 150
                anchors.top: parent.top
                anchors.topMargin: 25
                text: (quantity1.text*itemweight1.text) + (quantity2.text*itemweight2.text) + (quantity3.text*itemweight3.text) + (quantity4.text*itemweight4.text)
            }
            Text {
                id: totalprice
                font.family: "Avenir"
                x: dollarsign5.x + dollarsign5.width + 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                text: (quantity1.text*itemprice1.text) + (quantity2.text*itemprice2.text) + (quantity3.text*itemprice3.text) + (quantity4.text*itemprice4.text)
            }
        }
        Button {
            id: checkoutButton
            anchors.horizontalCenter: parent.horizontalCenter
            y: totalbox.y + totalbox.height + 40
            width: 150
            text: "Checkout"
            visible:
                if (totalweight.text > 400 || totalweight.text == 0) {false}
                else {true}
            onClicked: {
                page.state = "addressentrywindowstate"
            }
        }
        Rectangle {
            id: checkoutdenialrectangle
            anchors.horizontalCenter: parent.horizontalCenter
            y: totalbox.y + totalbox.height + 40
            width: 200
            height: 20
            color: "#D60000"
            radius: 5
            Text {
                color: "white"
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "Please remove some items."
            }
            visible:
                if (totalweight.text > 400) {true}
                else {false}
        }
        Rectangle {
            id: checkoutdenialrectangle2
            anchors.horizontalCenter: parent.horizontalCenter
            y: totalbox.y + totalbox.height + 40
            width: 200
            height: 20
            color: "#D60000"
            radius: 5
            Text {
                color: "white"
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "You have no items in your cart."
            }
            visible:
                if (totalweight.text == 0) {true}
                else {false}
        }
        Button {
            id: backButton1
            anchors.horizontalCenter: parent.horizontalCenter
            y: checkoutButton.y + checkoutButton.height + 15
            width: 150
            text: "Return to homepage"
            onClicked:
                page.state = ""
        }
        Button {
            id: clearButton
            anchors.horizontalCenter: parent.horizontalCenter
            y: backButton1.y + backButton1.height + 15
            width: 150
            text: "Clear all entries"
            onClicked:
                totalweight.text = 0
                ,quantity1.text = 0
                ,quantity2.text = 0
                ,quantity3.text = 0
                ,quantity4.text = 0

        }
    }

    /********************************************************/
    // Address Entry Window (user side)
    Window {
        id: addressentrywindow
        width: page.width
        height: page.height
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
            id: checkoutaddressWindowtitle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 75
            width: page.width - 100
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            text: "PLEASE ENTER YOUR SHIPPING INFORMATION"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        TextField {
            id: currentcustomername
            maximumLength: 40
            anchors.horizontalCenter: parent.horizontalCenter
            y: 160
            width: page.width - 100
            height: 40
            placeholderText: qsTr("Name")
        }
        TextField {
            id: currentcustomerstreet
            maximumLength: 30
            anchors.horizontalCenter: parent.horizontalCenter
            y: 230
            width: page.width - 100
            height: 40
            placeholderText: qsTr("Street")
        }
        TextField {
            id: currentcustomercity
            anchors.horizontalCenter: parent.horizontalCenter
            y: 300
            width: page.width - 100
            height: 40
            placeholderText: qsTr("City")
        }
        TextField {
            id: currentcustomerstate
            anchors.left: parent.left
            anchors.leftMargin: 50
            y: 370
            width: (page.width - 100) * 0.45
            height: 40
            placeholderText: qsTr("State")
        }
        TextField {
            id: currentcustomerzipcode
            maximumLength: 5
            anchors.right: parent.right
            anchors.rightMargin: 50
            y: 370
            width: (page.width - 100) * 0.45
            height: 40
            validator: IntValidator {bottom: 0; top: 99999;}
            placeholderText: qsTr("Zip Code")
        }
        TextField {
            id: currentcustomercountry
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Country"
            y: 440
            width: page.width - 100
            height: 40
        }
        TextField {
            id: currentcustomeremail
            anchors.horizontalCenter: parent.horizontalCenter
            y: 510
            width: page.width - 100
            height: 40
            placeholderText: qsTr("Email")
        }
        TextField {
            id: currentcustomerphone
            anchors.horizontalCenter: parent.horizontalCenter
            maximumLength: 11
            y: 580
            width: page.width - 100
            height: 40
            placeholderText: qsTr("Phone Number")
        }

        Button {
            id: submitaddressButton
            anchors.horizontalCenter: parent.horizontalCenter
            y: 660
            z: addressdenialrectangle.z + 3
            width: 100
            text: "Submit"
            visible:
                if (currentcustomerstreet.text == "" || currentcustomercity.text == "" || currentcustomerstate.text == "" || currentcustomerzipcode.text == "" || currentcustomeremail.text == "") {false}
                else {true}
            onClicked:
                page.state = "paymentwindowstate",
                geocodeModel.query = geocodeAddress,
                geocodeModel.update()
        }
        Rectangle {
            id: addressdenialrectangle
            anchors.horizontalCenter: parent.horizontalCenter
            y: 660
            z: emailrectangle.z + 3
            width: 150
            height: 20
            color: "#D60000"
            radius: 5
            Text {
                color: "white"
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "Address incomplete."
            }
            visible:
                if (currentcustomerstreet.text == "" || currentcustomercity.text == "" || currentcustomerstate.text == "") {true}
                else {false}
        }
        Rectangle {
            id: emailrectangle
            anchors.horizontalCenter: parent.horizontalCenter
            y: 660
            width: 150
            height: 20
            color: "#D60000"
            radius: 5
            Text {
                color: "white"
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "Please enter email"
            }
            visible:
                if (currentcustomeremail.text != "") {false}
                else {true}
        }
        Button {
            id: backButton3
            anchors.horizontalCenter: parent.horizontalCenter
            y: 700
            width: 100
            text: "Back"
            onClicked:
                page.state = "availableitemsstate"
        }
    }

    /********************************************************/
    // Payment Window (user side)
    Window {
        id: paymentwindow
        width: page.width
        height: page.height
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
            id: paymentWindowtitle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            text: "ENTER PAYMENT INFORMATION"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        RowLayout {
            id: rowLayout1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 150
            width: paymentWindowtitle.width
            Column {
                id: column0
                anchors.left: parent.left
                CheckBox {
                    id: checkBox1
                    text: qsTr("AMEX")
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked:
                        checkBox2.checked = false,
                        checkBox3.checked = false
                }
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 50
                    height: 50
                    fillMode: Image.PreserveAspectFit
                    source: "amx.png"
                }
            }
            Column {
                id: column1
                 anchors.horizontalCenter: parent.horizontalCenter
                CheckBox {
                    id: checkBox2
                    text: qsTr("Visa")
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked:
                        checkBox1.checked = false,
                        checkBox3.checked = false
                }
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 50
                    height: 50
                    fillMode: Image.PreserveAspectFit
                    source: "visa.png"
                }
            }
            Column {
                id: column2
                anchors.right: parent.right
                CheckBox {
                    id: checkBox3
                    text: qsTr("Discover")
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked:
                        checkBox1.checked = false,
                        checkBox2.checked = false
                }
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 50
                    height: 50
                    fillMode: Image.PreserveAspectFit
                    source: "discover.png"
                }
            }
        }
        TextField {
            id: cardnumber
            maximumLength: 19
            anchors.horizontalCenter: parent.horizontalCenter
            y: rowLayout1.y + rowLayout1.height + 40
            width: page.width - 100
            height: 40
            placeholderText: "Card Number"
            echoMode: TextInput.Password
        }
        TextField {
            id: cvccode
            maximumLength: 4
            validator: IntValidator{bottom: 0; top: 9999;}
            anchors.horizontalCenter: parent.horizontalCenter
            echoMode: TextInput.Password
            y: cardnumber.y + cardnumber.height + 40
            width: page.width - 100
            height: 40
            placeholderText: "Security Code"
        }
        TextField {
            id: cardholdername
            anchors.horizontalCenter: parent.horizontalCenter
            y: cvccode.y + cvccode.height + 40
            width: page.width - 100
            height: 40
            placeholderText: qsTr("Cardholder's Name")
        }
        TextField {
            id: cardexpirationdate
            maximumLength: 7
            anchors.horizontalCenter: parent.horizontalCenter
            y: cardholdername.y + cardholdername.height + 40
            width: page.width - 100
            height: 40
            placeholderText: "MM/YYYY" + "  " + "(Expiration Date)"
        }
        Button {
            id: submitpaymentinfoButton
            anchors.horizontalCenter: parent.horizontalCenter
            y: cardexpirationdate.y + cardexpirationdate.height + 40
            width: 180
            text: "Submit and Review Order"
            onClicked:
               page.state = "orderconfirmationwindowstate"
        }
        Button {
            id: backButton2
            anchors.horizontalCenter: parent.horizontalCenter
            y: submitpaymentinfoButton.y + submitpaymentinfoButton.height + 20
            width: 180
            text: "Back"
            onClicked:
               page.state = "addressentrywindowstate"
        }
    }

    /********************************************************/
    // Order Confirmation Window (user side)
    Window {
        id: orderconfirmationwindow
        width: page.width
        height: page.height
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
            id: orderconfirmationWindowtitle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            text: "PLEASE CONFIRM ORDER INFORMATION"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: addressdisplaytext
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 100
            text: "ADDRESS"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Button {
            id: editaddressButton
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 100
            width: 80
            text: "Edit"
            onClicked:
               page.state = "addressentrywindowstate"
        }
        Text {
            id: displayaddress
            anchors.left: parent.left
            anchors.leftMargin: 50
            y: addressdisplaytext.y + addressdisplaytext.height + 20
            text: currentcustomername.text + '<br>' + currentcustomerstreet.text + '<br>' + currentcustomercity.text  + ", " + currentcustomerstate.text + "  "+ currentcustomerzipcode.text
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: itemsordereddisplaytext
            anchors.left: parent.left
            anchors.leftMargin: 50
            y: displayaddress.y + displayaddress.height + 30
            text: "ITEMS ORDERED"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: item1confirmtext
            anchors.left: parent.left
            anchors.leftMargin: 50
            height: if (quantity1.text == 0 || quantity1.text == "") {itemsordereddisplaytext.height}
            y: if (quantity1.text == 0 || quantity1.text == "") {itemsordereddisplaytext.y}
               else {itemsordereddisplaytext.y + 20}
            text: if (quantity1.text == 0 || quantity1.text == "") {""}
                  else {itemname1.text + '<br>' + "Unit Price: $ " + itemprice1.text + '<br>' + "Quantity: "+ quantity1.text}
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: item2confirmtext
            anchors.left: parent.left
            anchors.leftMargin: 50
            height: if (quantity2.text == 0 || quantity2.text == "") {0}
            y: if (item1confirmtext.text == "") {itemsordereddisplaytext.y + 20}
               else {item1confirmtext.y + item1confirmtext.height + 20}
            text: if (quantity2.text == 0 || quantity2.text == "") {""}
                  else {itemname2.text + '<br>' + "Unit Price: $ " + itemprice2.text + '<br>' + "Quantity: "+ quantity2.text}
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: item3confirmtext
            anchors.left: parent.left
            anchors.leftMargin: 50
            height: if (quantity3.text == 0 || quantity3.text == "") {0}
            y: if (item2confirmtext.text == "") {item1confirmtext.y + item1confirmtext.height + 20}
               else {item2confirmtext.y + item2confirmtext.height + 20}
            text: if (quantity3.text == 0 || quantity3.text == "") {""}
                  else {itemname3.text + '<br>' + "Unit Price: $ " + itemprice3.text + '<br>' + "Quantity: "+ quantity3.text}
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: item4confirmtext
            anchors.left: parent.left
            anchors.leftMargin: 50
            height: if (quantity4.text == 0 || quantity4.text == "") {0}
            y: if (item3confirmtext.text == "") {item2confirmtext.y + item2confirmtext.height + 20}
               else {item3confirmtext.y + item3confirmtext.height + 20}
            text: if (quantity4.text == 0 || quantity4.text == "") {""}
                  else {itemname4.text + '<br>' + "Unit Price: $ " + itemprice4.text + '<br>' + "Quantity: "+ quantity4.text}
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Button {
            id: editorderButton
            anchors.right: parent.right
            anchors.rightMargin: 50
            y: itemsordereddisplaytext.y
            width: 80
            text: "Edit"
            onClicked:
               page.state = "availableitemsstate"
        }
        // Totals
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 180
            width: 200
            text: "TOTAL:"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            anchors.left: parent
            x: 220
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 180
            width: 200
            text: "$" + totalprice.text
            wrapMode: Text.WordWrap
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 160
            width: 200
            text: "TAX:"
            wrapMode: Text.WordWrap
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            anchors.left: parent
            x: 220
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 160
            width: 200
            text: "$" + (totalprice.text*0.18).toFixed(2)
            wrapMode: Text.WordWrap
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 140
            width: 200
            text: "SHIPPING:"
            wrapMode: Text.WordWrap
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            id: shippingfee
            x: 220
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 140
            width: 200
            text: if (totalweight.text > 0) {"$" + "4.00"} else {"$" + "0.00"}
            font.family: "Avenir"
            font.letterSpacing: 2        }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            width: 200
            text: "GRAND TOTAL:"
            wrapMode: Text.WordWrap
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Text {
            x: 220
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            width: 200
            text: if (totalweight.text > 0) {"$" + (totalprice.text*1.08 + 4.0).toFixed(2)} else {"$0.00"}
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Button {
            id: orderconfirmationButton
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 60
            width: 150
            text: "Place order now"
            onClicked: {
               page.state = "customertrackorderwindowstate"
               if (order1_name.text == "") {
                order1_name.text = currentcustomername.text
                order1_city.text = currentcustomercity.text
                order1_number.text = (quantity1.text * 1) + (quantity2.text * 1) + (quantity3.text * 1) + (quantity4.text * 1)
                order1_state.text = currentcustomerstate.text
                order1_zip.text = currentcustomerzipcode.text
                order1_street.text = currentcustomerstreet.text
                order1_country.text = currentcustomercountry.text
                order1_order.text = quantity1.text + " " + itemname1.text + "\n" +
                                    quantity2.text + " " + itemname2.text + "\n" +
                                    quantity3.text + " " + itemname3.text + "\n" +
                                    quantity4.text + " " + itemname4.text
                order1_totalprice.text = (quantity1.text*itemprice1.text) + (quantity2.text*itemprice2.text) + (quantity3.text*itemprice3.text) + (quantity4.text*itemprice4.text)
                order1_deliveryfee.text = shippingfee.text
                order1_grandtotal.text = (totalprice.text*1.08 + 4.0).toFixed(2)
                order1_time.text = Qt.formatTime(new Date(),"hh:mm")
            }
               else if (order2_name.text == ""){
                    order2_name.text = currentcustomername.text
                    order2_city.text = currentcustomercity.text
                    order2_number.text = (quantity1.text * 1) + (quantity2.text * 1) + (quantity3.text * 1) + (quantity4.text * 1)
                    order2_state.text = currentcustomerstate.text
                    order2_zip.text = currentcustomerzipcode.text
                    order2_street.text = currentcustomerstreet.text
                    order2_country.text = currentcustomercountry.text
                    order2_order.text = quantity1.text + " " + itemname1.text + "\n" +
                                        quantity2.text + " " + itemname2.text + "\n" +
                                        quantity3.text + " " + itemname3.text + "\n" +
                                        quantity4.text + " " + itemname4.text
                    order2_totalprice.text = (quantity1.text*itemprice1.text) + (quantity2.text*itemprice2.text) + (quantity3.text*itemprice3.text) + (quantity4.text*itemprice4.text)
                    order2_deliveryfee.text = shippingfee.text
                    order2_grandtotal.text = (totalprice.text*1.08 + 4.0).toFixed(2)
                    order2_time.text = Qt.formatTime(new Date(),"hh:mm")
            }
               else if (order3_name.text == ""){
                    order3_name.text = currentcustomername.text
                    order3_city.text = currentcustomercity.text
                    order3_number.text = (quantity1.text * 1) + (quantity2.text * 1) + (quantity3.text * 1) + (quantity4.text * 1)
                    order3_state.text = currentcustomerstate.text
                    order3_zip.text = currentcustomerzipcode.text
                    order3_street.text = currentcustomerstreet.text
                    order3_country.text = currentcustomercountry.text
                    order3_order.text = quantity1.text + " " + itemname1.text + "\n" +
                                        quantity2.text + " " + itemname2.text + "\n" +
                                        quantity3.text + " " + itemname3.text + "\n" +
                                        quantity4.text + " " + itemname4.text
                    order3_totalprice.text = (quantity1.text*itemprice1.text) + (quantity2.text*itemprice2.text) + (quantity3.text*itemprice3.text) + (quantity4.text*itemprice4.text)
                    order3_deliveryfee.text = shippingfee.text
                    order3_grandtotal.text = (totalprice.text*1.08 + 4.0).toFixed(2)
                    order3_time.text = Qt.formatTime(new Date(),"hh:mm")
            }
            }
        }
    }

    /********************************************************/
    // Customer Track Order Window (user side)
    Window {
        id: customertrackorderwindow
        title: "Track Your Order"
        width: page.width
        height: page.height
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
            id: customertrackWindowtitle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            text: "TRACK YOUR ORDER"
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Plugin {
            id: osmplugin
            name:"osm"
        }
        Address {
            id: geocodeAddress
            street: currentcustomerstreet.text
            city: currentcustomercity.text
            state: currentcustomerstate.text
            country: currentcustomercountry.text
            postalCode: currentcustomerzipcode.text
        }
        Map {
            id: map
            plugin: osmplugin
            zoomLevel: maximumZoomLevel
            anchors.horizontalCenter: parent.horizontalCenter
            y: 100
            width: page.width - 100
            height: map.width - 100

            signal resetState()

            center {
                latitude: 22.336400
                longitude: 114.265466
            }

            gesture.flickDeceleration: 3000
            gesture.enabled: true

            // HOME
            MapCircle {
                id: redcircle
                center {
                    latitude: 22.336400
                    longitude: 114.265466
                }

                radius: if (map.zoomLevel < 13) {200}
                        else {20}

                color: "#FF4747"
                border.width: 1
                border.color: "#242424"
                opacity: 0.6
            }

            Slider {
                id: zoomSlider;
                opacity: 1
                maximumValue: 20;
                minimumValue: 10;
                visible: parent.visible
                z: map.z + 3
                anchors {
                    bottom: parent.bottom;
                    bottomMargin: 15; rightMargin: 30; leftMargin: 30
                    left: parent.left
                }
                width: parent.width - anchors.rightMargin - anchors.leftMargin

                value: map.zoomLevel

                Binding {
                    target: zoomSlider; property: "value"; value: 12
                }

                onValueChanged: {
                    map.zoomLevel = value
                    map.state=""
                    map.resetState()
                }
            }

            Text {
                id: customerlat
                text: ""
                visible: false
            }

            Text {
                id: customerlong
                text: ""
                visible: false
            }

            GeocodeModel {
                id: geocodeModel
                plugin: osmplugin
                autoUpdate: true
                query: geocodeAddress
                onLocationsChanged:
                {
                    map.center.latitude = get(0).coordinate.latitude
                    map.center.longitude = get(0).coordinate.longitude
                    customerlat.text = get(0).coordinate.latitude
                    customerlong.text = get(0).coordinate.longitude
                }

            }

            Component {
                id: pointDelegate
                MapCircle {
                    radius: 5000/map.zoomLevel
                    color: "#F666FF"
                    opacity: 0.5
                    center {
                        latitude: customerlat.text
                        longitude: customerlong.text
                    }
                }
            }

            MapItemView {
                model: geocodeModel
                delegate: pointDelegate
            }
        }
        // Displays Customer Address
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 50
            y: map.y + map.height + 20
            width: 200
            text: "Delivering to: " + '<br>' + currentcustomername.text + '<br>' + currentcustomerstreet.text + '<br>' + currentcustomercity.text  + ", " + currentcustomerstate.text + "  "+ currentcustomerzipcode.text
            font.family: "Avenir"
            font.letterSpacing: 2
        }

        // Displays Lat/Long of Destination Address
        /*Text {
            anchors.left: parent
            x: 50
            y: 200 + map.height
            width: 200
            text: "Latitude: " + map.center.latitude + '<br>' + "Longitude: "+ map.center.longitude
            font.family: "Avenir"
            font.letterSpacing: 2
        }*/

        // Place another order
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 70
            width: 150
            text: "Place another order"
            onClicked:
               page.state = ""
        }
    }

    /********************************************************/
    // PAGE STATES!!!!!!!!
    states: [
        // Original Page State
        State {
            name: "openingwindowstate"
            PropertyChanges {target: openingwindow; visible: true}
            PropertyChanges {target: availableitemswindow; visible: false}
            PropertyChanges {target: addressentrywindow; visible: false}
            PropertyChanges {target: orderconfirmationwindow; visible: false}
            PropertyChanges {target: paymentwindow; visible: false}
            PropertyChanges {target: customertrackorderwindow; visible: false}
            PropertyChanges {target: pendingorderswindow; visible: false}
            PropertyChanges {target: malfunctioningwindow; visible: false}
        },
        // Pending Orders State
        State {
            name: "pendingorderswindowstate"
            PropertyChanges {target: pendingorderswindow; visible: true}
            PropertyChanges {target: openingwindow; visible: false}
            PropertyChanges {target: availableitemswindow; visible: false}
            PropertyChanges {target: addressentrywindow; visible: false}
            PropertyChanges {target: orderconfirmationwindow; visible: false}
            PropertyChanges {target: paymentwindow; visible: false}
            PropertyChanges {target: customertrackorderwindow; visible: false}
            PropertyChanges {target: dronelocationwindow; visible: false}
            PropertyChanges {target: malfunctioningwindow; visible: false}
        },
        // Battery Status State
        State {
            name: "batterystatuswindowstate"
            PropertyChanges {target: batterystatuswindow; visible: true}
            PropertyChanges {target: openingwindow; visible: false}
            PropertyChanges {target: availableitemswindow; visible: false}
            PropertyChanges {target: addressentrywindow; visible: false}
            PropertyChanges {target: orderconfirmationwindow; visible: false}
            PropertyChanges {target: paymentwindow; visible: false}
            PropertyChanges {target: customertrackorderwindow; visible: false}
            PropertyChanges {target: pendingorderswindow; visible: false}
            PropertyChanges {target: dronelocationwindow; visible: false}
            PropertyChanges {target: malfunctioningwindow; visible: false}
        },
        // Vendor Tracking Orders State
        State {
            name: "trackorderswindowstate"
            PropertyChanges {target: trackorderswindow; visible: true}
            PropertyChanges {target: batterystatuswindow; visible: false}
            PropertyChanges {target: openingwindow; visible: false}
            PropertyChanges {target: malfunctioningwindow; visible: false}
        },
        // Drone Location State
        State {
            name: "dronelocationwindowstate"
            PropertyChanges {target: malfunctioningwindow; visible: false}
            PropertyChanges {target: dronelocationwindow; visible: true}
            PropertyChanges {target: openingwindow; visible: false}
        },
        // Menu State
        State {
            name: "availableitemsstate"
            PropertyChanges {target: availableitemswindow; visible: true}
            PropertyChanges {target: openingwindow; visible: false}
            PropertyChanges {target: addressentrywindow; visible: false}
            PropertyChanges {target: orderconfirmationwindow; visible: false}
            PropertyChanges {target: paymentwindow; visible: false}
            PropertyChanges {target: customertrackorderwindow; visible: false}
            PropertyChanges {target: pendingorderswindow; visible: false}
        },
        // Address Entry Window State
        State {
            name: "addressentrywindowstate"
            PropertyChanges {target: addressentrywindow; visible: true}
            PropertyChanges {target: openingwindow; visible: false}
            PropertyChanges {target: availableitemswindow; visible: false}
            PropertyChanges {target: paymentwindow; visible: false}
            PropertyChanges {target: orderconfirmationwindow; visible: false}
            PropertyChanges {target: customertrackorderwindow; visible: false}
            PropertyChanges {target: pendingorderswindow; visible: false}
        },
        // Payment Window State
        State {
            name: "paymentwindowstate"
            PropertyChanges {target: paymentwindow; visible: true}
            PropertyChanges {target: openingwindow; visible: false}
            PropertyChanges {target: availableitemswindow; visible: false}
            PropertyChanges {target: addressentrywindow; visible: false}
            PropertyChanges {target: orderconfirmationwindow; visible: false}
            PropertyChanges {target: customertrackorderwindow; visible: false}
            PropertyChanges {target: pendingorderswindow; visible: false}
        },
        // Order Confirmation Window State
        State {
            name: "orderconfirmationwindowstate"
            PropertyChanges {target: orderconfirmationwindow; visible: true}
            PropertyChanges {target: openingwindow; visible: false}
            PropertyChanges {target: paymentwindow; visible: false}
            PropertyChanges {target: availableitemswindow; visible: false}
            PropertyChanges {target: addressentrywindow; visible: false}
            PropertyChanges {target: customertrackorderwindow; visible: false}
            PropertyChanges {target: pendingorderswindow; visible: false}
        },
        // Customer Track Order Window State
        State {
            name: "customertrackorderwindowstate"
            PropertyChanges {target: customertrackorderwindow; visible: true}
            PropertyChanges {target: openingwindow; visible: false}
            PropertyChanges {target: orderconfirmationwindow; visible: false}
            PropertyChanges {target: paymentwindow; visible: false}
            PropertyChanges {target: availableitemswindow; visible: false}
            PropertyChanges {target: addressentrywindow; visible: false}
            PropertyChanges {target: pendingorderswindow; visible: false}
        }
    ]
}
