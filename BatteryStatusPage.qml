import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true

    Image {
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: page.width * 0.05
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.width * 0.05
        width: page.width * 0.15
        height: page.width * 0.15
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
        anchors.bottomMargin: 50
        // text: manual_control_handler.m_battery
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
        anchors.left: parent.left
        anchors.leftMargin: page.width * 0.15
        wrapMode: Text.WordWrap
        font.letterSpacing: 2
        visible: true
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
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height * 0.2
        visible: battery_green.visible & (vendor_handler.delivery != 0)
        text: "Proceed"
        onClicked: {
            battery_status_page.visible = false
            vendor_track_page.visible = true
        }
    }
    Rectangle {
        id: batterydenialrectangle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height * 0.2
        width: page.width * .6
        height: proceed_button.height
        color: "#D60000"
        visible: if (battery_green.visible == true || backButton5.visible == true) {false} else {true}
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
        id: backButton5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height * 0.1
        text: "Go Back"
        onClicked: {
            battery_status_page.visible = false
            pending_order_page.visible = true
            proceed_button.visible = true
            cancel_button.visible = true
        }
    }
}

