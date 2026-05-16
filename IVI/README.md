# IVI Dashboard

## Structure
```
.
├── API
│   ├── RadioAPI.qml
│   └── WeatherAPI.qml
├── assets
│   ├── icons
│   │   ├── air.png
│   │   ├── audio.png
│   │   ├── auto.png
│   │   ├── bt.png
│   │   ├── cool.png
│   │   ├── fan.png
│   │   ├── heat.png
│   │   ├── humidity.png
│   │   ├── radio.png
│   │   ├── video.png
│   │   ├── volume.png
│   │   └── wifi.png
│   ├── images
│   │   ├── mercedes.png
│   │   └── weatherbackground.jpg
│   ├── models
│   │   └── vosk
│   └── videos
│       └── splash.mp4
├── Backend
│   ├── BluetoothHWManager.cpp
│   ├── BluetoothHWManager.hpp
│   ├── BluetoothManager.cpp
│   ├── BluetoothManager.hpp
│   ├── SpeechManager.cpp
│   ├── SpeechManager.hpp
│   ├── SystemVolumeController.cpp
│   ├── SystemVolumeController.hpp
│   ├── USBManager.cpp
│   ├── USBManager.hpp
│   ├── WifiManager.cpp
│   └── WifiManager.hpp
├── Components
│   ├── AppCard.qml
│   ├── MediaCard.qml
│   ├── NetworkCard.qml
│   ├── WindowBar.qml
│   └── WindowResize.qml
├── MediaPages
│   ├── Audio.qml
│   ├── Radio.qml
│   └── Video.qml
├── pages
│   ├── ClimateControlPage.qml
│   ├── MediaPlayerPage.qml
│   ├── SettingPage.qml
│   └── WeatherPage.qml
└── SettingPages
│   ├── BluetoothPage.qml
│   └── WiFiPage.qml
├── main.cpp
├── Main.qml
├── CMakeLists.txt
└── resources.qrc
```