import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtPositioning 5.2
import QtLocation 5.3

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: if (((manual_control_handler.voltage - 13500) / 31) <= 20.0) {true} else {false}

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
        anchors.topMargin: page.height * 0.03
        text: "CURRENT DRONE LOCATION"
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Plugin {
        id: osmplugin2
        name:"osm"
    }
    Map {
        id: map3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.height * 0.08
        width: page.width*0.8
        height: page.height * 0.6
        plugin: osmplugin2
        zoomLevel: mapslider3.value
        center {
            latitude: 22.3362535
            longitude: 114.2629409
        }
        gesture.flickDeceleration: 3000
        gesture.enabled: true
        // HOME POINT
        MapCircle {
            id: originpoint3
            radius: if (mapslider3.value < 13) {200}
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
                if (mapslider3.value > 13) {5}
                else if (mapslider3.value = 13) {20}
                else if (mapslider3.value > 12 & mapslider3.value < 13) {200}
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
    }
    Slider {
        id: mapslider3
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.05
        anchors.top: parent.top
        anchors.topMargin: page.height * 0.08
        height: map3.height
        value: 13
        maximumValue: 19
        minimumValue: 2
        tickmarksEnabled: false
        updateValueWhileDragging: true
        visible: true
        orientation: Qt.Vertical
    }
    Button {
        id: beep
        anchors.horizontalCenter: parent.horizontalCenter
        width: retrieved.width
        y: map3.y + map3.height + page.height * 0.1
        visible: true
        text: "BEEP"
    }
    Button {
        id: retrieved
        anchors.horizontalCenter: parent.horizontalCenter
        y: beep.y + beep.height + page.height * 0.05
        visible: true
        text: "Click to confirm drone retrieval"
        onClicked:{
            drone_location_page.visible = false
            pending_order_page.visible = true
        }
    }
}

