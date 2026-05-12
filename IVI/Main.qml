import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtMultimedia

ApplicationWindow {
    id: mainWindow
    width: Screen.width  // 1024
    height: Screen.height // 600
    visible: true
    title: qsTr("IVI Dashboard")
    flags: Qt.FramelessWindowHint | Qt.Window

    property bool splashDone: false

    // Splash screen
    Item{
        id: splashScreen
        anchors.fill: parent
        visible: !mainWindow.splashDone
        z: 10

        Video{
            id: splashVideo
            anchors.fill: parent
            source: "qrc:/assets/videos/splash.mp4"
            autoPlay: true
            loops: MediaPlayer.Once
            fillMode: VideoOutput.PreserveAspectCrop

            onPlaybackStateChanged:{
                if(playbackState === MediaPlayer.StoppedState){
                    mainWindow.splashDone = true
                }
            }
        }
    }

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

        opacity: 0 
        // Fade in when splash finishes
        OpacityAnimator {
            id: fadeIn
            target: stackView
            from: 0; to: 1
            duration: 400
            easing.type: Easing.InOutQuad
            running: false
        }
    }

    YAnimator {
        id: slideUp
        target: stackView
        from: mainWindow.height * 0.05; to: 0
        duration: 400
        easing.type: Easing.OutCubic
        running: false
    }

    onSplashDoneChanged: {
        if(splashDone) {
            fadeIn.start()
            slideUp.start()
        }
    }

    Component {
        id: launcherPage

        Item {
            id: launcherItem
            signal openWeather()
            signal openClimateControl()
            signal openMedia()
            signal openSettings()

            property string currentTemp:  "--"
            property string currentEmoji: "🌡️"
            property string currentDesc:  "Loading..."

            onOpenWeather:        stackView.push(weatherPage)
            onOpenClimateControl: stackView.push(climatePage)
            onOpenMedia:          stackView.push(mediaPage)
            onOpenSettings:       stackView.push(settingPage)

            Component.onCompleted: weatherAPI.fetch("Giza")

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
                radius: height * 0.25
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
                            text: "📍 Giza, Egypt"
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
                    title: "Climate Control"
                    subtitle: "HVAC, fan speed & humidity"
                    emoji: "❄️"
                    accentColor: "#21cfa4"
                    cardWidth:  launcherItem.width * 0.2
                    cardHeight: launcherItem.height * 0.35
                    onClicked: launcherItem.openClimateControl()
                }

                AppCard {
                    title: "Media Player"
                    subtitle: "Audio, video & radio"
                    emoji: "🎵"
                    accentColor: "#a855f7"
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
        }
    }


    // Weather page
    Component {
        id: weatherPage
        WeatherPage {
            onGoBack: stackView.pop()
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
            onGoBack: stackView.pop()
        }
    }
}
