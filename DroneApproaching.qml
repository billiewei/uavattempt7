import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.1
import QtPositioning 5.2
import QtLocation 5.3
import QtQuick.Dialogs 1.2

Dialog {
    id: droneapproachingmessagedialog
    contentItem: Rectangle {
        id: droneapproachrect
        implicitWidth: 550
        implicitHeight: 900
        Plugin {
            id: osmplugin3
            name:"osm"
        }
        Address {
            id: geocodeAddress3
            street: address_page_handler.street
            city:  address_page_handler.city
            state:  address_page_handler.state
            country:  address_page_handler.region
            postalCode:  address_page_handler.zip
        }
        Text {
            id: customerlat3
            text: ""
            visible: false
        }
        Text {
            id: customerlong3
            text: ""
            visible: false
        }
        MapPolyline {
            line.width: 3
            line.color: 'black'
            path: [
                { latitude: vendor_handler.latitude, longitude: vendor_handler.longitude },
                { latitude: customerlat3.text, longitude: customerlong3.text }
            ]
        }
        Map {
            id: map3
            plugin: osmplugin3
            zoomLevel: maximumZoomLevel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: droneapproachrect.height*0.35
            width: droneapproachrect.width * 0.8
            height: droneapproachrect.height * 0.45

            signal resetState()

            center {
                latitude: 22.336400
                longitude: 114.265466
            }

            gesture.flickDeceleration: 3000
            gesture.enabled: true

            // HOME
            MapCircle {
                center {
                    latitude: vendor_handler.latitude
                    longitude: vendor_handler.longitude
                }
                radius: if (map3.zoomLevel < 13) {200} else {30}
                color: "#3938FF" // Origin Point will be in blue
                border.width: 2
                border.color: "#000"
                opacity: 0.6
            }
            // DRONE POINT
            MapCircle {
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
            Slider {
                id: zoomSlider3;
                opacity: 1
                maximumValue: 19;
                minimumValue: 2;
                anchors {
                    bottom: parent.bottom;
                    bottomMargin: 15; rightMargin: 30; leftMargin: 30
                    left: parent.left
                }
                width: parent.width - anchors.rightMargin - anchors.leftMargin
                value: 13
                onValueChanged: {
                    map3.zoomLevel = value
                    map3.state=""
                    map3.resetState()
                }
            }
            GeocodeModel {
                id: geocodeModel3
                plugin: osmplugin3
                autoUpdate: true
                query: geocodeAddress3
                onLocationsChanged:
                {
                    map3.center.latitude = get(0).coordinate.latitude
                    map3.center.longitude = get(0).coordinate.longitude
                    customerlat3.text = get(0).coordinate.latitude
                    customerlong3.text = get(0).coordinate.longitude
                }
            }
            Component {
                id: pointDelegate3
                // CUSTOMER ADDRESS
                MapCircle {
                    radius: if (map.zoomLevel < 13) {200} else {30}
                    color: "#C638FF"
                    opacity: 0.5
                    center {
                        latitude: customerlat3.text
                        longitude: customerlong3.text
                    }
                }
            }
            MapItemView {
                model: geocodeModel3
                delegate: pointDelegate3
            }
        }
        Text {
            text: "ORDER APPROACHING \n \nPlease wait outside to retrieve your items. For your safety, please keep all parts of your body away from the drone."
            color: "#000"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            anchors.top: parent.top
            width: droneapproachrect.width * 0.8
            anchors.topMargin: 40
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            text: "I have received my order."
            onClicked:
                droneapproachingmessagedialog.visible = false
        }
    }
}

