import QtQuick 2.0
import QtQuick.Controls 1.3

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
        id: availableitemswindowtitle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.height*0.03
        text: "AVAILABLE ITEMS"
        font.family: "Avenir"
        font.letterSpacing: 2
        font.pixelSize: 30
    }
    Rectangle {
        id: item1
        anchors.horizontalCenter: parent.horizontalCenter
        y: availableitemswindowtitle.y + availableitemswindowtitle.height + page.height*0.03
        anchors.left: parent.left
        anchors.leftMargin: 0
 //       anchors.right: parent.right
 //       anchors.rightMargin: 0
        height: parent.height*0.1
        border.color: "#ADADAD"
        border.width: 0.5
        TextField {
            id: quantity1
            anchors.right: parent.right
            anchors.rightMargin: parent? parent.width*0.05 : 25
            anchors.verticalCenter: parent.verticalCenter
            width: page.width*0.15
            height: page.height*0.07
            validator: IntValidator {bottom: 0; top: 9;}
            placeholderText: "0"
        }
        Text {
            id: itemname1
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "Water Balloon"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: itemweight1
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: "100"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            x: itemweight1.x + itemweight1.width + (page.width*0.02)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: "g"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.4
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "$"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: itemprice1
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.43
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "2.15"
            font.family: "Avenir"
            font.pixelSize: 25
        }
    }
    Rectangle {
        id: item2
        anchors.horizontalCenter: parent.horizontalCenter
        y: item1.y + item1.height
        anchors.left: parent.left
        anchors.leftMargin: 0
 //       anchors.right: parent.right
 //       anchors.rightMargin: 0
        height: page.height*0.1
        TextField {
            id: quantity2
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.05
            anchors.verticalCenter: parent.verticalCenter
            width: page.width*0.15
            height: page.height*0.07
            validator: IntValidator {bottom: 0; top: 9;}
            placeholderText: "0"
        }
        Text {
            id: itemname2
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "Okra"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: itemweight2
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: "100"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            x: itemweight2.x + itemweight2.width + (page.width*0.02)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: "g"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.4
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "$"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: itemprice2
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.43
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "2.20"
            font.family: "Avenir"
            font.pixelSize: 25
        }
    }
    Rectangle {
        id: item3
        anchors.horizontalCenter: parent.horizontalCenter
        y: item2.y + item2.height
        anchors.left: parent.left
        anchors.leftMargin: 0
    //    anchors.right: parent.right
    //    anchors.rightMargin: 0
        height: page.height*0.1
        border.color: "#ADADAD"
        border.width: 0.5
        TextField {
            id: quantity3
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.05
            anchors.verticalCenter: parent.verticalCenter
            width: page.width*0.15
            height: page.height*0.07
            validator: IntValidator {bottom: 0; top: 9;}
            placeholderText: "0"
        }
        Text {
            id: itemname3
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "Iced Coffee"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: itemweight3
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: "200"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            x: itemweight3.x + itemweight3.width + (page.width*0.02)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: "g"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.4
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "$"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: itemprice3
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.43
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "5.00"
            font.family: "Avenir"
            font.pixelSize: 25
        }
    }
    Rectangle {
        id: item4
        anchors.horizontalCenter: parent.horizontalCenter
        y: item3.y + item3.height
        anchors.left: parent.left
        anchors.leftMargin: 0
  //      anchors.right: parent.right
  //      anchors.rightMargin: 0
        height: page.height*0.1
        TextField {
            id: quantity4
            anchors.right: parent.right
            anchors.rightMargin: page.width*0.05
            anchors.verticalCenter: parent.verticalCenter
            width: page.width*0.15
            height: page.height*0.07
            validator: IntValidator {bottom: 0; top: 9;}
            placeholderText: "0"
        }
        Text {
            id: itemname4
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "Mangoes"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: itemweight4
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: "100"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            x: itemweight4.x + itemweight4.width + (page.width*0.02)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: "g"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.4
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "$"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: itemprice4
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.43
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "3.00"
            font.family: "Avenir"
            font.pixelSize: 25
        }
    }
    Rectangle {
        id: totalbox
        anchors.horizontalCenter: parent.horizontalCenter
        y: item4.y + item4.height
        anchors.left: parent.left
        anchors.leftMargin: 0
 //       anchors.right: parent.right
 //       anchors.rightMargin: 0
        height: page.height*0.1
        border.color: "#ADADAD"
        border.width: 0.5
        Text {
            id: totalweighttext
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.25
            text: "Total Weight:"
            font.family: "Avenir"
            style: Text.Normal
            font.pixelSize: 25
        }
        Text {
            id: totalpricetext
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.05
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.25
            text: "Total Price:"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: maxweighttext
            x: totalweight.x + totalweight.width + page.width*0.02
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.22
            text: "/ 400 g"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: dollarsign5
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.4
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: "$"
            font.family: "Avenir"
            font.pixelSize: 25
        }
        Text {
            id: totalweight
            color:
                if (totalweight.text > 400) {"#D60000"}
                else {"black"}
            font.family: "Avenir"
            font.pixelSize: 25
            anchors.left: parent.left
            anchors.leftMargin: page.width*0.4
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.22
            text: (quantity1.text*itemweight1.text) + (quantity2.text*itemweight2.text) + (quantity3.text*itemweight3.text) + (quantity4.text*itemweight4.text)
        }
        Text {
            id: totalprice
            font.family: "Avenir"
            font.pixelSize: 25
            x: dollarsign5.x + dollarsign5.width + page.width*0.02
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.22
            text: (quantity1.text*itemprice1.text) + (quantity2.text*itemprice2.text) + (quantity3.text*itemprice3.text) + (quantity4.text*itemprice4.text)
        }
    }
    Button {
        id: checkoutButton
        width: backButton1.width
        height: page.height * 0.08
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: (page.height*0.05) + (clearButton.height) + ((page.height*0.03)*2) + (backButton1.height)
        text: "Checkout"
        visible:
            if (totalweight.text > 400 || totalweight.text == 0) {false}
            else {true}
        onClicked: {
            menu_page.visible = false
            address_page.visible = true
            menu_page_handler.num1 = 1* quantity1.text
            menu_page_handler.num2 = 1* quantity2.text
            menu_page_handler.num3 = 1* quantity3.text
            menu_page_handler.num4 = 1* quantity4.text
        }
    }
    Rectangle {
        id: checkoutdenialrectangle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: (page.height*0.05) + (clearButton.height) + ((page.height*0.03)*2) + (backButton1.height)
        height: checkoutButton.height
        width: backButton1.width
        color: "#D60000"
        radius: 5
        Text {
            color: "white"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Please remove some items."
        }
        visible:
            if (totalweight.text > 400) {true}
            else {false}
    }
    Rectangle {
        id: checkoutdenialrectangle2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: (page.height*0.05) + (clearButton.height) + ((page.height*0.03)*2) + (backButton1.height)
        height: checkoutButton.height
        width: backButton1.width
        color: "#D60000"
        radius: 5
        Text {
            color: "white"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "You have no items in your cart."
        }
        visible:
            if (totalweight.text == 0) {true}
            else {false}
    }
    Button {
        id: backButton1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: (page.height*0.05) + (clearButton.height) + (page.height*0.03)
        text: "Return to homepage"
        height: checkoutButton.height
        onClicked:{
            menu_page.visible = false
            opening_page.visible = true
        }
    }
    Button {
        id: clearButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.05
        width: backButton1.width
        height: checkoutButton.height
        text: "Clear all entries"
        onClicked:
            totalweight.text = 0
            ,quantity1.text = 0
            ,quantity2.text = 0
            ,quantity3.text = 0
            ,quantity4.text = 0

    }
}
