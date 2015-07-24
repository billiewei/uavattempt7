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
            line.color: 'green'
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
                id: homecoordinates3
                center {
                    latitude: 22.336400
                    longitude: 114.265466
                }

                radius: if (map3.zoomLevel < 13) {200}
                        else {20}

                color: "#FF4747"
                border.width: 1
                border.color: "#242424"
                opacity: 0.6
            }

            Slider {
                id: zoomSlider3;
                opacity: 1
                maximumValue: 20;
                minimumValue: 10;
                visible: parent.visible
                z: map3.z + 3
                anchors {
                    bottom: parent.bottom;
                    bottomMargin: 15; rightMargin: 30; leftMargin: 30
                    left: parent.left
                }
                width: parent.width - anchors.rightMargin - anchors.leftMargin

                value: map3.zoomLevel

                Binding {
                    target: zoomSlider3; property: "value"; value: 12
                }

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
                MapCircle {
                    radius: 5000/map3.zoomLevel
                    color: "#F666FF"
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

