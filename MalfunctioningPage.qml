import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.1
import QtPositioning 5.2
import QtLocation 5.3
import QtQuick.Dialogs 1.2

Dialog {
    contentItem: Rectangle {
        id: malfunctionrect
        implicitWidth: 550
        implicitHeight: 900
        visible: if (((manual_control_handler.voltage - 13500) / 31) <= 20.0) {true} else {false}

        Text {
            id: malfunctioningpagetitle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: malfunctionrect.height*.03
            text: "WARNING!"
            font.family: "Avenir"
            font.pixelSize: 30
            font.letterSpacing: 2
            font.bold: true
            color: "#D60000"
        }
        Text {
            id: malfunctioning_warning
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            width: malfunctionrect.width * 0.8
            y: malfunctioningpagetitle.y + malfunctioningpagetitle.height + malfunctionrect.height*.03
            font.family: "Avenir"
            font.pixelSize: 20
            font.letterSpacing: 2
            wrapMode: Text.WordWrap
            text: if (((manual_control_handler.voltage - 13500) / 31) <= 5.0) {
                    "The drone does not have enough power to complete delivery. \n\n Please land the drone and retrieve it immediately."}
                  else {
                    "The drone is malfunctioning. \n\n Issue is dire. Please land the drone and retrieve it immediately."}
        }
        Plugin {
            id: osmplugin4
            name:"osm"
        }
        Address {
            id: geocodeAddress4
            street: address_page_handler.street
            city:  address_page_handler.city
            state:  address_page_handler.state
            country:  address_page_handler.region
            postalCode:  address_page_handler.zip
        }
        Text {
            id: customerlat4
            text: ""
            visible: false
        }
        Text {
            id: customerlong4
            text: ""
            visible: false
        }
        MapPolyline {
            line.width: 3
            line.color: 'green'
            path: [
                { latitude: vendor_handler.latitude, longitude: vendor_handler.longitude },
                { latitude: customerlat4.text, longitude: customerlong4.text }
            ]
        }
        Map {
            id: map4
            plugin: osmplugin4
            zoomLevel: maximumZoomLevel
            anchors.horizontalCenter: parent.horizontalCenter
            y: malfunctioning_warning.y + malfunctioning_warning.height + 20
            width: malfunctionrect.width * 0.8
            height: map4.width * 0.8

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

                radius: if (map4.zoomLevel < 13) {200}
                        else {20}

                color: "#FF4747"
                border.width: 1
                border.color: "#242424"
                opacity: 0.6
            }

            Slider {
                id: zoomSlider4;
                opacity: 1
                maximumValue: 20;
                minimumValue: 10;
                visible: parent.visible
                z: map4.z + 3
                anchors {
                    bottom: parent.bottom;
                    bottomMargin: 15; rightMargin: 30; leftMargin: 30
                    left: parent.left
                }
                width: parent.width - anchors.rightMargin - anchors.leftMargin

                value: map4.zoomLevel

                Binding {
                    target: zoomSlider4; property: "value"; value: 12
                }

                onValueChanged: {
                    map4.zoomLevel = value
                    map4.state=""
                    map4.resetState()
                }
            }

            GeocodeModel {
                id: geocodeModel4
                plugin: osmplugin4
                autoUpdate: true
                query: geocodeAddress4
                onLocationsChanged:
                {
                    map4.center.latitude = get(0).coordinate.latitude
                    map4.center.longitude = get(0).coordinate.longitude
                    customerlat4.text = get(0).coordinate.latitude
                    customerlong4.text = get(0).coordinate.longitude
                }
            }

            Component {
                id: pointDelegate4
                MapCircle {
                    radius: 5000/map4.zoomLevel
                    color: "#F666FF"
                    opacity: 0.5
                    center {
                        latitude: customerlat4.text
                        longitude: customerlong4.text
                    }
                }
            }

            MapItemView {
                model: geocodeModel4
                delegate: pointDelegate4
            }
        }
        Button {
            id: emergency_land_button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: malfunctionrect.height * 0.23
            width: drone_retrieved_button.width
            height: malfunctionrect.height*.08
            text: "Land Drone Now"
        }
        Button {
            id: beep_button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: malfunctionrect.height * 0.13
            width: drone_retrieved_button.width
            height: malfunctionrect.height*.08
            text: "Beep Drone"
        }
        Button {
            id: drone_retrieved_button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: malfunctionrect.height * 0.03
            height: malfunctionrect.height*.08
            width: malfunctionrect.width * 0.6
            text: "Drone Retrieved"
        }
    }
}
