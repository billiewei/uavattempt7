import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.1
import QtPositioning 5.2
import QtLocation 5.3
import QtQuick.Dialogs 1.2

Dialog {
    id: droneapproachingmessagedialog
    contentItem: Rectangle {
        implicitWidth: 400
        implicitHeight: 200
        Text {
            text: "Your order is approaching. Please wait outside to retrieve your items. For your safety, plese keep all parts of your body away from the drone."
            color: "#000"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            anchors.top: parent.top
            width: 360
            anchors.topMargin: 40
            font.family: "Avenir"
            font.letterSpacing: 2
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            text: "Okay"
            onClicked:
                droneapproachingmessagedialog.visible = false
        }
    }
}

