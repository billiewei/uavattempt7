import QtQuick 2.0
import QtQuick.Controls 1.3

// Customers Enter Address
Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true
    Image {
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: page.width*.08
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.width*.08
        width: page.width*.15
        height: page.width*.15
        source: "qrc:/logo.png"
        asynchronous : true
    }
    Text {
        id: checkoutaddressWindowtitle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.height*.05
        width: page.width
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        text: "PLEASE ENTER YOUR SHIPPING INFORMATION"
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    TextField {
        id: currentcustomername
        maximumLength: 40
        anchors.horizontalCenter: parent.horizontalCenter
        y: checkoutaddressWindowtitle.y + page.height*.1 // previous 0.15
        width: page.width*0.9
        height: page.height*.065
        placeholderText: qsTr("Name")
    }
    TextField {
        id: currentcustomerstreet
        maximumLength: 100
        anchors.horizontalCenter: parent.horizontalCenter
        y: currentcustomername.y + page.height*.08 //0.12
        width: page.width*.9
        height: page.height*.065    //0.1
        placeholderText: qsTr("Street")
    }
    TextField {
        id: currentcustomercity
        anchors.horizontalCenter: parent.horizontalCenter
        y: currentcustomerstreet.y + page.height*.08 //0.12
        width: page.width*.9
        height: page.height*.065      //0.1
        placeholderText: qsTr("City")
    }
    TextField {
        id: currentcustomerstate
        anchors.left: currentcustomercity.left
        y: currentcustomercity.y + page.height*.08  //0.12
        width: (page.width) * 0.45
        height: page.height*.065     //0.1
        placeholderText: qsTr("State")
    }
    TextField {
        id: currentcustomerzipcode
        maximumLength: 5
        anchors.right: currentcustomercity.right
        y: currentcustomercity.y + page.height*.08  //0.12
        width: (page.width) * 0.45
        height: page.height*.065    //0.1
        validator: IntValidator {bottom: 0; top: 99999;}
        placeholderText: qsTr("Zip Code")
    }
    TextField {
        id: currentcustomercountry
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "Country"
        y: currentcustomerzipcode.y + page.height*.08  //0.12
        width: page.width*.9
        height: page.height*.065    //0.1
    }
    TextField {
        id: currentcustomeremail
        anchors.horizontalCenter: parent.horizontalCenter
        y: currentcustomercountry.y + page.height*.08   //0.12
        width: page.width*.9
        height: page.height*.065   //0.1
        placeholderText: qsTr("Email")
    }
    TextField {
        id: currentcustomerphone
        anchors.horizontalCenter: parent.horizontalCenter
        maximumLength: 14
        y: currentcustomeremail.y + page.height*.08   //0.12
        width: page.width*.9
        height: page.height*.065   //0.1
        placeholderText: "X-XXX-XXX-XXXX (Phone Number)"
    }
    Button {
        id: submitaddressButton
        anchors.horizontalCenter: parent.horizontalCenter
        y: currentcustomerphone.y + page.height*.08 //0.1   //0.12
        z: addressdenialrectangle.z + 3
        width:  page.width*0.5
        height: page.height * 0.065
        text: "Submit"
        visible:
            if (currentcustomerstreet.text == "" || currentcustomercity.text == "" || currentcustomerstate.text == "" || currentcustomerzipcode.text == "" || currentcustomeremail.text == "" || currentcustomername.text == "") {false}
            else {true}
        onClicked:{
            address_page.visible = false
            payment_page.visible = true
            address_page_handler.name = currentcustomername.text
            address_page_handler.street = currentcustomerstreet.text
            address_page_handler.city = currentcustomercity.text
            address_page_handler.state = currentcustomerstate.text
            address_page_handler.region = currentcustomercountry.text
            address_page_handler.zip = 1*currentcustomerzipcode.text
            address_page_handler.phone = 1*currentcustomerphone.text
            //this will trigger the Geocode model
                    //need to be implemented
            customer_track_page.geocodeModel.query = customer_track_page.geocodeAddress
            customer_track_page.geocodeModel.update()
        }
    }
    Rectangle {
        id: addressdenialrectangle
        anchors.horizontalCenter: parent.horizontalCenter
        y: currentcustomerphone.y + page.height*.08  //0.12
        z: emailrectangle.z + 3
        width:  page.width * 0.5
        height: page.height *.065
        color: "#D60000"
        radius: 5
        Text {
            color: "white"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Address incomplete."
        }
        visible:
            if (namedenialrectangle.visible == true || emailrectangle.visible == true) {false}
            else if (currentcustomerstreet.text == "" || currentcustomercity.text == "" || currentcustomerstate.text == "" || currentcustomerzipcode.text == "" || currentcustomercountry.text == "") {true}
            else {false}
    }
    Rectangle {
        id: emailrectangle
        anchors.horizontalCenter: parent.horizontalCenter
        y: currentcustomerphone.y + page.height*.08
        width: page.width*.5
        height: page.height*.065
        color: "#D60000"
        radius: 5
        Text {
            color: "white"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Please enter email"
        }
        visible:
            if (currentcustomeremail.text != "") {false}
            else if (addressdenialrectangle.visible == true || namedenialrectangle.visible == true) {false}
            else {true}
    }
    Rectangle {
        id: namedenialrectangle
        anchors.horizontalCenter: parent.horizontalCenter
        y: currentcustomerphone.y + page.height*.08
        width: page.width*.5
        height: page.height*.065
        color: "#D60000"
        radius: 5
        Text {
            color: "white"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Please enter name."
        }
        visible:
            if (currentcustomername.text != "") {false}
            else if (addressdenialrectangle.visible == true || emailrectangle.visible == true) {false}
            else {true}
    }
    Button {
        id: backButton3
        anchors.horizontalCenter: parent.horizontalCenter
        y: submitaddressButton.y + page.height*.08
        width: page.width * 0.5
        height: page.height * 0.065
        text: "Back"
        onClicked:{
            address_page.visible = false
            menu_page.visible = true
        }
    }
}
