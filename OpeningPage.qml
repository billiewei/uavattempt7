import QtQuick 2.0
import QtQuick.Controls 1.3
import HKUST 1.0

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true

    Image {
        id: logo
        visible: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.height*.2
        width: page.width*.25
        height: page.width*.25
        source: "qrc:/logo.png"
        asynchronous : true
    }
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        y: logo.y + logo.height + 100
        width: userloginButton.width
        id: vendorButton
        text: "Vendor Login"
        onClicked: {
            opening_page.visible = false
            pending_order_page.visible = true
        }
    }
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        y: vendorButton.y + vendorButton.height + 30
        id: userloginButton
        text: "Place an Order"
        onClicked: {
           opening_page.visible = false
           menu_page.visible = true
        }
    }
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true
        y: userloginButton.y + userloginButton.height + 30
        width: userloginButton.width
        id: aboutButton
        text: "About"
        onClicked: {
            opening_page.visible = false
            about_page.visible = true
        }
    }
}

