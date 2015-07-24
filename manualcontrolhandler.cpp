#include "manualcontrolhandler.h"

void ManualControlHandler::onSetArming(){

//    if (armingstatetoggle->clicked()) {
//         serial->set_mode_arm() }
//    else{ serial->set_mode_disarm() }

    connect(armingstatetoggle,SIGNAL(clicked()),this, SLOT(onSetArming()));

}
