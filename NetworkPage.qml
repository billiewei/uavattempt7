import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtPositioning 5.2
import QtLocation 5.3
import QtQuick.Particles 2.0
import QtQml 2.2
import HKUST 1.0

Rectangle {
    width: parent? parent.width : 400
    height: parent? parent.height : 900
    visible: true
    color: "#FFF"

    Button{
        id: home_button
        iconSource: "images/home.png"
        anchors.top: parent.top
        anchors.topMargin: page.height*0.02
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.025
        onClicked: {
            opening_page.visible = true
            manual_control_page.visible = false
        }
    }
    Button {
        y: home_button.y
        text: "Back to Manual Control"
        anchors.left: parent.left
        anchors.leftMargin: home_button.x + home_button.width + page.width*0.02
        onClicked: {
            manual_control_page.visible = true
        }
    }
    Rectangle {
        id: display_network
        anchors.top: parent.top
        anchors.topMargin: page.height*0.08
        color: "#F2F2F2"
        height: server_is_running_txt.height + page.height*0.08
        anchors.horizontalCenter: parent.horizontalCenter
        width: page.width*0.95
        radius: 5
        Label {
            id: server_is_running_txt
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.08
            anchors.top: parent.top
            anchors.topMargin: page.height*0.04
            text: "The server is running on: \n\n IP: " + ip_txt_field.text + "\n\n Port: " + port_txt_field.text
        }
    }
    Rectangle {
        id: network_entry
        color: "#F2F2F2"
        y: display_network.y + display_network.height + page.height*0.02
        height: ip_label.height + port_label.height + connect_group.height + page.height*0.15
        anchors.horizontalCenter: parent.horizontalCenter
        width: page.width*0.95
        radius: 5
        Label {
            id: ip_label
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.08
            anchors.top: parent.top
            anchors.topMargin: page.height*0.04
            text: "IP Address"
        }
        TextField {
            id: ip_txt_field
            y: ip_label.y
            anchors.left: parent.left
            anchors.leftMargin: ip_label.x + ip_label.width + page.width*0.05
            placeholderText: "Please enter in IP Address"
            width: parent.width*0.6
        }
        Label {
            id: port_label
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.08
            anchors.top: ip_label.bottom
            anchors.topMargin: page.height*0.04
            text: "Port"
        }
        TextField {
            id: port_txt_field
            y: port_label.y
            anchors.left: parent.left
            anchors.leftMargin: ip_label.x + ip_label.width + page.width*0.05
            placeholderText: "Please enter the port number"
            width: parent.width*0.6
        }
        RowLayout {
            id: connect_group
            x: ip_label.x
            y: port_txt_field.y + port_txt_field.height + page.height*0.04
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Button { text: "Connect"; isDefault: true }
            Button { text: "Disconnect" }
            Button { text: "Send request" }
        }


    }
    TextArea {
        y: network_entry.y + network_entry.height + page.height*0.02
        width: page.width*0.95
        height: page.height*0.2
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Status text should appear here... ..."
        backgroundVisible: true
        wrapMode: TextEdit.Wrap
        style: TextAreaStyle {
                textColor: "#FFB91F"
                selectedTextColor: "#fff"
                backgroundColor: "#3A3A50"
        }
    }
}

