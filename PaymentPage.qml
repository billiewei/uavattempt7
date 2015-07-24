import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Layouts 1.1

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true

    Image {
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.05
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.width*0.05
        width: page.width*.10
        height: page.width*.10
        source: "qrc:/logo.png"
        asynchronous : true
    }
    Text {
        id: paymentWindowtitle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.width*0.05
        text: "ENTER PAYMENT INFORMATION"
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    RowLayout {
        id: rowLayout1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.width*0.2
        width: paymentWindowtitle.width
        Column {
            id: column0
            anchors.left: parent.left
            CheckBox {
                id: checkBox1
                text: qsTr("AMEX")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked:
                    checkBox2.checked = false,
                    checkBox3.checked = false
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: page.width*0.1
                height: page.width*0.1
                fillMode: Image.PreserveAspectFit
                source: "amx.png"
            }
        }
        Column {
            id: column1
             anchors.horizontalCenter: parent.horizontalCenter
            CheckBox {
                id: checkBox2
                text: qsTr("Visa")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked:
                    checkBox1.checked = false,
                    checkBox3.checked = false
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: page.width*0.1
                height: page.width*0.1
                fillMode: Image.PreserveAspectFit
                source: "visa.png"
            }
        }
        Column {
            id: column2
            anchors.right: parent.right
            CheckBox {
                id: checkBox3
                text: qsTr("Discover")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked:
                    checkBox1.checked = false,
                    checkBox2.checked = false
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: page.width*0.1
                height: page.width*0.1
                fillMode: Image.PreserveAspectFit
                source: "discover.png"
            }
        }
    }
    TextField {
        id: cardnumber
        maximumLength: 19
        anchors.horizontalCenter: parent.horizontalCenter
        y: rowLayout1.y + rowLayout1.height + (page.height*0.03)
        width: page.width*0.9
        height: page.height*0.08
        placeholderText: "Card Number"
        echoMode: TextInput.Password
    }
    TextField {
        id: cvccode
        maximumLength: 4
        validator: IntValidator{bottom: 0; top: 9999;}
        anchors.horizontalCenter: parent.horizontalCenter
        echoMode: TextInput.Password
        y: cardnumber.y + cardnumber.height + (page.height*0.03)
        width: page.width*0.9
        height: page.height*0.08
        placeholderText: "Security Code"
    }
    TextField {
        id: cardholdername
        anchors.horizontalCenter: parent.horizontalCenter
        y: cvccode.y + cvccode.height + (page.height*0.03)
        width: page.width*0.9
        height: page.height*0.08
        placeholderText: qsTr("Cardholder's Name")
    }
    TextField {
        id: cardexpirationdate
        maximumLength: 7
        anchors.horizontalCenter: parent.horizontalCenter
        y: cardholdername.y + cardholdername.height + (page.height*0.03)
        width: page.width*0.9
        height: page.height*0.08
        placeholderText: "MM/YYYY" + "  " + "(Expiration Date)"
    }
    Button {
        id: submitpaymentinfoButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: backButton2.height + page.height*0.07
        text: "Submit and Review Order"
        onClicked:{
            payment_page.visible = false
            confirmation_page.visible = true
        }
    }
    Button {
        id: backButton2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.05
        width: submitpaymentinfoButton.width
        text: "Back"
        onClicked:{
            payment_page.visible = false
            confirmation_page.visible = true
        }
    }
}

