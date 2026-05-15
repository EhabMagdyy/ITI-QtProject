import QtQuick
import QtQuick.Controls
import IVI.Volume 1.0
pragma ComponentBehavior: Bound

Item {
    id: root
    signal goBack()
    property real fontSize: (width + height) / 60

    SystemVolumeController {
        id: systemVolume
    }

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
                        text: qsTr("Control your connectivity and sound settings")
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
                        spacing: root.width / 20
                        anchors.horizontalCenter: parent.horizontalCenter

                        NetworkCard{
                            cardWidth: root.width / 5
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
                            cardWidth: root.width / 5
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

                        // VOLUME CARD
                        Rectangle {
                            id: volumeCard
                            width: root.width / 5
                            height: root.height / 2.5
                            radius: cardRow.spacing / 3
                            opacity: 0.8
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: '#ffa845' }
                                GradientStop { position: 0.5; color: '#ff7654' }
                                GradientStop { position: 1.0; color: '#ff4545' }
                            }
                            border.color: '#ffac7c'
                            border.width: 3

                            Column {
                                anchors.centerIn: parent
                                spacing: parent.height / 40

                                Image {
                                    source: "qrc:/assets/icons/volume.png"
                                    width: parent.parent.width / 2.5
                                    height: parent.parent.height / 2.5
                                    fillMode: Image.PreserveAspectFit
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }

                                Rectangle {
                                    width: 1
                                    height: 1
                                    color: "transparent"
                                }

                                Row {
                                    width: parent.width
                                    spacing: parent.width / 3.5
                                    anchors.left: volumeSlider.left
                                    anchors.right: volumeSlider.right

                                    Text {
                                        text: "Volume"
                                        font.pixelSize: root.fontSize * 0.7
                                        font.bold: true
                                        font.family: "Arial"
                                        color: '#252525'
                                        anchors.verticalCenter: volumeSlider.verticalCenter
                                    }

                                    // Volume value display
                                    Text {
                                        text: systemVolume.volume + "%"
                                        font.pixelSize: root.fontSize * 0.7
                                        font.family: "Arial"
                                        font.bold: true
                                        color: '#252525'
                                        anchors.verticalCenter: volumeSlider.verticalCenter
                                    }
                                }

                                // Volume Slider
                                Slider {
                                    id: volumeSlider
                                    width: parent.parent.width * 0.7
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    from: 0
                                    to: 100
                                    stepSize: 1
                                    live: true
                                    value: systemVolume.volume
                                    
                                    onValueChanged: {
                                        if(pressed && systemVolume.volume !== value) {
                                            systemVolume.volume = value
                                        }
                                    }

                                    background: Rectangle {
                                        x: volumeSlider.leftPadding
                                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                        implicitWidth: 200
                                        implicitHeight: 6
                                        width: volumeSlider.availableWidth
                                        height: implicitHeight
                                        radius: height / 2
                                        color: '#252525'
                                        opacity: 0.3

                                        Rectangle {
                                            width: volumeSlider.visualPosition * parent.width
                                            height: parent.height
                                            color: '#252525'
                                            radius: height / 2
                                        }
                                    }

                                    handle: Rectangle {
                                        x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                        implicitWidth: 20
                                        implicitHeight: 20
                                        radius: 10
                                        color: volumeSlider.pressed ? '#ffffff' : '#252525'
                                        border.color: '#ffffff'
                                        border.width: 2
                                    }
                                }

                                Rectangle {
                                    width: 1
                                    height: 1
                                    color: "transparent"
                                }

                                // Mute Button
                                Rectangle {
                                    width: parent.parent.width * 0.4
                                    height: parent.parent.height * 0.12
                                    radius: height / 3
                                    color: muteArea.containsMouse ? Qt.lighter('#252525', 1.3) : '#252525'
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Text {
                                        anchors.centerIn: parent
                                        text: systemVolume.muted ? qsTr("Unmute") : qsTr("Mute")
                                        font.pixelSize: root.fontSize * 0.6
                                        font.family: "Arial"
                                        color: '#ffffff'
                                        font.bold: true
                                    }

                                    MouseArea {
                                        id: muteArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: systemVolume.toggleMute()
                                    }
                                }
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