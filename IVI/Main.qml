import QtQuick
import QtQuick.Controls
import QtQuick.Window

ApplicationWindow {
    id: mainWindow
    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("IVI Dashboard")
    flags: Qt.FramelessWindowHint | Qt.Window

    WindowBar {
        id: titleBar
        z: 1
        window: mainWindow
        titleName: "IVI Dashboard"
        showBackButton: false
        visible: stackView.depth === 1
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

            onOpenWeather:        stackView.push(weatherPage)
            onOpenClimateControl: stackView.push(climatePage)

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

            // Content
            Column {
                anchors.centerIn: parent
                spacing: launcherItem.height * 0.05

                // Header
                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: parent.spacing * 0.5

                    Text {
                        text: "IVI Dashboard"
                        color: "#ffffff"
                        font { pointSize: launcherItem.height * 0.032; bold: true; family: "Arial" }
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Row{
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: parent.spacing * 0.4
                        Text {
                            id: dateText
                            color: "#ffffff"
                            font { pointSize: launcherItem.height * 0.03; family: "Arial" }
                        }
                        Text {
                            id: timeText
                            color: "#ffffff"
                            font { pointSize: launcherItem.height * 0.03; family: "Arial" }
                        }
                    }
                }

                // Separator
                Rectangle {
                    width: launcherItem.width * 0.35
                    height: 1
                    color: "#ffffff"
                    opacity: 0.12
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // App cards row
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: launcherItem.width * 0.045

                    // Weather card
                    AppCard {
                        title: "Weather"
                        subtitle: "Live forecasts & hourly data"
                        emoji: "🌤️"
                        accentColor: '#36a9de'
                        cardWidth: launcherItem.width * 0.22
                        cardHeight: launcherItem.height * 0.38
                        onClicked: launcherItem.openWeather()
                    }

                    // Climate Control card
                    AppCard {
                        title: "Climate Control"
                        subtitle: "HVAC, fan speed & humidity"
                        emoji: "❄️"
                        accentColor: '#21cfa4'
                        cardWidth: launcherItem.width * 0.22
                        cardHeight: launcherItem.height * 0.38
                        onClicked: launcherItem.openClimateControl()
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
        }
    }

    // Climate Control page
    Component {
        id: climatePage
        ClimateControlPage {
            onGoBack: stackView.pop()
        }
    }
}
