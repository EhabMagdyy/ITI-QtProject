import QtQuick
import QtQuick.Controls
import QtQuick.Window

ApplicationWindow {
    id: mainWindow
    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("App Launcher")
    flags: Qt.FramelessWindowHint | Qt.Window

    WindowBar {
        id: titleBar
        z: 1
        window: mainWindow
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

            // Subtle grid-dot pattern overlay
            Canvas {
                anchors.fill: parent
                opacity: 0.06
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

            // Center content
            Column {
                anchors.centerIn: parent
                spacing: launcherItem.height * 0.05

                // Header
                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 8

                    Text {
                        text: "🏠  Home"
                        color: "#ffffff"
                        font { pointSize: launcherItem.height * 0.032; bold: true; family: "Arial" }
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: "Select an application to launch"
                        color: "#8899bb"
                        font { pointSize: launcherItem.height * 0.018; family: "Arial" }
                        anchors.horizontalCenter: parent.horizontalCenter
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
                        accentColor: "#4fc3f7"
                        cardWidth: launcherItem.width * 0.22
                        cardHeight: launcherItem.height * 0.38
                        onClicked: launcherItem.openWeather()
                    }

                    // Climate Control card
                    AppCard {
                        title: "Climate Control"
                        subtitle: "HVAC, fan speed & humidity"
                        emoji: "❄️"
                        accentColor: "#44e0b8"
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
