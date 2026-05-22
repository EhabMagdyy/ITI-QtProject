import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtMultimedia
import QtCore

ApplicationWindow {
    id: mainWindow
    width: 1024
    height: 600
    visible: true
    title: qsTr("IVI Dashboard")
    flags: Qt.FramelessWindowHint | Qt.Window

    property bool splashDone: false

    Settings {
        id: appSettings
        property string savedCity: "Giza"
    }

    property string preferredCity: appSettings.savedCity

    onPreferredCityChanged: {
        appSettings.savedCity = mainWindow.preferredCity
    }

    WindowResize {
        z: 2
        window: mainWindow
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: launcherPage
    }

    // ============================================================
    // LAUNCHER PAGE
    // ============================================================
    Component {
        id: launcherPage

        Item {
            id: launcherItem
            signal openWeather()
            signal openClimateControl()
            signal openMedia()
            signal openSettings()
            signal openCarInfo()

            onOpenWeather:        stackView.push(weatherPage)
            onOpenClimateControl: stackView.push(climatePage)
            onOpenMedia:          stackView.push(mediaPage)
            onOpenSettings:       stackView.push(settingPage)
            onOpenCarInfo:        carInfoPopup.visible = true

            property string currentTemp:  "--"
            property string currentEmoji: "🌡️"
            property string currentDesc:  "Loading..."
            property string locationText: "📍 " + mainWindow.preferredCity

            Component.onCompleted: weatherAPI.fetch(mainWindow.preferredCity)

            Connections {
                target: mainWindow
                function onPreferredCityChanged() {
                    weatherAPI.fetch(mainWindow.preferredCity)
                }
            }

            WeatherAPI {
                id: weatherAPI
                onWeatherReceived: function(current, daily, hourly, location) {
                    launcherItem.currentTemp = Math.round(current.temperature_2m) + "°C"
                    var code = current.weather_code
                    var d    = current.is_day

                    if (code === 0)
                        launcherItem.currentDesc = d ? "Clear Sky" : "Clear Night"
                    else if (code <= 2)
                        launcherItem.currentDesc = "Partly Cloudy"
                    else if (code === 3)
                        launcherItem.currentDesc = "Overcast"
                    else if (code <= 48)
                        launcherItem.currentDesc = "Foggy"
                    else if (code <= 55)
                        launcherItem.currentDesc = "Drizzle"
                    else if (code <= 65)
                        launcherItem.currentDesc = "Rainy"
                    else if (code <= 75)
                        launcherItem.currentDesc = "Snowy"
                    else if (code <= 82)
                        launcherItem.currentDesc = "Rain Showers"
                    else
                        launcherItem.currentDesc = "Thunderstorm"

                    if (code === 0)
                        launcherItem.currentEmoji = d ? "☀️" : "🌙"
                    else if (code <= 2)
                        launcherItem.currentEmoji = d ? "🌤️" : "🌙"
                    else if (code === 3)
                        launcherItem.currentEmoji = "☁️"
                    else if (code <= 48)
                        launcherItem.currentEmoji = "🌫️"
                    else if (code <= 57)
                        launcherItem.currentEmoji = "🌦️"
                    else if (code <= 65)
                        launcherItem.currentEmoji = "🌧️"
                    else if (code <= 75)
                        launcherItem.currentEmoji = "❄️"
                    else if (code <= 82)
                        launcherItem.currentEmoji = "🌦️"
                    else
                        launcherItem.currentEmoji = "⛈️"
                    
                    launcherItem.locationText = "📍 " + location.name + ", " + location.country
                }
            }

            // ============================================================
            // BACKGROUND
            // ============================================================
            Rectangle {
                anchors.fill: parent
                color: "#020408"

                Rectangle {
                    anchors.fill: parent
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#0a1628" }
                        GradientStop { position: 0.5; color: "#080e1c" }
                        GradientStop { position: 1.0; color: "#05070a" }
                    }
                }

                Rectangle {
                    x: parent.width * 0.2; y: parent.height * 0.3
                    width: 300; height: 300; radius: 150
                    color: "#1a3a5c"; opacity: 0.15
                    SequentialAnimation on x {
                        loops: Animation.Infinite
                        NumberAnimation { to: launcherItem.width * 0.25; duration: 8000; easing.type: Easing.InOutSine }
                        NumberAnimation { to: launcherItem.width * 0.2;  duration: 8000; easing.type: Easing.InOutSine }
                    }
                    SequentialAnimation on y {
                        loops: Animation.Infinite
                        NumberAnimation { to: launcherItem.height * 0.35; duration: 10000; easing.type: Easing.InOutSine }
                        NumberAnimation { to: launcherItem.height * 0.3;  duration: 10000; easing.type: Easing.InOutSine }
                    }
                }
                Rectangle {
                    x: parent.width * 0.7; y: parent.height * 0.6
                    width: 400; height: 400; radius: 200
                    color: "#2d1b4e"; opacity: 0.12
                    SequentialAnimation on x {
                        loops: Animation.Infinite
                        NumberAnimation { to: launcherItem.width * 0.65; duration: 12000; easing.type: Easing.InOutSine }
                        NumberAnimation { to: launcherItem.width * 0.7;  duration: 12000; easing.type: Easing.InOutSine }
                    }
                    SequentialAnimation on y {
                        loops: Animation.Infinite
                        NumberAnimation { to: launcherItem.height * 0.55; duration: 9000; easing.type: Easing.InOutSine }
                        NumberAnimation { to: launcherItem.height * 0.6;  duration: 9000; easing.type: Easing.InOutSine }
                    }
                }
            }

            // ============================================================
            // TOP GLASS BAR
            // ============================================================
            Rectangle {
                id: topBar
                anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
                anchors.margins: 24; anchors.topMargin: 20
                height: 56; radius: 16
                color: Qt.rgba(1,1,1,0.04)
                border.color: Qt.rgba(1,1,1,0.08)
                border.width: 1

                Row {
                    anchors.fill: parent; anchors.margins: 16
                    spacing: 0

                    Column {
                        id: timeColumn
                        anchors.verticalCenter: parent.verticalCenter; spacing: 1
                        Text {
                            id: timeText
                            color: "#ffffff"
                            font { pixelSize: 26; bold: true; family: "Arial" }
                        }
                        Text {
                            id: dateText
                            color: "#8899bb"
                            font { pixelSize: 13; family: "Arial" }
                        }
                    }

                    Item { width: parent.width * 0.36; height: 1 }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 2
                        Text {
                            text: "Welcome"
                            color: "#ffffff"
                            font { pixelSize: 20; bold: true; family: "Arial" }
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                            text: "Drive Safe"
                            color: "#8899bb"
                            font { pixelSize: 16; family: "Arial" }
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    Item { width: parent.width * 0.38; height: 1 }

                    Image {
                        source: "qrc:/assets/images/mercedes.png"
                        width: 32; height: 32; fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            Timer {
                interval: 1000; running: true; repeat: true; triggeredOnStart: true
                onTriggered: {
                    var now = new Date()
                    dateText.text = now.toLocaleDateString(Qt.locale(), "dddd, MMM d yyyy")
                    timeText.text = now.toLocaleTimeString(Qt.locale(), "hh:mm AP")
                }
            }

            // ============================================================
            // BENTO GRID
            // ============================================================
            Row {
                id: bentoRow
                anchors.top: topBar.bottom; anchors.left: parent.left; anchors.right: parent.right; anchors.bottom: parent.bottom
                anchors.margins: 24; anchors.topMargin: 20
                spacing: 20

                // ---- LEFT COLUMN (30%) ----
                Column {
                    width: parent.width * 0.30; height: parent.height; spacing: 20

                    // Weather
                    Item {
                        width: parent.width; height: parent.height * 0.4
                        Rectangle {
                            anchors.fill: parent; radius: 28
                            color: Qt.rgba(1,1,1,0.05)
                            border.color: hovered ? Qt.rgba(0.2,0.6,1,0.4) : Qt.rgba(1,1,1,0.12)
                            border.width: 1
                            property bool hovered: false
                            scale: hovered ? 1.02 : 1.0
                            Behavior on scale { NumberAnimation { duration: 200 } }
                            Behavior on border.color { ColorAnimation { duration: 200 } }

                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: Qt.rgba(1,1,1,0.08) }
                                    GradientStop { position: 0.5; color: "transparent" }
                                    GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.08) }
                                }
                            }
                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                color: "#36a9de"; opacity: 0.06; z: -1; anchors.margins: -2
                            }

                            transform: Translate { id: wFloat }
                            SequentialAnimation {
                                loops: Animation.Infinite; running: true
                                NumberAnimation { target: wFloat; property: "y"; to: -5; duration: 4000; easing.type: Easing.InOutSine }
                                NumberAnimation { target: wFloat; property: "y"; to: 5;  duration: 4000; easing.type: Easing.InOutSine }
                            }

                            Column {
                                anchors.centerIn: parent; spacing: 10
                                Text { 
                                    text: launcherItem.currentEmoji
                                    font { pixelSize: 64 }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text { 
                                    text: launcherItem.currentTemp
                                    color: "#ffffff"
                                    font { pixelSize: 42; bold: true; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter 
                                }
                                Text { 
                                    text: launcherItem.currentDesc
                                    color: "#aaccff"
                                    font { pixelSize: 16; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text { 
                                    text: launcherItem.locationText
                                    color: "#6677aa"
                                    font { pixelSize: 13; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter 
                                }
                            }

                            MouseArea {
                                anchors.fill: parent; hoverEnabled: true
                                onEntered: parent.hovered = true
                                onExited:  parent.hovered = false
                                onClicked: launcherItem.openWeather()
                            }
                        }
                    }

                    // Voice Bar
                    Item {
                        width: parent.width; height: parent.height * 0.2
                        Rectangle {
                            anchors.fill: parent; radius: 24
                            color: Qt.rgba(1,1,1,0.05)
                            border.color: hovered ? Qt.rgba(1,1,1,0.25) : Qt.rgba(1,1,1,0.12)
                            border.width: 1
                            property bool hovered: false
                            scale: hovered ? 1.02 : 1.0
                            Behavior on scale { NumberAnimation { duration: 200 } }
                            Behavior on border.color { ColorAnimation { duration: 200 } }

                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: Qt.rgba(1,1,1,0.08) }
                                    GradientStop { position: 0.5; color: "transparent" }
                                    GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.08) }
                                }
                            }

                            transform: Translate { id: vFloat }
                            SequentialAnimation {
                                loops: Animation.Infinite; running: true
                                NumberAnimation { target: vFloat; property: "y"; to: -3; duration: 4500; easing.type: Easing.InOutSine }
                                NumberAnimation { target: vFloat; property: "y"; to: 3;  duration: 4500; easing.type: Easing.InOutSine }
                            }

                            Row {
                                anchors.centerIn: parent; spacing: 12
                                Rectangle {
                                    width: 48; height: 48; radius: 24
                                    color: speechManager && speechManager.listening ? "#ff4444" : "#2674cc"
                                    Behavior on color { ColorAnimation { duration: 150 } }
                                    Text { anchors.centerIn: parent; text: speechManager && speechManager.listening ? "🔴" : "🎤"; font.pixelSize: 22 }
                                    MouseArea {
                                        anchors.fill: parent
                                        onPressed:  if (speechManager) speechManager.startListening()
                                        onReleased: if (speechManager) speechManager.stopListening()
                                    }
                                }
                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: speechManager && speechManager.listening ? (speechManager.partialResult !== "" ? speechManager.partialResult : "Listening...") : "Hold to speak"
                                    color: speechManager && speechManager.listening ? "#ffffff" : "#8899bb"
                                    font { pixelSize: 14; italic: !speechManager || !speechManager.listening; family: "Arial" }
                                }
                            }

                            HoverHandler {
                                onHoveredChanged: parent.hovered = hovered
                            }

                            Connections {
                                target: speechManager
                                function onResultReady(text) {
                                    console.log("Recognized:", text)
                                    var lowerText = text.toLowerCase().trim()
                                    if(lowerText.includes("weather")) launcherItem.openWeather()
                                    else if (lowerText.includes("hvac") || lowerText.includes("climate") || lowerText.includes("ac")) launcherItem.openClimateControl()
                                    else if (lowerText.includes("media") || lowerText.includes("music") || lowerText.includes("radio")) launcherItem.openMedia()
                                    else if (lowerText.includes("settings") || lowerText.includes("setting")) launcherItem.openSettings()
                                }
                            }
                        }
                    }

                    // Volume Control — wired to shared C++ controller
                    Item {
                        width: parent.width; height: parent.height * 0.3
                        Rectangle {
                            id: volumeCardRect
                            anchors.fill: parent; radius: 28
                            color: Qt.rgba(1,1,1,0.05)
                            border.color: hovered ? Qt.rgba(0.2,0.6,1,0.4) : Qt.rgba(1,1,1,0.12)
                            border.width: 1
                            property bool hovered: false
                            scale: hovered ? 1.02 : 1.0
                            Behavior on scale { NumberAnimation { duration: 200 } }
                            Behavior on border.color { ColorAnimation { duration: 200 } }

                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: Qt.rgba(1,1,1,0.08) }
                                    GradientStop { position: 0.5; color: "transparent" }
                                    GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.08) }
                                }
                            }
                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                color: "#36a9de"; opacity: 0.06; z: -1; anchors.margins: -2
                            }

                            Column {
                                anchors.centerIn: parent
                                spacing: 2
                                width: parent.width * 0.78

                                Item {
                                    width: parent.width
                                    height: volumeLabel.height

                                    Text {
                                        id: volumeLabel
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Volume"
                                        color: "#ffffff"
                                        font { pixelSize: 18; bold: true; family: "Arial" }
                                    }

                                    Text {
                                        id: percentLabel
                                        anchors.right: parent.right
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: systemVolume.volume + "%"
                                        color: "#36a9de"
                                        font { pixelSize: 18; bold: true; family: "Arial" }
                                    }
                                }

                                Slider {
                                    id: volumeSlider
                                    width: parent.width
                                    height: 32
                                    from: 0
                                    to: 100
                                    stepSize: 1
                                    live: true
                                    value: systemVolume.volume

                                    onValueChanged: {
                                        if (pressed && systemVolume.volume !== value)
                                            systemVolume.volume = value
                                    }

                                    background: Rectangle {
                                        x: volumeSlider.leftPadding
                                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                        width: volumeSlider.availableWidth
                                        height: 6
                                        radius: 3
                                        color: "#082839"

                                        Rectangle {
                                            width: volumeSlider.visualPosition * parent.width
                                            height: parent.height
                                            color: "#36a9de"
                                            radius: 3
                                        }
                                    }

                                    handle: Rectangle {
                                        x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                        width: 16
                                        height: 16
                                        radius: 8
                                        color: volumeSlider.pressed ? "#ffffff" : "#36a9de"
                                        border.color: "#ffffff"
                                        border.width: 1.5
                                    }
                                }

                                Item { height: 8; width: 1 }

                                Rectangle {
                                    width: parent.width * 0.55
                                    height: 34
                                    radius: 8
                                    color: muteArea.containsMouse ? Qt.rgba(0.21, 0.66, 0.87, 0.2) : Qt.rgba(1,1,1,0.06)
                                    border.color: "#36a9de"
                                    border.width: 1
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Text {
                                        anchors.centerIn: parent
                                        text: systemVolume.muted ? "Unmute" : "Mute"
                                        font { pixelSize: 15; family: "Arial"; bold: true }
                                        color: "#ffffff"
                                    }

                                    MouseArea {
                                        id: muteArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: systemVolume.toggleMute()
                                    }
                                }
                            }

                            HoverHandler {
                                onHoveredChanged: parent.hovered = hovered
                            }
                        }
                    }
                }

                // ---- MIDDLE COLUMN (35%) — CENTERED ----
                Column {
                    width: parent.width * 0.35; height: parent.height; spacing: 20

                    // Mercedes Status
                    Item {
                        width: parent.width; height: parent.height * 0.3
                        Rectangle {
                            anchors.fill: parent; radius: 28
                            color: Qt.rgba(1,1,1,0.05)
                            border.color: hovered ? Qt.rgba(1,0.6,0.2,0.4) : Qt.rgba(1,1,1,0.12)
                            border.width: 1
                            property bool hovered: false
                            scale: hovered ? 1.02 : 1.0
                            Behavior on scale { NumberAnimation { duration: 200 } }
                            Behavior on border.color { ColorAnimation { duration: 200 } }

                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: Qt.rgba(1,1,1,0.08) }
                                    GradientStop { position: 0.5; color: "transparent" }
                                    GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.08) }
                                }
                            }
                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                color: "#f79b55"; opacity: 0.06; z: -1; anchors.margins: -2
                            }

                            transform: Translate { id: cFloat }
                            SequentialAnimation {
                                loops: Animation.Infinite; running: true
                                NumberAnimation { target: cFloat; property: "y"; to: 4;  duration: 5000; easing.type: Easing.InOutSine }
                                NumberAnimation { target: cFloat; property: "y"; to: -4; duration: 5000; easing.type: Easing.InOutSine }
                            }

                            Column {
                                anchors.centerIn: parent; spacing: 8
                                Image {
                                    source: "qrc:/assets/images/mercedes.png"
                                    width: 48; height: 48; fillMode: Image.PreserveAspectFit
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text { 
                                    text: "Mercedes-Benz"
                                    color: "#e7f1ef"
                                    font { pixelSize: 16; bold: true; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text { 
                                    text: "System Online"
                                    color: "#21cfa4"
                                    font { pixelSize: 13; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter 
                                }
                                // NEW: hint text
                                Text {
                                    text: "Tap for info"
                                    color: Qt.rgba(1, 1, 1, 0.3)
                                    font { pixelSize: 10; italic: true; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }

                            // NEW: Click handler
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: parent.hovered = true
                                onExited:  parent.hovered = false
                                onClicked: launcherItem.openCarInfo()
                            }
                        }
                    }

                    // HVAC
                    Item {
                        width: parent.width; height: parent.height * 0.65
                        Rectangle {
                            anchors.fill: parent; radius: 28
                            color: Qt.rgba(1,1,1,0.05)
                            border.color: hovered ? Qt.rgba(0.6,0.3,1,0.4) : Qt.rgba(1,1,1,0.12)
                            border.width: 1
                            property bool hovered: false
                            scale: hovered ? 1.02 : 1.0
                            Behavior on scale { NumberAnimation { duration: 200 } }
                            Behavior on border.color { ColorAnimation { duration: 200 } }

                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: Qt.rgba(1,1,1,0.08) }
                                    GradientStop { position: 0.5; color: "transparent" }
                                    GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.08) }
                                }
                            }
                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                color: "#a855f7"; opacity: 0.06; z: -1; anchors.margins: -2
                            }

                            transform: Translate { id: hFloat }
                            SequentialAnimation {
                                loops: Animation.Infinite; running: true
                                NumberAnimation { target: hFloat; property: "y"; to: 3;  duration: 6000; easing.type: Easing.InOutSine }
                                NumberAnimation { target: hFloat; property: "y"; to: -3; duration: 6000; easing.type: Easing.InOutSine }
                            }

                            Column {
                                anchors.centerIn: parent; spacing: 14
                                Text { 
                                    text: "❄️"
                                    font { pixelSize: 48 }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text { 
                                    text: "HVAC"
                                    color: "#ffffff"
                                    font { pixelSize: 24; bold: true; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter 
                                }
                                Text { 
                                    text: "Climate Control"
                                    color: "#d4b3ff"
                                    font { pixelSize: 14; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter 
                                }
                                Text { 
                                    text: "22°C"
                                    color: "#ffffff"
                                    font { pixelSize: 36; bold: true; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter 
                                }
                            }

                            MouseArea {
                                anchors.fill: parent; hoverEnabled: true
                                onEntered: parent.hovered = true
                                onExited:  parent.hovered = false
                                onClicked: launcherItem.openClimateControl()
                            }
                        }
                    }
                }

                // ---- RIGHT COLUMN (30%) ----
                Column {
                    width: parent.width * 0.30; height: parent.height; spacing: 20

                    // Media Player (TOP right)
                    Item {
                        width: parent.width; height: parent.height * 0.65
                        Rectangle {
                            anchors.fill: parent; radius: 28
                            color: Qt.rgba(1,1,1,0.05)
                            border.color: hovered ? Qt.rgba(0.1,0.8,0.6,0.4) : Qt.rgba(1,1,1,0.12)
                            border.width: 1
                            property bool hovered: false
                            scale: hovered ? 1.02 : 1.0
                            Behavior on scale { NumberAnimation { duration: 200 } }
                            Behavior on border.color { ColorAnimation { duration: 200 } }

                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: Qt.rgba(1,1,1,0.08) }
                                    GradientStop { position: 0.5; color: "transparent" }
                                    GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.08) }
                                }
                            }
                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                color: "#21cfa4"; opacity: 0.06; z: -1; anchors.margins: -2
                            }

                            transform: Translate { id: mFloat }
                            SequentialAnimation {
                                loops: Animation.Infinite; running: true
                                NumberAnimation { target: mFloat; property: "y"; to: -4; duration: 5500; easing.type: Easing.InOutSine }
                                NumberAnimation { target: mFloat; property: "y"; to: 4;  duration: 5500; easing.type: Easing.InOutSine }
                            }

                            Column {
                                anchors.centerIn: parent; spacing: 12
                                Rectangle {
                                    width: 80; height: 80; radius: 16
                                    color: Qt.rgba(1,1,1,0.08)
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    Text { anchors.centerIn: parent; text: "🎵"; font.pixelSize: 36 }
                                }
                                Text { 
                                    text: "Media Player"
                                    color: "#ffffff"
                                    font { pixelSize: 20; bold: true; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text { 
                                    text: "Audio, Video & Radio"
                                    color: "#a3ffe0"
                                    font { pixelSize: 13; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter 
                                }
                                Row {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    spacing: 16
                                    Text {
                                        text: "◀◀"
                                        font.pixelSize: 16
                                        color: "#21cfa4"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    Text {
                                        text: "▶"
                                        font.pixelSize: 24
                                        color: "#21cfa4"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    Text {
                                        text: "▶▶"
                                        font.pixelSize: 16
                                        color: "#21cfa4"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent; hoverEnabled: true
                                onEntered: parent.hovered = true
                                onExited:  parent.hovered = false
                                onClicked: launcherItem.openMedia()
                            }
                        }
                    }

                    // Settings (BOTTOM right)
                    Item {
                        width: parent.width; height: parent.height * 0.30
                        Rectangle {
                            anchors.fill: parent; radius: 28
                            color: Qt.rgba(1,1,1,0.05)
                            border.color: hovered ? Qt.rgba(1,1,1,0.3) : Qt.rgba(1,1,1,0.12)
                            border.width: 1
                            property bool hovered: false
                            scale: hovered ? 1.05 : 1.0
                            Behavior on scale { NumberAnimation { duration: 200 } }
                            Behavior on border.color { ColorAnimation { duration: 200 } }

                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: Qt.rgba(1,1,1,0.08) }
                                    GradientStop { position: 0.5; color: "transparent" }
                                    GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.08) }
                                }
                            }
                            Rectangle {
                                anchors.fill: parent; radius: parent.radius
                                color: "#f79b55"; opacity: 0.06; z: -1; anchors.margins: -2
                            }

                            Column {
                                anchors.centerIn: parent; spacing: 10
                                Text { text: "⚙️"; font.pixelSize: 40; anchors.horizontalCenter: parent.horizontalCenter }
                                Text {
                                    text: "Settings"
                                    color: "#ffffff"
                                    font { pixelSize: 16; bold: true; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }

                            MouseArea {
                                anchors.fill: parent; hoverEnabled: true
                                onEntered: parent.hovered = true
                                onExited:  parent.hovered = false
                                onClicked: launcherItem.openSettings()
                            }
                        }
                    }
                }
            }
            
            // ============================================================
            // CAR INFO POPUP
            // ============================================================
            CarInfoPopup {
                id: carInfoPopup
                visible: false
                z: 100
                onClosePopup: visible = false
            }
        }
    }

    // Weather page
    Component {
        id: weatherPage
        WeatherPage {
            onGoBack: stackView.pop()
            city: mainWindow.preferredCity
        }
    }

    // Climate Control page
    Component {
        id: climatePage
        ClimateControlPage {
            onGoBack: stackView.pop()
        }
    }

    Component {
        id: mediaPage
        MediaPlayerPage {
            onGoBack: stackView.pop()
        }
    }

    Component {
        id: settingPage
        SettingPage {
            id: settingsInstance
            onGoBack: stackView.pop()
            preferredCity: mainWindow.preferredCity
            
            onPreferredCityChanged: {
                mainWindow.preferredCity = settingsInstance.preferredCity
                var launcher = stackView.get(0)
                if (launcher && launcher.weatherAPI) {
                    launcher.weatherAPI.fetch(settingsInstance.preferredCity)
                }
            }
        }
    }
}