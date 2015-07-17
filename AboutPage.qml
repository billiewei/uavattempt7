import QtQuick 2.0
import QtQuick.Controls 1.3

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true
    Image {
        id: aboutlogo
        visible: true
        anchors.horizontalCenter: parent.horizontalCenter
        y: 100
        width: 100
        height: 100
        source: "qrc:/logo.png"
        asynchronous : true
    }
    Text {
        id: about
        anchors.horizontalCenter: parent.horizontalCenter
        y: aboutlogo.y + aboutlogo.height + 50
        text: "ABOUT"
        font.family: "Avenir"
        font.letterSpacing: 2
        font.pixelSize: 20
    }
    Text {
        id: aboutinfo
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        y: about.y + about.height + 20
        width: page.width*0.8
        wrapMode: Text.WordWrap
        text: "This delivery system application was developed by the Harvard-HKUST Design Team 2015. To place an order, please click the buttons and follow the instructions given."
        font.family: "Avenir"
        font.letterSpacing: 2
        font.pixelSize: 20
    }
    Text {
        id: terms
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        y: aboutinfo.y + aboutinfo.height + 30
        width: page.width*0.8
        wrapMode: Text.WordWrap
        text: "TERMS OF USE"
        font.family: "Avenir"
        font.letterSpacing: 2
        font.pixelSize: 20
    }
    Text {
        id: termsinfo
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        y: terms.y + terms.height + 20
        width: page.width*0.8
        wrapMode: Text.WordWrap
        text: "By using this service you are bound to the terms of use outlined below. This app is currently under development and we reserve the right to make any changes or deny service for any reason. Also, your credit card information is definitely not at all secure, and we apologize for that."
        font.family: "Avenir"
        font.letterSpacing: 2
        font.pixelSize: 20
    }
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        y: termsinfo.y + termsinfo.height + 40
        id: backhomeButton
        text: "Return to homepage"
        onClicked: {
           about_page.visible = false
           opening_page.visible = true
        }
    }
}

