import QtQuick 2.0
import QtQuick.Controls 1.3

Rectangle {
    width: parent? parent.width : 500
    height: parent? parent.height : 800
    visible: true
    Image {
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: page.width * 0.05
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.width * 0.05
        width: page.width * 0.15
        height: page.width * 0.15
        source: "qrc:/logo.png"
        asynchronous : true
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50
        text: "PENDING ORDERS"
        font.family: "Avenir"
        font.letterSpacing: 2
    }

    //extract order 1 information
    Text {
        id: order1_click
        text: "0"
        visible: false
    }
    Text {
        id: order1_time
        y: order1.y
        text: vendor_handler.time1
        visible: order1.visible
        anchors.right: parent.right
        anchors.rightMargin: page.width * 0.1
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: order1
        y: 150
        text:
            if (vendor_handler.delivery == 1) {
                vendor_handler.name1 + "\n\n" +
                // will do it later
                // order1_order.text +
              "\n\nTotal Price: $" + (vendor_handler.price1).toFixed(2) +
              "\nDelivery Fee: $4.00" +
              "\nGrand Total: $" + (vendor_handler.price1 *1.08 + 4).toFixed(2) +
              "\n\nPaid" +
              "\n\nAddress: " + "\n" + vendor_handler.street1 +
              "\n" + vendor_handler.city1 + ", " + vendor_handler.state1 + " " + vendor_handler.zip1 +
              "\n" + vendor_handler.region1
              }
              else {vendor_handler.name1 + " \n\nItems: " } //+ order1_number.text
        visible: vendor_handler.valid1
        anchors.right: parent.right
        anchors.rightMargin: 35
        anchors.left: parent.left
        anchors.leftMargin: 35
        font.family: "Avenir"
        font.letterSpacing: 2
        z: 10
        MouseArea{
            id: order1_area
            anchors.fill: parent
            onClicked: if (vendor_handler.delivery != 1) {
                           vendor_handler.delivery = 1
                       }
                       else if (vendor_handler.delivery == 1) {
                            vendor_handler.delivery = 0
                       }
        }
        Button {
            id: deliverorder1_button
            y: if (vendor_handler.delivery == 1) {order1.y + order1.height - 100}
               else if (vendor_handler.delivery == 2) {order2.y + order2.height - 100}
               else if (vendor_handler.delivery == 3) {order3.y + order3.height - 100}
            visible: (vendor_handler.delivery != 0)
            text: "Deliver Order"
            anchors.leftMargin: 35
            onClicked: {
                pending_order_page.visible = false
                battery_status_page.visible = true
                //backButton5.visible = false
            }
        }
    }
    Rectangle {
        id: order1_beforeline
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        y: order1.y - 20
        height: 1
        color: "#6E6E6E"
        border.width: 1
        border.color: "#6E6E6E"
    }
    Rectangle {
        id: order1_line
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        y:  if (vendor_handler.delivery == 1) {deliverorder1_button.y + deliverorder1_button.height + 170}
            else {order1.y + order1.height + 20}
        height: 1
        color: "#6E6E6E"
        border.color: "#6E6E6E"
        border.width: 1
        visible: vendor_handler.valid1
    }
    Text {
        id: order2_time
        y: order2.y
        text: vendor_handler.time2
        visible: order2.visible
        anchors.right: parent.right
        anchors.rightMargin: page.width * 0.1
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: order2
        y: order1_line.y + 25
        text:
              if (vendor_handler.delivery == 2){
              vendor_handler.name2 + "\n\n" +
         //     order2_order.text +
              "\n\nTotal Price: $" + (vendor_handler.price2).toFixed(2) +
              "\nDelivery Fee: $4.00" +
              "\nGrand Total: $" + (vendor_handler.price2 * 1.08 + 4).toFixed(2) +
              "\n\nPaid" +
              "\n\nAddress: " + "\n" + vendor_handler.street2 +
              "\n" + vendor_handler.city2 + ", " + vendor_handler.state2 + " " + vendor_handler.zip2 +
              "\n" + vendor_handler.region2
              }
              else {vendor_handler.name2 + " \n\nItems: "} // + order2_number.text}
        visible: vendor_handler.valid2
        anchors.right: parent.right
        anchors.rightMargin: 35
        anchors.left: parent.left
        anchors.leftMargin: 35
        font.family: "Avenir"
        font.letterSpacing: 2
        z: 10
        MouseArea {
            id: order2_area
            anchors.fill: parent
            onClicked: if (vendor_handler.delivery != 2) {
                            vendor_handler.delivery = 2
                       }
                       else if (vendor_handler.delivery == 2) {
                            vendor_handler.delivery = 0
                       }
        }
    }
    Rectangle {
        id: order2_line
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        y: if (vendor_handler.delivery == 2) {deliverorder1_button.y + deliverorder1_button.height + 170}
           else {order2.y + order2.height + 20}
        height: 1
        color: "#6E6E6E"
        border.width: 1
        border.color: "#6E6E6E"
        visible: vendor_handler.valid2
    }
    Text {
        id: order3_time
        y: order3.y
        text: vendor_handler.time3
        visible: order3.visible
        anchors.right: parent.right
        anchors.rightMargin: page.width * 0.1
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: order3
        y: order2_line.y + 25
        text: if (vendor_handler.delivery == 3){
              vendor_handler.name3 + "\n\n" +
         //     order3_order.text +
              "\n\nTotal Price: $" + vendor_handler.price3 +
              "\nDelivery Fee: $4.00" +
              "\nGrand Total: $" + (vendor_handler.price3 * 1.08 + 4) +
              "\n\nPaid" +
              "\n\nAddress: " + "\n" + vendor_handler.street3 +
              "\n" + vendor_handler.city3 + ", " + vendor_handler.state3 + " " + vendor_handler.zip3 +
              "\n" + vendor_handler.region3
              }
              else{vendor_handler.name3 + " \n\nItems: "}// + order3_number.text}

        visible: vendor_handler.valid3
        anchors.right: parent.right
        anchors.rightMargin: 35
        anchors.left: parent.left
        anchors.leftMargin: 35
        font.family: "Avenir"
        font.letterSpacing: 2
        z: 10

        MouseArea{
            id: order3_area
            anchors.fill: parent
            onClicked: if (vendor_handler.delivery != 3) {
                            vendor_handler.delivery = 3
                       }
                       else if (vendor_handler.delivery == 3) {
                            vendor_handler.delivery = 0
                       }
        }
    }
    Rectangle {
        id: order3_line
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        y: if (vendor_handler.delivery == 3) {deliverorder1_button.y + deliverorder1_button.height + 170}
           else {order3.y + order3.height + 20}
        height: 1
        color: "#6E6E6E"
        border.width: 1
        border.color: "#6E6E6E"
        visible: vendor_handler.valid3
    }
    Button {
        id: backButton4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 240
        visible: (vendor_handler.delivery == 0)
        text: "Return to homepage"
        z:0
        onClicked:{
            pending_order_page.visible = false
            opening_page.visible = true
        }
    }
    Button {
       id: viewbatterystatus_button
       anchors.horizontalCenter: parent.horizontalCenter
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 60
        y: backButton4.y + backButton4.height + page.height*0.05
        width: backButton4.width
        text: "View Battery Status"
        visible: (vendor_handler.delivery == 0)

        onClicked: {
            pending_order_page.visible = false
            battery_status_page.visible = true
            proceed_button.visible = false
            cancel_button.visible = false
            backButton5.visible = true
            batterydenialrectangle.visible = false
        }
    }
}


