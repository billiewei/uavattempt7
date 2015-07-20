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
        id: order1_name
        text: "Vinh N."
        visible: false
    }
    Text {
        id: order1_street
        text: "Hong Fung House"
        visible: false
    }
    Text {
        id: order1_city
        text: "Hong Kong"
        visible: false
    }
    Text {
        id: order1_state
        text: ""
        visible: false
    }
    Text {
        id: order1_zip
        text: ""
        visible:false
    }
    Text {
        id: order1_totalprice
        text: "50.00"
        visible: false
    }
    Text {
        id: order1_deliveryfee
        text: "$4.00"
        visible: false
    }
    Text {
        id: order1_grandtotal
        text: (order1_totalprice.text*1.08) + 4
        visible: false
    }
    Text {
        id: order1_order
        text: "1 Fried Chicken\n5 Fish & Chips"
        visible: false
    }
    Text {
        id: order1_number
        text: "2"
        visible: false
    }
    Text {
        id: order1_country
        text: "Hong Kong"
        visible: false
    }

    Text {
        id: order1_time
        y: order1.y
        text: "08:23"
        visible: order1.visible
        anchors.right: parent.right
        anchors.rightMargin: page.width * 0.1
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: order1
        y: 150
        text: if (order1_click.text == "0") {order1_name.text + " \n\nItems: " + order1_number.text}
              else if (order1_click.text == "1") {
                  order1_name.text + "\n\n" +
                  order1_order.text +
                  "\n\nTotal Price: $" + order1_totalprice.text +
                  "\nDelivery Fee: " + order1_deliveryfee.text +
                  "\nGrand Total: $" + order1_grandtotal.text +
                  "\n\nPaid" +
                  "\n\nAddress: " + "\n" + order1_street.text +
                  "\n" + order1_city.text + ", " + order1_state.text + " " + order1_zip.text +
                  "\n" + order1_country.text
              }
        visible: if (order1_name.text == "") {false}
                 else {true}
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
            onClicked: if (vendor_handler.delivery == 0) {
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
            visible: if (vendor_handler.delivery == 0) {false}
                     else {true}
            text: "Deliver Order"
            anchors.leftMargin: 35
            onClicked: {
                pending_order_page.visible = false
                battery_status_page.visible = true
                backButton5.visible = false

                if (order1_click.text == "1") {
                     deliver.text = "1"
                }
                else if (order2_click.text == "1") {
                     deliver.text = "2"
                }
                else if (order3_click.text == "1"){
                     deliver.text = "3"
                }
                 else {console.debug("Please select order.")}
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
        y: if (order1_click.text == "0" ) {order1.y + order1.height + 20}
           else if (order1_click.text == "1") {deliverorder1_button.y + deliverorder1_button.height + 170}
        height: 1
        color: "#6E6E6E"
        border.color: "#6E6E6E"
        border.width: 1
        visible: if (order1_name.text == "") {false}
                 else {true}
    }

    Text {
        id: deliver
        visible: false
    }

    Text {
        id: order2_click
        text: "0"
        visible: false
    }
    Text {
        id: order2_name
        text: ""
        visible: false
    }
    Text {
        id: order2_street
        text: ""
        visible: false
    }
    Text {
        id: order2_city
        text: ""
        visible: false
    }
    Text {
        id: order2_state
        text: ""
        visible: false
    }
    Text {
        id: order2_zip
        text: ""
        visible:false
    }
    Text {
        id: order2_totalprice
        text: "100"
        visible: false
    }
    Text {
        id: order2_deliveryfee
        text: "$ 4.00"
        visible: false
    }
    Text {
        id: order2_grandtotal
        text: (order2_totalprice.text*1.08) + 4
        visible: false
    }
    Text {
        id: order2_order
        text: "60 Egg Tarts"
        visible: false
    }
    Text {
        id: order2_number
        text: "1"
        visible: false
    }
    Text {
        id: order2_country
        text: ""
        visible: false
    }
    Text {
        id: order2_time
        y: order2.y
        text: ""
        visible: order2.visible
        anchors.right: parent.right
        anchors.rightMargin: page.width * 0.1
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: order2
        y: order1_line.y + 25
        text: if (order2_click.text == "0") {order2_name.text + " \n\nItems: " + order2_number.text}
              else if (order2_click.text == "1"){
              order2_name.text + "\n\n" +
              order2_order.text +
              "\n\nTotal Price: $" + order2_totalprice.text +
              "\nDelivery Fee: " + order2_deliveryfee.text +
              "\nGrand Total: $" + order2_grandtotal.text +
              "\n\nPaid" +
              "\n\nAddress: " + "\n" + order2_street.text +
              "\n" + order2_city.text + ", " + order2_state.text + " " + order2_zip.text +
              "\n" + order2_country.text
              }
        visible: if (order2_name.text == ""){false}
                 else {true}
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
            onClicked: if (order2_click.text == "0") {
                           order2_click.text = "1"
                           order3_click.text = "0"
                           order1_click.text = "0"
                       }
                       else if (order2_click.text == "1") {
                           order3_click.text = "0"
                           order2_click.text = "0"
                           order1_click.text = "0"
                       }
        }
    }
    Rectangle {
        id: order2_line
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        y: if (order2_click.text == "0" ) {order2.y + order2.height + 20}
           else if (order2_click.text == "1") {deliverorder1_button.y + deliverorder1_button.height + 170}
        height: 1
        color: "#6E6E6E"
        border.width: 1
        border.color: "#6E6E6E"
        visible: if (order2_name.text == "") {false}
                 else {true}
    }

    Text {
        id: order3_click
        text: "0"
        visible: false
    }
    Text {
        id: order3_name
        text: ""
        visible: false
    }
    Text {
        id: order3_street
        text: ""
        visible: false
    }
    Text {
        id: order3_city
        text: ""
        visible: false
    }
    Text {
        id: order3_state
        text: ""
        visible: false
    }
    Text {
        id: order3_zip
        text: ""
        visible: false
    }
    Text {
        id: order3_totalprice
        text: ""
        visible: false
    }
    Text {
        id: order3_deliveryfee
        text: ""
        visible: false
    }
    Text {
        id: order3_grandtotal
        text: ""
        visible: false
    }
    Text {
        id: order3_order
        text: ""
        visible: false
    }
    Text {
        id: order3_number
        text: ""
        visible: false
    }
    Text {
        id: order3_country
        text: ""
        visible: false
    }
    Text {
        id: order3_time
        y: order3.y
        text: ""
        visible: order3.visible
        anchors.right: parent.right
        anchors.rightMargin: page.width * 0.1
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: order3
        y: order2_line.y + 25
        text: if (order3_click.text == "0") {order3_name.text + " \n\nItems: " + order3_number.text}
              else if (order3_click.text == "1"){
              order3_name.text + "\n\n" +
              order3_order.text +
              "\n\nTotal Price: $" + order3_totalprice.text +
              "\nDelivery Fee: " + order3_deliveryfee.text +
              "\nGrand Total: $" + order3_grandtotal.text +
              "\n\nPaid" +
              "\n\nAddress: " + "\n" + order3_street.text +
              "\n" + order3_city.text + ", " + order3_state.text + " " + order3_zip.text +
              "\n" + order3_country.text
              }
        visible: if (order3_name.text == ""){false}
                 else {true}
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
            onClicked: if (order3_click.text == "0") {
                           order3_click.text = "1"
                           order2_click.text = "0"
                           order1_click.text = "0"
                       }
                       else if (order3_click.text == "1") {
                           order3_click.text = "0"
                           order2_click.text = "0"
                           order1_click.text = "0"
                       }
        }
    }
    Rectangle {
        id: order3_line
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        y: if (order3_click.text == "0" ) {order3.y + order3.height + 20}
           else if (order3_click.text == "1") {deliverorder1_button.y + deliverorder1_button.height + 170}
        height: 1
        color: "#6E6E6E"
        border.width: 1
        border.color: "#6E6E6E"
        visible: if (order3_name.text == "") {false}
                 else {true}
    }

    Text {
        id: orderb_click
        text: "0"
        visible: false
    }
    Text {
        id: orderb_name
        text: ""
        visible: false
    }
    Text {
        id: orderb_street
        text: " "
        visible: false
    }
    Text {
        id: orderb_city
        text: ""
        visible: false
    }
    Text {
        id: orderb_statezip
        text: ""
        visible: false
    }
    Text {
        id: orderb_totalprice
        text: ""
        visible: false
    }
    Text {
        id: orderb_deliveryfee
        text: ""
        visible: false
    }
    Text {
        id: orderb_grandtotal
        text: ""
        visible: false
    }
    Text {
        id: orderb_order
        text: ""
        visible: false
    }
    Text {
        id: orderb_number
        text: ""
    }
    Button {
        id: backButton4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 240
        visible: if (order1_click.text == "1" | order2_click.text == "1" | order3_click.text == "1") {false}
                 else {true}
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
        visible: if (order1_click.text == "1" | order2_click.text == "1" | order3_click.text == "1") {false}
                 else {true}
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


