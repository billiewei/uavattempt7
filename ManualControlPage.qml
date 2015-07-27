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
    color: "#FAFAFA"

    function writeFlightLog(s){
        consolerectangle.append(s)
    }

    TextField {
        id: currentbatterypercentage
        anchors.horizontalCenter: parent.horizontalCenter
        validator: IntValidator {bottom: 0; top: 100;}
        maximumLength: 3
        font.pixelSize: page.height*0.015
        font.letterSpacing: 2
        placeholderText: "BatteryTesting"
    }
    Text {
        id: manualcontroltitletxt
        text: "UAV Manual Control"
        anchors.top: parent.top
        anchors.topMargin: page.height*0.01
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.06
    }
    Label {
        id: batterytextlabel
        text: currentbatterypercentage.text + "%"
        y: manualcontroltitletxt.y
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.06
        font.letterSpacing: 2
        font.pixelSize: page.height*0.015
    }
    Rectangle {
        color: "#000"
        border.width: 0
        width: page.width*0.01
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.175
        y: manualcontroltitletxt.y + 2
        height: remainingbatteryoutline.height - 4
    }

    Rectangle {
        id: remainingbatteryoutline
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.18
        y: manualcontroltitletxt.y
        height: batterytextlabel.height
        width: remainingbatteryoutline.height*3
        border.width: 2
        border.color: "#000"
        radius: 3
    }

    Rectangle {
        id: remainingbatteryfill
        x: remainingbatteryoutline.x + 1
        y: remainingbatteryoutline.y + 2
        radius: 1
        height: batterytextlabel.height - 5
        width: (remainingbatteryoutline.width - 2)* (currentbatterypercentage.text/100)
        color: if (currentbatterypercentage.text >= 85) {"#65E01F"}
               else if (currentbatterypercentage.text >= 60) {"#FF790A"}
               else if (currentbatterypercentage.text < 60) {"#D60000"}
    }
    Rectangle {
        id: toprowrectangle
        color: "#E6E6E6"
        height: armingstatelabel.height + page.height*0.04
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.height*0.04
        width: page.width*0.9
        radius: 5
        Label {
            id: armingstatelabel
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.06
            anchors.top: parent.top
            anchors.topMargin: page.height*0.02
            text: if (armingstatetoggle.checked == false) {"Arming State:  OFF"}
                  else {"Arming State:  ON"}
        }
        Switch {
            id: armingstatetoggle
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.06
            anchors.top: parent.top
            anchors.topMargin: page.height*0.02
            checked: false
            onCheckedChanged: manual_control_handler.setArmed(checked)
        }
    }
    TextArea {
        id: consolerectangle
        y: toprowrectangle.y + toprowrectangle.height + page.height*0.02
        width: page.width*0.9
        height: page.height*0.15
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Here is the flight log... ..."
        backgroundVisible: true
        wrapMode: TextEdit.Wrap
        style: TextAreaStyle {
                textColor: "#00D604"
                selectedTextColor: "#fff"
                backgroundColor: "#000"
        }
    }
    Rectangle {
        id: controlsliders
        y: consolerectangle.y + consolerectangle.height + page.height*0.02
        width: page.width*0.9
        height: page.height*0.3
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#E6E6E6"
        radius: 5

        // X: Back-Forward
        Label {
            id:back_forward_label
            text: "Back-Forward"
            anchors.top: parent.top
            anchors.topMargin: page.height*0.03
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.06
            font.pixelSize: page.height*0.015
            font.letterSpacing: 2
        }
        Slider {
            id: x_slider
            anchors.left: parent.left
            anchors.leftMargin: back_forward_label.width + page.width*0.05
            anchors.top: parent.top
            anchors.topMargin: page.height*0.03
            tickmarksEnabled: false
            updateValueWhileDragging: true
            value: 0
            minimumValue : -1000
            maximumValue: 1000
            stepSize: 5.0
            style: SliderStyle {
                groove: Rectangle {
                    implicitWidth: controlsliders.width*0.6
                    implicitHeight: 8
                    color: "gray"
                    radius: 8
                }
            }
            onValueChanged: manual_control_handler.setX(value)

        }
        Text {
            text: x_slider.value
            anchors.top: parent.top
            anchors.topMargin: page.height*0.03
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.06
        }

        // Y: Left-Right
        Label {
            text: "Left-Right"
            anchors.top: parent.top
            anchors.topMargin: page.height*0.1
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.06
            font.pixelSize: page.height*0.015
            font.letterSpacing: 2
        }
        Slider {
            id: y_slider
            anchors.left: parent.left
            anchors.leftMargin: back_forward_label.width + page.width*0.05
            anchors.top: parent.top
            anchors.topMargin: page.height*0.1
            tickmarksEnabled: false
            updateValueWhileDragging: true
            value: 0
            minimumValue : -1000
            maximumValue: 1000
            stepSize: 5
            style: SliderStyle {
                groove: Rectangle {
                    implicitWidth: controlsliders.width*0.6
                    implicitHeight: 8
                    color: "gray"
                    radius: 8
                }
            }
            onValueChanged: manual_control_handler.setY(value)

        }
        Text {
            text: y_slider.value
            anchors.top: parent.top
            anchors.topMargin: page.height*0.1
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.06
        }

        // Z: Throttle
        Label {
            text: "Throttle"
            anchors.top: parent.top
            anchors.topMargin: page.height*0.17
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.06
            font.pixelSize: page.height*0.015
            font.letterSpacing: 2
        }
        Slider {
            id: z_slider
            anchors.left: parent.left
            anchors.leftMargin: back_forward_label.width + page.width*0.05
            anchors.top: parent.top
            anchors.topMargin: page.height*0.17
            tickmarksEnabled: false
            updateValueWhileDragging: true
            value: 0
            minimumValue : 0
            maximumValue: 1000
            stepSize: 10
            style: SliderStyle {
                groove: Rectangle {
                    implicitWidth: controlsliders.width*0.6
                    implicitHeight: 8
                    color: "gray"
                    radius: 8
                }
            }
            onValueChanged: manual_control_handler.setZ(value)

        }
        Text {
            text: z_slider.value
            anchors.top: parent.top
            anchors.topMargin: page.height*0.17
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.06
        }

        //R: yaw
        Label {
            text: "Yaw"
            anchors.top: parent.top
            anchors.topMargin: page.height*0.24
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.06
            font.pixelSize: page.height*0.015
            font.letterSpacing: 2
        }
        Slider {
            id: r_slider
            anchors.left: parent.left
            anchors.leftMargin: back_forward_label.width + page.width*0.05
            anchors.top: parent.top
            anchors.topMargin: page.height*0.24
            tickmarksEnabled: false
            updateValueWhileDragging: true
            value: 0
            minimumValue : -1000
            maximumValue: 1000
            stepSize: 5
            style: SliderStyle {
                groove: Rectangle {
                    implicitWidth: controlsliders.width*0.6
                    implicitHeight: 8
                    color: "gray"
                    radius: 8
                }
            }
            onValueChanged: manual_control_handler.setR(value)

        }
        Text {
            text: r_slider.value
            anchors.top: parent.top
            anchors.topMargin: page.height*0.24
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.06
        }

    }
    Rectangle {
        id: flightmode
        y: controlsliders.y + controlsliders.height + page.height*0.02
        width: page.width*0.9
        height: page.height*0.35
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#E6E6E6"
        radius: 5
        GroupBox {
            id: returnbox
            title: "Return"
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.03
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.03
            anchors.top: parent.top
            anchors.topMargin: page.height*0.01
            height: flightmode.height*0.2
            RowLayout {
                anchors.fill: parent
                spacing: 10
                ExclusiveGroup { id: returnGroup }
                RadioButton {
                    id: return_on_button
                    text: "Return On";
                    exclusiveGroup: returnGroup;
                    onCheckedChanged: manual_control_handler.setFlightMode(0)
                }
                RadioButton {
                    id: other_modes_button
                    text: "Other Modes";
                    exclusiveGroup: returnGroup;
                }
            }
        }
        GroupBox {
            id: modebox
            title: "Mode"
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.03
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.03
            y: returnbox.y + returnbox.height + page.height*0.01
            width: returnbox.width
            enabled: other_modes_button.checked
            height: flightmode.height*0.2
            RowLayout {
                anchors.fill: parent
                ExclusiveGroup { id: modeGroup }
                RadioButton {
                    text: "Manual";
                    exclusiveGroup: modeGroup;
                    onCheckedChanged: manual_control_handler.setFlightMode(1)
                }
                RadioButton {
                    id: assist_button;
                    text: "Assist";
                    exclusiveGroup: modeGroup;
                }
                RadioButton { id: auto_button; text: "Auto"; exclusiveGroup: modeGroup }
            }
        }
        GroupBox {
            id: assistbox
            title: "Assist"
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.03
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.03
            y: modebox.y + modebox.height + page.height*0.01
            width: returnbox.width
            enabled: assist_button.checked
            height: flightmode.height*0.2
            RowLayout {
                anchors.fill: parent
                ExclusiveGroup { id: assistGroup }
                RadioButton {
                    text: "Alt Control";
                    exclusiveGroup: assistGroup;
                    onCheckedChanged: manual_control_handler.setFlightMode(2)}
                RadioButton {
                    text: "Pos Control";
                    exclusiveGroup: assistGroup;
                    onCheckedChanged: manual_control_handler.setFlightMode(3)}
            }
        }
        GroupBox {
            id: autobox
            title: "Auto"
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.03
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.03
            y: assistbox.y + assistbox.height + page.height*0.01
            width: returnbox.width
            enabled: auto_button.checked
            height: flightmode.height*0.2
            RowLayout {
                anchors.fill: parent
                ExclusiveGroup { id: autoGroup }
                RadioButton {
                    text: "Mission";
                    exclusiveGroup: autoGroup;
                    onCheckedChanged: manual_control_handler.setFlightMode(4)
                }
                RadioButton {
                    text: "Loiter";
                    exclusiveGroup: autoGroup
                    onCheckedChanged: manual_control_handler.setFlightMode(5)
                }
            }
        }

    }
}

