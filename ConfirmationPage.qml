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
        id: orderconfirmationWindowtitle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: page.width*0.1
        text: "PLEASE CONFIRM ORDER INFORMATION"
        font.family: "Avenir"
        font.pixelSize: 30
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
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Button {
        id: editaddressButton
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.1
        anchors.top: parent.top
        anchors.topMargin: orderconfirmationWindowtitle.height + page.height*0.1
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
        y: addressdisplaytext.y + addressdisplaytext.height + page.height*0.03
        text: address_page_handler.name + '<br>' + address_page_handler.street + '<br>' +
              address_page_handler.city  + ", " + address_page_handler.state + "  "+ address_page_handler.zip
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Text {
        id: itemsordereddisplaytext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        y: displayaddress.y + displayaddress.height + page.height*0.1
        text: "ITEMS ORDERED"
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Text {
        id: item1confirmtext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        height: if (menu_page_handler.num1 == 0) {itemsordereddisplaytext.height}
        y: if (menu_page_handler.num1 == 0) {itemsordereddisplaytext.y}
           else {itemsordereddisplaytext.y + page.height*.05}
        text: if (menu_page_handler.num1 == 0) {""}
              else {"Water Balloon" + '<br>' + "Unit Price: $ 2.15" + '<br>' + "Quantity: "+ menu_page_handler.num1}
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Text {
        id: item2confirmtext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        height: if (menu_page_handler.num2 == 0) {0}
        y: if (item1confirmtext.text == "") {itemsordereddisplaytext.y + 20}
           else {item1confirmtext.y + item1confirmtext.height + 20}
        text: if (menu_page_handler.num2 == 0) {""}
              else {"Okra" + '<br>' + "Unit Price: $ 2.20" + '<br>' + "Quantity: "+ menu_page_handler.num2}
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Text {
        id: item3confirmtext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        height: if (menu_page_handler.num3 == 0) {0}
        y: if (item2confirmtext.text == "") {item1confirmtext.y + item1confirmtext.height + 20}
           else {item2confirmtext.y + item2confirmtext.height + 20}
        text: if (menu_page_handler.num3 == 0) {""}
              else {"Iced Coffee" + '<br>' + "Unit Price: $ 5.00" + '<br>' + "Quantity: "+ menu_page_handler.num3}
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Text {
        id: item4confirmtext
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        height: if (menu_page_handler.num4 == 0) {0}
        y: if (item3confirmtext.text == "") {item2confirmtext.y + item2confirmtext.height + 20}
           else {item3confirmtext.y + item3confirmtext.height + 20}
        text: if (menu_page_handler.num4 == 0) {""}
              else {"Mangoes" + '<br>' + "Unit Price: $ 3.00" + itemprice4.text + '<br>' + "Quantity: "+ menu_page_handler.num4}
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Button {
        id: editorderButton
        anchors.right: parent.right
        anchors.rightMargin: page.width*0.1
        y: itemsordereddisplaytext.y
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
        anchors.bottomMargin: page.height*0.5
        text: "TOTAL:"
        font.family: "Avenir"
        font.pixelSize: 35
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.5
        text: "$" + menu_page_handler.total
        wrapMode: Text.WordWrap
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.44
        width: 200
        text: "TAX:"
        wrapMode: Text.WordWrap
        font.family: "Avenir"
        font.pixelSize: 35
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.44
        width: 200
        text: "$" + (menu_page_handler.total * 0.18).toFixed(2)
        wrapMode: Text.WordWrap
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.38
        width: 200
        text: "SHIPPING:"
        wrapMode: Text.WordWrap
        font.family: "Avenir"
        font.pixelSize: 35
        font.letterSpacing: 2
    }
    Text {
        id: shippingfee
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.38
        text: if (menu_page_handler.weight > 0) {"$" + "4.00"} else {"$" + "0.00"}
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.32
        width: 200
        text: "GRAND TOTAL:"
        font.family: "Avenir"
        font.pixelSize: 35
        font.letterSpacing: 2
    }
    Text {
        anchors.left: parent.left
        anchors.leftMargin: page.width*0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.32
        width: 200
        text: if (menu_page_handler.weight > 0) {"$" + (menu_page_handler.total*1.08 + 4.0).toFixed(2)} else {"$0.00"}
        font.family: "Avenir"
        font.pixelSize: 30
        font.letterSpacing: 2
    }
    Button {
        id: orderconfirmationButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: page.height*0.1
        text: "Place order now"
        onClicked: {
           confirmation_page.visible = false
           customer_track_page.visible = true
           if (!vendor_handler.valid1) {
              vendor_handler.name1 = address_page_handler.name
              vendor_handler.street1 = address_page_handler.street
              vendor_handler.city1 = address_page_handler.city
           // we can add this later
           // order1_number.text = (quantity1.text * 1) + (quantity2.text * 1) + (quantity3.text * 1) + (quantity4.text * 1)
              vendor_handler.state1 = address_page_handler.state
              vendor_handler.zip1 = address_page_handler.zip
              vendor_handler.region1 = address_page_handler.region
     //       order1_order.text = quantity1.text + " " + itemname1.text + "\n" +
     //                           quantity2.text + " " + itemname2.text + "\n" +
     //                           quantity3.text + " " + itemname3.text + "\n" +
     //                           quantity4.text + " " + itemname4.text
              vendor_handler.price1 = menu_page_handler.total;
              vendor_handler.time1 = Qt.formatTime(new Date(),"hh:mm");
            //(quantity1.text*itemprice1.text) + (quantity2.text*itemprice2.text) + (quantity3.text*itemprice3.text) + (quantity4.text*itemprice4.text)
      //      order1_deliveryfee.text = shippingfee.text
      //      order1_grandtotal.text = (totalprice.text*1.08 + 4.0).toFixed(2)
       //     order1_time.text = Qt.formatTime(new Date(),"hh:mm")
           }
           else if (!vendor_handler.valid2){
               vendor_handler.name2 = address_page_handler.name
               vendor_handler.street2 = address_page_handler.street
               vendor_handler.city2 = address_page_handler.city
               vendor_handler.state2 = address_page_handler.state
               vendor_handler.zip2 = address_page_handler.zip
               vendor_handler.region2 = address_page_handler.region
               vendor_handler.price2 = menu_page_handler.total;
               vendor_handler.time2 = Qt.formatTime(new Date(),"hh:mm");

    /**            order2_name.text = currentcustomername.text
                order2_city.text = currentcustomercity.text
                order2_number.text = (quantity1.text * 1) + (quantity2.text * 1) + (quantity3.text * 1) + (quantity4.text * 1)
                order2_state.text = currentcustomerstate.text
                order2_zip.text = currentcustomerzipcode.text
                order2_street.text = currentcustomerstreet.text
                order2_country.text = currentcustomercountry.text
                order2_order.text = quantity1.text + " " + itemname1.text + "\n" +
                                    quantity2.text + " " + itemname2.text + "\n" +
                                    quantity3.text + " " + itemname3.text + "\n" +
                                    quantity4.text + " " + itemname4.text
                order2_totalprice.text = (quantity1.text*itemprice1.text) + (quantity2.text*itemprice2.text) + (quantity3.text*itemprice3.text) + (quantity4.text*itemprice4.text)
                order2_deliveryfee.text = shippingfee.text
                order2_grandtotal.text = (totalprice.text*1.08 + 4.0).toFixed(2)
                order2_time.text = Qt.formatTime(new Date(),"hh:mm")
                */
           }
           else if (!vendor_handler.valid3){
               vendor_handler.name3 = address_page_handler.name
               vendor_handler.street3 = address_page_handler.street
               vendor_handler.city3 = address_page_handler.city
               vendor_handler.state3 = address_page_handler.state
               vendor_handler.zip3 = address_page_handler.zip
               vendor_handler.region3 = address_page_handler.region
               vendor_handler.price3 = menu_page_handler.total;
               vendor_handler.time3 = Qt.formatTime(new Date(),"hh:mm");
            /**    order3_name.text = currentcustomername.text
                order3_city.text = currentcustomercity.text
                order3_number.text = (quantity1.text * 1) + (quantity2.text * 1) + (quantity3.text * 1) + (quantity4.text * 1)
                order3_state.text = currentcustomerstate.text
                order3_zip.text = currentcustomerzipcode.text
                order3_street.text = currentcustomerstreet.text
                order3_country.text = currentcustomercountry.text
                order3_order.text = quantity1.text + " " + itemname1.text + "\n" +
                                    quantity2.text + " " + itemname2.text + "\n" +
                                    quantity3.text + " " + itemname3.text + "\n" +
                                    quantity4.text + " " + itemname4.text
                order3_totalprice.text = (quantity1.text*itemprice1.text) + (quantity2.text*itemprice2.text) + (quantity3.text*itemprice3.text) + (quantity4.text*itemprice4.text)
                order3_deliveryfee.text = shippingfee.text
                order3_grandtotal.text = (totalprice.text*1.08 + 4.0).toFixed(2)
                order3_time.text = Qt.formatTime(new Date(),"hh:mm")
                */
          }
        }
    }
}

