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

## Volume Controller

```
| Aspect                     | How it works                                                                                                                                                                                             |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **What it does**           | Controls system audio volume and mute state via **PulseAudio** (Linux sound server)                                                                                                                      |
| **Architecture**           | C++ QObject with QML-bindable properties (`volume`, `muted`) and methods (`toggleMute()`)                                                                                                                |
| **PulseAudio integration** | Creates a `pa_mainloop`, connects to PulseAudio daemon, queries/updates the default audio sink                                                                                                           |
| **Polling loop**           | A `QTimer` (50ms) iterates the PulseAudio event loop so callbacks fire without blocking the UI                                                                                                           |
| **Volume update flow**     | QML slider changes `value` → calls `setVolume()` → `applyVolume()` sends new volume to PulseAudio → PulseAudio confirms → `sinkInfoCallback` refreshes actual state → `volumeChanged` signal updates QML |
| **Mute toggle**            | `toggleMute()` flips boolean → `applyMute()` sends to PulseAudio → callback refreshes state                                                                                                              |
| **Why the timer?**         | PulseAudio uses its own event loop; the QTimer bridges it into Qt's thread without blocking                                                                                                              |
```

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│   QML Slider    │◄───►│ SystemVolumeCtrl │◄───►│   PulseAudio    │
│  (Main.qml)     │     │   (C++ backend)  │     │  (system audio) │
└─────────────────┘     └──────────────────┘     └─────────────────┘
```

## Voice Recognition

```
| Aspect                  | How it works                                                                                                                                                 |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **What it does**        | Offline speech-to-text using **Vosk** (lightweight, no cloud required)                                                                                       |
| **Model loading**       | Loads a Vosk acoustic model from `../assets/models/vosk` at startup                                                                                          |
| **Grammar restriction** | Limits recognition to a whitelist of ~20 words (weather, cities, hvac, media, etc.) — ignores everything else as `[unk]`                                     |
| **Audio pipeline**      | Captures microphone via `QAudioSource` at 16kHz mono 16-bit                                                                                                  |
| **Listening lifecycle** | `startListening()` → opens mic, connects `readyRead` signal → `onAudioData()` feeds chunks to Vosk → `stopListening()` closes mic, emits final `resultReady` |
| **Real-time feedback**  | While speaking: `partialResultChanged()` emits live transcription. When sentence complete: `resultReady` emits final text                                    |
| **QML binding**         | `listening` property toggles mic button color (red/blue). `partialResult` shows "Listening..." feedback                                                      |
```

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│   Mic Button    │◄───►│  SpeechManager   │◄───►│   Vosk Model    │
│  (Main.qml)     │     │   (C++ backend)  │     │  (offline STT)  │
└─────────────────┘     └──────────────────┘     └─────────────────┘
                           │
                           ▼
                    ┌──────────────┐
                    │  QML Actions │  → openWeather(), openMedia(), etc.
                    │ (Connections)│
                    └──────────────┘
```