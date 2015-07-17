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
        street: address_page_handler.street
        city:  address_page_handler.city
        state:  address_page_handler.state
        country:  address_page_handler.region
        postalCode:  address_page_handler.zip
    }

    MapPolyline {
        line.width: 3
        line.color: 'green'
        path: [
            { latitude: currentlatitude.text, longitude: currentlongitude.text },
            { latitude: customerlat.text, longitude: customerlong.text }
        ]
    }

    Map {
        id: map
        plugin: osmplugin
        zoomLevel: maximumZoomLevel
        anchors.horizontalCenter: parent.horizontalCenter
        y: 100
        width: page.width * 1.2
        height: page.width

        signal resetState()

        center {
            latitude: 22.336400
            longitude: 114.265466
        }

        gesture.flickDeceleration: 3000
        gesture.enabled: true

        // HOME
        MapCircle {
            id: homecoordinates
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
    Text {
        id: custtrackorderaddress
        anchors.left: parent.left
        anchors.leftMargin: 50
        y: map.y + map.height + 20
        width: 200
        text: "Delivering to: " + '<br>' + currentcustomername.text + '<br>' + currentcustomerstreet.text + '<br>' + currentcustomercity.text  + ", " + currentcustomerstate.text + "  "+ currentcustomerzipcode.text
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: distancecustside
        text: Math.floor(6371000*Math.acos(Math.sin(currentlatitude.text*0.0174532925) * Math.sin(customerlat.text*0.0174532925) + Math.cos(currentlatitude.text*0.0174532925) * Math.cos(customerlat.text*0.0174532925) * Math.cos (customerlong.text*0.0174532925 - currentlongitude.text*0.0174532925))) + " m"
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
    TextField {
        id: orderrecievedvalidation
        y: display_distancecustside.y + display_distancecustside.height + 20
        anchors.left: enroute.right
        anchors.right: enroutevalidation.left
        placeholderText: "Test Y or N"
    }
    Image {
        y: orderrecieved.y - 5
        height: orderrecieved.height + 10
        width: orderrecieved.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 70
        source: if (orderrecievedvalidation.text == "Y") {"checkgreen.png"}
                else if (orderrecievedvalidation.text == "N" || orderrecievedvalidation.text == ""){"checkgrey.png"}
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
    TextField {
        id: enroutevalidation
        y: orderrecieved.y + orderrecieved.height + 20
        anchors.left: enroute.right
        anchors.right: enroutevalidation.left
        placeholderText: "Test Y or N"
    }
    Image {
        y: enroute.y - 5
        height: enroute.height + 10
        width: enroute.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 70
        source: if (enroutevalidation.text == "Y") {"checkgreen.png"}
                else if (enroutevalidation.text == "N" || enroutevalidation.text == ""){"checkgrey.png"}
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
    TextField {
        id: deliveredvalidation2
        y: enroute.y + enroute.height + 20
        anchors.left: enroute.right
        anchors.right: enroutevalidation.left
        placeholderText: "Test Y or N"
    }
    Image {
        y: delivered2.y - 5
        height: delivered2.height + 10
        width: delivered2.height + 10
        anchors.right: parent.right
        anchors.rightMargin: 70
        source: if (deliveredvalidation2.text == "Y") {"checkgreen.png"}
                else if (deliveredvalidation2.text == "N" || deliveredvalidation2.text == ""){"checkgrey.png"}
    }

    // Displays Lat/Long of Destination Address
    /*Text {
        anchors.left: parent
        y: 200 + map.height
        width: 200
        text: "Latitude: " + map.center.latitude + '<br>' + "Longitude: "+ map.center.longitude
        font.family: "Avenir"
        font.letterSpacing: 2
    }*/
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
        text: "Place another order"
        onClicked:{
            customer_track_page.visible = false
            opening_page.visible = true
        }
    }
}


