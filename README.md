# UAV Android Application Qt and C++
Harvard-HKUST UAV Application

- Website: http://projects.iq.harvard.edu/h2sp
- Facebook: https://www.facebook.com/hkustharvard

This repository contains the code for the UAV (unmanned aerial vehicle) control Android application created by the Harvard-HKUST 2015 team. The application was developed using the Qt Creator environment. It tracks the flight path and battery life of a UAV in the process of delivering objects. The application is built on QML, C++, and the [MAVLink Micro Air Vehicle Communication Protocol](http://qgroundcontrol.org/mavlink/start). It can be run on both Windows and Mac systems, and can be deployed to any number of devices ranging from Android to iOS, though we have only done testing on Android.

Please follow the steps below if you wish to run, modify, and/or improve upon the project.

### Requirements for Running Application Only
Please note that the tracking and battery features will not work unless you have the UAV set up.
- Android SDK: https://developer.android.com/sdk/index.html
- Android NDK: https://developer.android.com/ndk/index.html
- Qt Creator: http://www.qt.io/download/
- MAVLink header files
	- Download [here](https://drive.google.com/file/d/0B8rkAqI6SATGRUM4b3RRdE5KbEk/view?usp=sharing)

### Requirements for Real Flight Testing
- Android SDK: https://developer.android.com/sdk/index.html
- Android NDK: https://developer.android.com/ndk/index.html
- Qt Creator: http://www.qt.io/download/
- MAVLink header files
	- Download [here](https://drive.google.com/file/d/0B8rkAqI6SATGRUM4b3RRdE5KbEk/view?usp=sharing)
- CP210x USB to UART Bridge VCP Driver
- USB Driver
	- We used the version [here](https://www.silabs.com/products/mcu/Pages/USBtoUARTBridgeVCPDrivers.aspx)
- UAV Setup
	- Frame
	- Firmware
	- Pixhawk
    - Battery
- Optional:
	- Android Device [Tablet, phone, etc.]

###Installation
