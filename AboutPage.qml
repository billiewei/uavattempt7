import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true
    Image {
        id: aboutlogo
        visible: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.height*.1
        width: page.width*.2
        height: page.width*.2
        source: "qrc:/logo.png"
        asynchronous : true
    }
    Text {
        id: about
        anchors.horizontalCenter: parent.horizontalCenter
        y: aboutlogo.y + aboutlogo.height + page.height * 0.0625
        text: "ABOUT"
        font.family: "Avenir"
        font.letterSpacing: 2
        font.pixelSize: page.height * 0.025
    }
    Text {
        id: aboutinfo
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        y: about.y + about.height + page.height * 0.025
        width: page.width*0.8
        wrapMode: Text.WordWrap
        text: "This delivery system application was developed by the Harvard-HKUST Design Team 2015. To place an order, please click the buttons and follow the instructions given."
        font.family: "Avenir"
        font.letterSpacing: 2
        font.pixelSize: page.height * 0.02
    }
    Text {
        id: terms
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        y: aboutinfo.y + aboutinfo.height + page.height * 0.0375
        width: page.width*0.8
        wrapMode: Text.WordWrap
        text: "TERMS OF USE"
        font.family: "Avenir"
        font.letterSpacing: 2
        font.pixelSize: page.height * 0.025
    }
    Text {
        id: termsinfo
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        y: terms.y + terms.height + page.height * 0.025
        width: page.width*0.8
        wrapMode: Text.WordWrap
        text: "By using this service you are bound to the terms of use outlined below. This app is currently under development and we reserve the right to make any changes or deny service for any reason. Also, your credit card information is definitely not at all secure, and we apologize for that."
        font.family: "Avenir"
        font.letterSpacing: 2
        font.pixelSize: page.height * 0.02
    }
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        y: termsinfo.y + termsinfo.height + page.height * 0.05
        id: backhomeButton
        text: "Return to homepage"
        onClicked: {
           about_page.visible = false
           opening_page.visible = true
        }
    }
}

