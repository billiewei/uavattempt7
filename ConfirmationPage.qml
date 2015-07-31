import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

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
        id: orderconfirmationWindowtitle
        text: "PLEASE CONFIRM\nORDER INFORMATION"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.height*.05
        width: page.width
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        font.family: "Avenir"
        font.letterSpacing: 2
    }
    Text {
        id: addressdisplaytext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        anchors.top: parent.top
        anchors.topMargin: orderconfirmationWindowtitle.height + page.height*0.1
        text: "ADDRESS"
        font.family: "Avenir"
        font.pixelSize: page.height * 0.028
        font.letterSpacing: 2
    }
    Button {
        id: editaddressButton
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.1
        anchors.top: parent.top
        anchors.topMargin: orderconfirmationWindowtitle.height + page.height*0.11
        text: "Edit"
        onClicked:{
            confirmation_page.visible = false
            address_page.visible = true
        }
    }
    Text {
        id: displayaddress
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        y: addressdisplaytext.y + addressdisplaytext.height + page.height*0.02
        text: address_page_handler.name + '<br>' + address_page_handler.street + '<br>' +
              address_page_handler.city  + ", " + address_page_handler.state + "  "+ address_page_handler.zip
        font.family: "Avenir"
        font.pixelSize: page.height * 0.02
        font.letterSpacing: 2
    }
    Text {
        id: itemsordereddisplaytext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        y: displayaddress.y + displayaddress.height + page.height*0.03
        text: "ITEMS ORDERED"
        font.family: "Avenir"
        font.pixelSize: page.height * 0.028
        font.letterSpacing: 2
    }
    Text {
        id: item1confirmtext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        height: if (menu_page_handler.num1 == 0) {itemsordereddisplaytext.height}
        y: if (menu_page_handler.num1 == 0) {itemsordereddisplaytext.y}
           else {itemsordereddisplaytext.y + page.height*.03}
        text: if (menu_page_handler.num1 == 0) {""}
              else {"Egg Tart" + '<br>' + "Unit Price: $ 2.15" + '<br>' + "Quantity: "+ menu_page_handler.num1}
        font.family: "Avenir"
        font.pixelSize: page.height * 0.02
        font.letterSpacing: 2
    }
    Text {
        id: item2confirmtext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        height: if (menu_page_handler.num2 == 0) {0}
        y: if (item1confirmtext.text == "") {itemsordereddisplaytext.y + page.height*.05}
           else {item1confirmtext.y + item1confirmtext.height + page.height*.03}
        text: if (menu_page_handler.num2 == 0) {""}
              else {"Pineapple Bun" + '<br>' + "Unit Price: $ 2.20" + '<br>' + "Quantity: "+ menu_page_handler.num2}
        font.family: "Avenir"
        font.pixelSize: page.height * 0.02
        font.letterSpacing: 2
    }
    Text {
        id: item3confirmtext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        height: if (menu_page_handler.num3 == 0) {0}
        y: if (item2confirmtext.text == "") {item1confirmtext.y + item1confirmtext.height + page.height*.05}
           else {item2confirmtext.y + item2confirmtext.height + page.height*.03}
        text: if (menu_page_handler.num3 == 0) {""}
              else {"Iced Coffee" + '<br>' + "Unit Price: $ 5.00" + '<br>' + "Quantity: "+ menu_page_handler.num3}
        font.family: "Avenir"
        font.pixelSize: page.height * 0.02
        font.letterSpacing: 2
    }
    Text {
        id: item4confirmtext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        height: if (menu_page_handler.num4 == 0) {0}
        y: if (item3confirmtext.text == "") {item2confirmtext.y + item2confirmtext.height + page.height*.05}
           else {item3confirmtext.y + item3confirmtext.height + page.height*.03}
        text: if (menu_page_handler.num4 == 0) {""}
              else {"Milk Tea" + '<br>' + "Unit Price: $ 3.00" + itemprice4.text + '<br>' + "Quantity: "+ menu_page_handler.num4}
        font.family: "Avenir"
        font.pixelSize: page.height * 0.02
        font.letterSpacing: 2
    }
    Button {
        id: editorderButton
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.1
        y: itemsordereddisplaytext.y + page.height * 0.02
        text: "Edit"
        onClicked:{
            confirmation_page.visible = false
            menu_page.visible = true
        }
    }
    // Totals
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.22
        text: "TOTAL:"
        font.family: "Avenir"
        font.pixelSize: page.height * 0.024
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.22
        text: "$" + menu_page_handler.total.toFixed(2)
        wrapMode: Text.WordWrap
        font.family: "Avenir"
        font.pixelSize: page.height * 0.024
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.19
        width: 200
        text: "TAX:"
        wrapMode: Text.WordWrap
        font.family: "Avenir"
        font.pixelSize: page.height * 0.024
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.19
        width: 200
        text: "$" + (menu_page_handler.total*0.18).toFixed(2)
        wrapMode: Text.WordWrap
        font.family: "Avenir"
        font.pixelSize: page.height * 0.024
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.16
        width: 200
        text: "SHIPPING:"
        wrapMode: Text.WordWrap
        font.family: "Avenir"
        font.pixelSize: page.height*0.024
        font.letterSpacing: 2
    }
    Text {
        id: shippingfee
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.16
        text: if (menu_page_handler.weight > 0) {"$" + "4.00"} else {"$" + "0.00"}
        font.family: "Avenir"
        font.pixelSize: page.height*0.024
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.13
        width: 200
        text: "GRAND TOTAL:"
        font.family: "Avenir"
        font.pixelSize: page.height*0.024
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.13
        width: 200
        text: if (menu_page_handler.weight > 0) {"$" + (menu_page_handler.total*1.08 + 4.0).toFixed(2)} else {"$0.00"}
        font.family: "Avenir"
        font.pixelSize: page.height*0.024
        font.letterSpacing: 2
    }
    Button {
        id: orderconfirmationButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.03
        text: "Place order now"
        onClicked: {
            confirmation_page.visible = false
            customer_track_page.visible = true

            // Sends information to the vendor side of the application
            if (!vendor_handler.valid1) {
                vendor_handler.name1 = address_page_handler.name
                vendor_handler.street1 = address_page_handler.street
                vendor_handler.city1 = address_page_handler.city
                // we can add this later
                // order1_number.text = (quantity1.text * 1) + (quantity2.text * 1) + (quantity3.text * 1) + (quantity4.text * 1)
                vendor_handler.state1 = address_page_handler.state
                vendor_handler.zip1 = address_page_handler.zip
                vendor_handler.region1 = address_page_handler.region
                vendor_handler.order1 = ""
                if (menu_page_handler.num1 > 0)
                    vendor_handler.order1 += menu_page_handler.num1 + "\t" + "Egg Tart\n";
                if (menu_page_handler.num2 > 0)
                    vendor_handler.order1 += menu_page_handler.num2 + "\t" + "Pineapple Bun\n";
                if (menu_page_handler.num3 > 0)
                    vendor_handler.order1 += menu_page_handler.num3 + "\t" + "Iced Coffee\n";
                if (menu_page_handler.num4 > 0)
                    vendor_handler.order1 += menu_page_handler.num4 + "\t " + "Milk Tea\n";
                vendor_handler.price1 = menu_page_handler.total;
                vendor_handler.time1 = Qt.formatTime(new Date(),"hh:mm");
                vendor_handler.valid1 = true
            }
            else if (!vendor_handler.valid2) {
                vendor_handler.name2 = address_page_handler.name
                vendor_handler.street2 = address_page_handler.street
                vendor_handler.city2 = address_page_handler.city
                vendor_handler.state2 = address_page_handler.state
                vendor_handler.zip2 = address_page_handler.zip
                vendor_handler.region2 = address_page_handler.region
                vendor_handler.order2 = ""
                if (menu_page_handler.num1 > 0)
                    vendor_handler.order2 += menu_page_handler.num1 + "\t" + "Egg Tart\n";
                if (menu_page_handler.num2 > 0)
                    vendor_handler.order2 += menu_page_handler.num2 + "\t" + "Pineapple Bun\n";
                if (menu_page_handler.num3 > 0)
                    vendor_handler.order2 += menu_page_handler.num3 + "\t" + "Iced Coffee\n";
                if (menu_page_handler.num4 > 0)
                    vendor_handler.order2 += menu_page_handler.num4 +  "\t " + "Milk Tea\n";
               vendor_handler.price2 = menu_page_handler.total;
               vendor_handler.time2 = Qt.formatTime(new Date(),"hh:mm")
               vendor_handler.valid2 = true
           }
           else if (!vendor_handler.valid3){
               vendor_handler.name3 = address_page_handler.name
               vendor_handler.street3 = address_page_handler.street
               vendor_handler.city3 = address_page_handler.city
               vendor_handler.state3 = address_page_handler.state
               vendor_handler.zip3 = address_page_handler.zip
               vendor_handler.region3 = address_page_handler.region
               vendor_handler.order3 = ""
               if (menu_page_handler.num1 > 0)
                   vendor_handler.order3 += menu_page_handler.num1 + "\t" + "Egg Tart\n";
               if (menu_page_handler.num2 > 0)
                   vendor_handler.order3 += menu_page_handler.num2 + "\t" + "Pineapple Bun\n";
               if (menu_page_handler.num3 > 0)
                   vendor_handler.order3 += menu_page_handler.num3 + "\t" + "Iced Coffee\n";
               if (menu_page_handler.num4 > 0)
                   vendor_handler.order3 += menu_page_handler.num4 +  "\t " + "Milk Tea\n";
               vendor_handler.price3 = menu_page_handler.total;
               vendor_handler.time3 = Qt.formatTime(new Date(),"hh:mm")
               vendor_handler.valid3 = true
          }
        }
    }
}

