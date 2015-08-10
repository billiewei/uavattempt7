# UAV Android Application Qt and C++
Harvard-HKUST UAV Application

- Website: http://projects.iq.harvard.edu/h2sp
- Facebook: https://www.facebook.com/hkustharvard

This repository contains the code for the UAV (unmanned aerial vehicle) control Android application created by the Harvard-HKUST 2015 team. The application was developed using the Qt Creator environment. It tracks the flight path and battery life of a UAV in the process of delivering objects. The application is built on QML, C++, and the [MAVLink Micro Air Vehicle Communication Protocol](http://qgroundcontrol.org/mavlink/start). It can be run on both Windows and Mac systems. It cannot yet be deployed to Android or iOS devices, since QtSerialPort is not supported.

Please follow the steps below if you wish to run, modify, and/or improve upon the project.

### Requirements for Running Application Only
Please note that the tracking and battery features will not work unless you have the UAV set up.
- Android SDK: https://developer.android.com/sdk/index.html
- Android NDK: https://developer.android.com/ndk/index.html
- Qt Creator: http://www.qt.io/download/
- [MAVLink header files](https://drive.google.com/file/d/0B8rkAqI6SATGRUM4b3RRdE5KbEk/view?usp=sharing)

### Additional Requirements for Real Flight Testing
- CP210x USB to UART Bridge VCP Driver
- USB Driver Software: download [here](https://www.silabs.com/products/mcu/Pages/USBtoUARTBridgeVCPDrivers.aspx)
- UAV Setup
	- UAV Frame, sensors, batteries, etc.
	- Firmware Code: https://github.com/13rianK/Firmware
	- Pixhawk PX4: https://pixhawk.org/choice
- Optional:
	- Android Device [Tablet, phone, etc.]

### Installation
- Place the MavLink header files into the repository folder.
- Open up the repository in Qt Creator by navigating to the folder and clicking the .pro file.
- Right click the "Headers" folder and click "Add existing files" to add the MAVLink headers.
- Hit the green arrow on the bottom-left panel to build the project. It should run on your computer screen.

### Usage
- If you have the CP210x USB to UART Bridge VCP Driver connected to your computer, the console should read "Serial port is open now". Otherwise, please make sure that you have the USB Driver Software installed.
