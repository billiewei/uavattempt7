import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.1
import QtPositioning 5.2
import QtLocation 5.3
import QtQuick.Dialogs 1.2

Dialog {
    contentItem: Rectangle {
        id: malfunctioncustrect
        implicitWidth: 400
        implicitHeight: 300
        Text {
            id: malfunction_notification_title
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            text: "ATTENTION!"
            font.family: "Avenir"
            font.letterSpacing: 2
            font.bold: true
            color: "#D60000"
        }
        Text {
            id: malfunctioning_notification
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            width: malfunctioncustrect.width * 0.8
            y: malfunction_notification_title.y + malfunction_notification_title.height + 50
            font.family: "Avenir"
            font.letterSpacing: 2
            wrapMode: Text.WordWrap
            text: "Due to unforseen circumstances, your order has been cancelled. You have been refunded the full amount. We apologize for any inconvenience."
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            text: "Okay"
        }
    }
}
