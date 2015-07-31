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
        id: customertrackWindowtitle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.height * 0.05
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
        street: address_page_handler.street
        city:  address_page_handler.city
        state:  address_page_handler.state
        country:  address_page_handler.region
        postalCode:  address_page_handler.zip
    }
    Map {
        id: map
        plugin: osmplugin
        zoomLevel: maximumZoomLevel
        anchors.horizontalCenter: parent.horizontalCenter
        y: page.height * 0.08
        width: page.width * 0.8
        height: page.width * 0.6

        signal resetState()

        center {
            latitude: 22.336400
            longitude: 114.265466
        }
        gesture.flickDeceleration: 3000
        gesture.enabled: true

        // ORIGIN POINT
        MapCircle {
            id: homecoordinates
            center {
                latitude: vendor_handler.latitude
                longitude: vendor_handler.longitude
            }
            radius: if (map.zoomLevel < 13) {200} else {30}
            color: "#3938FF" // Origin Point will be in blue
            border.width: 2
            border.color: "#000000"
            opacity: 0.6
        }
        // DRONE POINT
        MapCircle {
            id: dronepoint
            radius:
                if (zoomSlider.value > 13) {5}
                else if (zoomSlider.value = 13) {20}
                else if (zoomSlider.value > 12 & zoomSlider.value < 13) {200}
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
        MapPolyline {
            line.width: 3
            line.color: "#000000"
                path: [
                { latitude: vendor_handler.latitude, longitude: vendor_handler.longitude },
                { latitude: customerlat.text, longitude: customerlong.text }
            ]
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
            // DESTINATION POINT
            MapCircle {
                radius: if (map.zoomLevel < 13) {200} else {30}
                color: "#C638FF"
                border.color: "#000000"
                opacity: 0.6
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
    Slider {
        id: zoomSlider;
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.top: parent.top
        anchors.topMargin: map.y
        height: map.height
        value: 13
        maximumValue: 19
        minimumValue: 2
        tickmarksEnabled: false
        updateValueWhileDragging: true
        visible: true
        orientation: Qt.Vertical
        onValueChanged: {
            map.zoomLevel = value
            map.state=""
            map.resetState()
        }
    }

    Text {
        id: custtrackorderaddress
        anchors.left: parent.left
        anchors.leftMargin: 50
        y: map.y + map.height + 20
        width: 200
        text: "Delivering to: " + '<br>' + address_page_handler.name + '<br>' + address_page_handler.street + '<br>'
              + address_page_handler.city  + ", " + address_page_handler.state + "  "+ address_page_handler.zip
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: distancecustside
        text: Math.floor(6371000*Math.acos(Math.sin(vendor_handler.latitude*0.0174532925) * Math.sin(customerlat.text*0.0174532925) + Math.cos(vendor_handler.latitude*0.0174532925) * Math.cos(customerlat.text*0.0174532925) * Math.cos (customerlong.text*0.0174532925 - vendor_handler.longitude*0.0174532925))) + " m"
        visible: false
        y: custtrackorderaddress.y + custtrackorderaddress.height + 20
    }
    Text {
        y: custtrackorderaddress.y + custtrackorderaddress.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Current Distance:"
        font.family: "Avenir"
        horizontalAlignment: Text.AlignHCenter
        font.letterSpacing: 2
    }
    Text {
        id: display_distancecustside
        anchors.right: parent.right
        anchors.rightMargin: 70
        y: custtrackorderaddress.y + custtrackorderaddress.height + 20
        text: distancecustside.text
        font.family: "Avenir"
        horizontalAlignment: Text.AlignHCenter
        font.letterSpacing: 2
    }
    Text {
        id: orderrecieved
        y: display_distancecustside.y + display_distancecustside.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Order Recieved"
        font.family: "Avenir"
        font.letterSpacing: 2
        z: 10
    }
    Image {
        id: orderrecieved_circle
        y: orderrecieved.y - 5
        height: orderrecieved.height + 10
        width: orderrecieved.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 70
        source: "checkgreen.png"
    }
    Text {
        id: enroute
        y: orderrecieved.y + orderrecieved.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Order En Route"
        font.family: "Avenir"
        font.letterSpacing: 2
        z: 10
    }
    Image {
        id: enroutevalidation_circle
        y: enroute.y - 5
        height: enroute.height + 10
        width: enroute.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 70
        source: if (vendor_handler.enroute == 1) {"checkgreen.png"}
                else {"checkgrey.png"}
    }
    Text {
        id: delivered2
        y: enroute.y + enroute.height + 20
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: "Delivered"
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Image {
        id: deliveredvalidation_circle
        y: delivered2.y - 5
        height: delivered2.height + 10
        width: delivered2.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 70
        source: "checkgrey.png"
    }
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height * 0.05
        text: "Place another order"
        onClicked:{
            customer_track_page.visible = false
            opening_page.visible = true
        }
    }
}


