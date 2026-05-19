import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtMultimedia
import QtCore

ApplicationWindow {
    id: mainWindow
    width: 1024  // Screen.width
    height: 600  // Screen.height
    visible: true
    title: qsTr("IVI Dashboard")
    flags: Qt.FramelessWindowHint | Qt.Window

    property bool splashDone: false

    // PERSISTENT STORAGE
    Settings {
        id: appSettings
        property string savedCity: "Giza"  // Default value
    }

    // Bind preferredCity to persisted value
    property string preferredCity: appSettings.savedCity

    // Save to persistent storage whenever preferredCity changes
    onPreferredCityChanged: {
        appSettings.savedCity = mainWindow.preferredCity
    }


    // Splash screen
    // Item{
    //     id: splashScreen
    //     anchors.fill: parent
    //     visible: !mainWindow.splashDone
    //     z: 10

    //     Video{
    //         id: splashVideo
    //         anchors.fill: parent
    //         source: "qrc:/assets/videos/splash.mp4"
    //         autoPlay: true
    //         loops: MediaPlayer.Once
    //         fillMode: VideoOutput.PreserveAspectCrop

    //         onPlaybackStateChanged:{
    //             if(playbackState === MediaPlayer.StoppedState){
    //                 mainWindow.splashDone = true
    //             }
    //         }
    //     }
    // }

    WindowBar {
        id: titleBar
        z: 1
        window: mainWindow
        titleName: "IVI Dashboard"
        showBackButton: false
        visible: stackView.depth === 1
        color0: '#01012e'
        color1: '#011129'
        color2: '#011a27'
    }

    // Handle window resizing
    WindowResize {
        z: 2
        window: mainWindow
    }

    // Global StackView
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: launcherPage
    }

    Component {
        id: launcherPage

        Item {
            id: launcherItem
            signal openWeather()
            signal openClimateControl()
            signal openMedia()
            signal openSettings()

            onOpenWeather:        stackView.push(weatherPage)
            onOpenClimateControl: stackView.push(climatePage)
            onOpenMedia:          stackView.push(mediaPage)
            onOpenSettings:       stackView.push(settingPage)

            property string currentTemp:  "--"
            property string currentEmoji: "🌡️"
            property string currentDesc:  "Loading..."
            property string locationText: "📍 " + mainWindow.preferredCity

            // Fetch on startup
            Component.onCompleted: weatherAPI.fetch(mainWindow.preferredCity)

            // Fetch whenever preferredCity changes in MainWindow
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
                    launcherItem.currentDesc = code === 0 ? (d ? "Clear Sky" : "Clear Night")
                        : code <= 2  ? "Partly Cloudy"
                        : code === 3 ? "Overcast"
                        : code <= 48 ? "Foggy"
                        : code <= 55 ? "Drizzle"
                        : code <= 65 ? "Rainy"
                        : code <= 75 ? "Snowy"
                        : code <= 82 ? "Rain Showers"
                        : "Thunderstorm"
                    launcherItem.currentEmoji = code === 0 ? (d ? "☀️" : "🌙")
                        : code <= 2  ? (d ? "🌤️" : "🌙")
                        : code === 3 ? "☁️"
                        : code <= 48 ? "🌫️"
                        : code <= 57 ? "🌦️"
                        : code <= 65 ? "🌧️"
                        : code <= 75 ? "❄️"
                        : code <= 82 ? "🌦️"
                        : "⛈️"
                    
                    launcherItem.locationText = "📍 " + location.name + ", " + location.country
                }
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: {
                    var now = new Date()
                    dateText.text = now.toLocaleDateString(Qt.locale(), "dddd, MMM d yyyy")
                    timeText.text = now.toLocaleTimeString(Qt.locale(), "hh:mm:ss AP")
                }
            }

            // Background
            Rectangle {
                anchors.fill: parent
                border.color: '#031c4f'
                border.width: 4
                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop { position: 0.0; color: "#0a1628" }
                    GradientStop { position: 0.5; color: "#0d1f3c" }
                    GradientStop { position: 1.0; color: "#0a1628" }
                }
            }

            Canvas {
                anchors.fill: parent
                opacity: 0.1
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.fillStyle = "#ffffff"
                    var step = 40
                    for (var x = 0; x < width; x += step) {
                        for (var y = 0; y < height; y += step) {
                            ctx.beginPath()
                            ctx.arc(x, y, 1.5, 0, Math.PI * 2)
                            ctx.fill()
                        }
                    }
                }
            }

            // Top-center: Giza weather card
            Rectangle {
                id: weatherCard
                anchors {
                    top: parent.top
                    topMargin: launcherItem.height * 0.1
                    horizontalCenter: parent.horizontalCenter
                }
                width: launcherItem.width  * 0.2
                height: launcherItem.height * 0.16
                radius: height * 0.15
                color: "#0d1f3c"
                border.color: '#2674cc'
                border.width: 1

                Row {
                    anchors.centerIn: parent
                    spacing: weatherCard.width * 0.1

                    Text {
                        text: launcherItem.currentEmoji
                        font.pointSize: weatherCard.height * 0.35
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 4

                        Text {
                            text: launcherItem.currentTemp
                            color: "#ffffff"
                            font { pointSize: weatherCard.height * 0.25; bold: true; family: "Arial" }
                        }
                        Text {
                            text: launcherItem.currentDesc
                            color: "#8899bb"
                            font { pointSize: weatherCard.height * 0.12; family: "Arial" }
                        }
                        Text {
                            text: launcherItem.locationText
                            color: "#6677aa"
                            font { pointSize: weatherCard.height * 0.1; family: "Arial" }
                        }
                    }
                }
            }

            // Top-left: Time & Date
            Column {
                anchors { top: parent.top; left: parent.left; topMargin: launcherItem.height * 0.1; leftMargin: launcherItem.width * 0.05 }
                spacing: 4

                Text {
                    id: timeText
                    color: "#ffffff"
                    font { pointSize: launcherItem.height * 0.036; bold: true; family: "Arial" }
                }
                Text {
                    id: dateText
                    color: '#a3b0ca'
                    font { pointSize: launcherItem.height * 0.02; family: "Arial" }
                }
            }

            // Top-right: Mercedes logo & name
            Column {
                anchors { top: parent.top; right: parent.right; topMargin: launcherItem.height * 0.08; rightMargin: launcherItem.width * 0.05 }
                spacing: 6

                Image {
                    source: "qrc:/assets/images/mercedes.png"
                    width:  launcherItem.height * 0.1
                    height: launcherItem.height * 0.1
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    text: "Mercedes-Benz"
                    color: '#d2d9eb'
                    font { pointSize: launcherItem.height * 0.018; bold: true; family: "Arial" }
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // Center: App cards
            Row {
                id: appRow
                anchors.top : weatherCard.bottom
                anchors.topMargin: launcherItem.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: launcherItem.width * 0.035

                AppCard {
                    title: "Weather"
                    subtitle: "Live forecasts & hourly data"
                    emoji: "🌤️"
                    accentColor: "#36a9de"
                    cardWidth:  launcherItem.width * 0.2
                    cardHeight: launcherItem.height * 0.35
                    onClicked: launcherItem.openWeather()
                }

                AppCard {
                    title: "HVAC"
                    subtitle: "air conditioner, fan speed & humidity"
                    emoji: "❄️"
                    accentColor: "#a855f7"
                    cardWidth:  launcherItem.width * 0.2
                    cardHeight: launcherItem.height * 0.35
                    onClicked: launcherItem.openClimateControl()
                }

                AppCard {
                    title: "Media Player"
                    subtitle: "Audio, video & radio"
                    emoji: "🎵"
                    accentColor: "#21cfa4"
                    cardWidth:  launcherItem.width * 0.2
                    cardHeight: launcherItem.height * 0.35
                    onClicked: launcherItem.openMedia()
                }

                AppCard {
                    title: "Settings"
                    subtitle: "Wi-Fi, Bluetooth & more"
                    emoji: "⚙️"
                    accentColor: '#f79b55'
                    cardWidth:  launcherItem.width * 0.2
                    cardHeight: launcherItem.height * 0.35
                    onClicked: launcherItem.openSettings()
                }
            }

            Rectangle {
                id: micBar
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: appRow.bottom
                anchors.topMargin: launcherItem.height * 0.06
                width: launcherItem.width * 0.3
                height: launcherItem.height * 0.1
                radius: height / 2
                color: "#0d1f3c"
                border.color: '#2674cc'
                border.width: 1

                Row {
                    anchors.centerIn: parent
                    spacing: micBar.width * 0.03

                    // Mic button
                    Rectangle {
                        id: micBtn
                        width: micBar.height * 0.7
                        height: micBar.height * 0.7
                        radius: width / 2
                        anchors.verticalCenter: parent.verticalCenter
                        color: speechManager && speechManager.listening ? "#ff4444" : "#2674cc"
                        Behavior on color { ColorAnimation { duration: 150 } }

                        Text {
                            anchors.centerIn: parent
                            text: speechManager && speechManager.listening ? "🔴" : "🎤"
                            font.pointSize: micBtn.height * 0.35
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onPressed:  if (speechManager) speechManager.startListening()
                            onReleased: if (speechManager) speechManager.stopListening()
                            onEntered:  micBtn.opacity = 0.8
                            onExited:   micBtn.opacity = 1.0
                        }
                    }

                    // Partial result / hint text
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        width: micBar.width * 0.75
                        text: speechManager && speechManager.listening
                            ? (speechManager.partialResult !== "" ? speechManager.partialResult : "Listening...")
                            : "Hold to speak"
                        color: speechManager && speechManager.listening ? "#ffffff" : "#8899bb"
                        font { pointSize: micBar.height * 0.25; italic: !speechManager || !speechManager.listening; family: "Arial" }
                        elide: Text.ElideRight
                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                }

                // Final result handler
                Connections {
                    target: speechManager
                    function onResultReady(text) {
                        console.log("Recognized:", text)
                        var lowerText = text.toLowerCase().trim()
        
                        if(lowerText.includes("weather")){
                            stackView.push(weatherPage)
                        }
                        else if (lowerText.includes("hvac") || lowerText.includes("climate") || lowerText.includes("ac")){
                            stackView.push(climatePage)
                        }
                        else if (lowerText.includes("media") || lowerText.includes("music") || lowerText.includes("radio")){
                            stackView.push(mediaPage)
                        }
                        else if (lowerText.includes("settings") || lowerText.includes("setting")){
                            stackView.push(settingPage)
                        }
                    }
                }
            }
        }
    }


    // Weather page
    Component {
        id: weatherPage
        WeatherPage {
            onGoBack: stackView.pop()
            // Pass the current preferred city so WeatherPage shows correct city
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
                // Refresh home weather
                var launcher = stackView.get(0)
                if (launcher && launcher.weatherAPI) {
                    launcher.weatherAPI.fetch(settingsInstance.preferredCity)
                }
            }
        }
    }
}
