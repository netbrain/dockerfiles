# scrcpy

Containerized version of scrcpy and android-tools

## Prerequsites

* [Enable developer options on your android device](https://developer.android.com/studio/debug/dev-options#enable)

## Usage
USB

`./scrcpy.sh` to connect and display screen over usb. (not tested, might need to mount the usb device into the container)

WIFI

`./scrcpy.sh adb pair <ip>:<port> <code>` required once in order to pair to your device.

`./scrcpy.sh scrcpy --tcpip=<ip>:<port>` to connect and display screen over wifi.

For other possibilities please read the documentation on scrcpy and android adb.

* https://github.com/Genymobile/scrcpy
* https://developer.android.com/studio/command-line/adb

