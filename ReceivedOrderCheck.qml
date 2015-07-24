import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.1
import QtPositioning 5.2
import QtLocation 5.3
import QtQuick.Dialogs 1.2

Dialog {
    id: receivedordercheckdialog
    contentItem: Rectangle {
        implicitWidth: 500
        implicitHeight: 300
        Text {
            text: "Have you recieved your order?"
            id: checkmessage
            color: "#000"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: receivedordercheckdialog.height * 0.05
            font.family: "Avenir"
            font.pixelSize: 25
            font.letterSpacing: 2
        }
        Button {
            id: yesreceivedorder_button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: receivedordercheckdialog.height * 0.15
            text: "Yes"
            onClicked:
                receivedordercheckdialog.visible = false
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: receivedordercheckdialog.height * 0.03
            width: yesreceivedorder_button.width
            text: "No"
            onClicked:
                receivedordercheckdialog.visible = false

        }
    }
}

