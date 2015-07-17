import QtQuick 2.0
import QtQuick.Controls 1.3

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true
    Image {
        id: logowarn
        visible: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.height*.25
        width: parent? parent.width*.4 : 200
        height: parent? parent.width*.4 : 200
        source: "qrc:/logo.png"
        asynchronous : true
    }
    Text {
        id: malfunctioningpagetitle
        anchors.horizontalCenter: parent.horizontalCenter
        y: logowarn.y + logowarn.height + page.height*.05
        text: "WARNING!"
        font.family: "Avenir"
        font.letterSpacing: 2
        font.bold: true
        color: "#D60000"
    }
    Text {
        id: malfunctioning_warning
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        width: page.width
        y: malfunctioningpagetitle.y + malfunctioningpagetitle.height + page.height*.05
        font.family: "Avenir"
        font.letterSpacing: 2
        wrapMode: Text.WordWrap
        text: "The propeller is malfunctioning or the drone does not have enough power to deliver/return. \n\n Issue is dire. \n \n Please land the drone and retrieve it immediately."
    }
    Button {
        id: malfunctioning_landing
        anchors.horizontalCenter: parent.horizontalCenter
        y: malfunctioning_warning.y + malfunctioning_warning.height + page.width*.12
        width: page.width*.5
        text: "Proceed"
        onClicked:
            page.state = "dronelocationwindowstate"
    }
}

