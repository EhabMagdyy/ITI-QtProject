import QtQuick
import QtQuick.Controls
pragma ComponentBehavior: Bound

Item {
    id: root
    signal goBack()

    property real fontSize: (width + height) / 60

    WindowBar {
        id: titleBar
        z: 2
        window: mainWindow
        titleName: "Settings"
        showBackButton: true
        onBackRequested: root.goBack()
        color0: '#01012e'
        color1: '#011129'
        color2: '#011a27'
    }

    Rectangle {
        id: background
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0a1628" }
            GradientStop { position: 0.5; color: "#0d1f3c" }
            GradientStop { position: 1.0; color: "#0a1628" }
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

        StackView{
            id: stackView
            anchors.fill: parent
            initialItem: mainPageComponent

            Component {
                id: mainPageComponent
                Column{
                    id: app
                    spacing: parent.height / 48
                    anchors.horizontalCenter: parent.horizontalCenter
                    padding: parent.height * 0.08
                    Text {
                        id: subtitle
                        text: qsTr("Manage your Wi-Fi & Bluetooth connections with ease")
                        font.pixelSize: root.fontSize * 0.8
                        color: '#69a7e5'
                        font.italic: true
                        font.family: "Arial"
                        verticalAlignment: Text.AlignBottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // Divider
                    Rectangle {
                        width: subtitle.width * 1.2
                        height: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: '#75b2ee'
                        opacity: 0.5
                    }

                    Rectangle {
                        height: root.height / 10
                        width: 1
                        color: "transparent"
                    }

                    Row {
                        id: cardRow
                        spacing: root.width / 15
                        anchors.horizontalCenter: parent.horizontalCenter
                        
                        NetworkCard{
                            cardWidth: root.width / 4
                            cardHeight: root.height / 2.5
                            cardColSpacing: cardHeight / 10
                            first: '#ffa845'
                            second: '#ff7654'
                            third: '#ff4545'
                            cardRadius: cardRow.spacing / 3
                            cardBorderColor: '#ffac7c'
                            cardBorderWidth: 3
                            cardOpacity: 0.8
                            cardText: qsTr("Wi-Fi")
                            cardIcon: "qrc:/assets/icons/wifi.png"
                            cardTextFontSize: root.fontSize
                            cardTextFontFamily: "Arial"
                            cardTextColor: '#252525'
                            cardIconWidth: cardWidth / 2
                            cardIconHeight: cardHeight / 2

                            onCardClicked: stackView.push(wifiPageComponent)
                            onCardEntred: {
                                first = Qt.lighter(first, 1.2)
                                second = Qt.lighter(second, 1.2)
                                third = Qt.lighter(third, 1.2)
                            }
                            onCardExited: {
                                first = '#ffa845'
                                second = '#ff7654'
                                third = '#ff4545'
                            }
                        }
                        
                        NetworkCard{
                            cardWidth: root.width / 4
                            cardHeight: root.height / 2.5
                            cardColSpacing: cardHeight / 10
                            first: '#ffa845'
                            second: '#ff7654'
                            third: '#ff4545'
                            cardRadius: cardRow.spacing / 3
                            cardBorderColor: '#ffac7c'
                            cardBorderWidth: 3
                            cardOpacity: 0.8
                            cardText: qsTr("Bluetooth")
                            cardIcon: "qrc:/assets/icons/bt.png"
                            cardTextFontSize: root.fontSize
                            cardTextFontFamily: "Arial"
                            cardTextColor: '#252525'
                            cardIconWidth: cardWidth / 2
                            cardIconHeight: cardHeight / 2

                            onCardClicked: stackView.push(bluetoothPageComponent)
                            onCardEntred: {
                                first = Qt.lighter(first, 1.2)
                                second = Qt.lighter(second, 1.2)
                                third = Qt.lighter(third, 1.2)
                            }
                            onCardExited: {
                                first = '#ffa845'
                                second = '#ff7654'
                                third = '#ff4545'
                            }
                        }
                    }
                }
            }
        }
        Component {
            id: wifiPageComponent
            WiFiPage {
                id: wifiPage
                stackView: stackView
            }
        }

        Component {
            id: bluetoothPageComponent
            BluetoothPage {
                id: btPage
                stackView: stackView
            }
        }
    }
}