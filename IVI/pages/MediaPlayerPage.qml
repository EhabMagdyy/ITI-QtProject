import QtQuick
import QtQuick.Controls
import QtQuick.Window
pragma ComponentBehavior: Bound

Item {
    id: root
    signal goBack()

    property real fontSize: (width + height) / 60

    WindowBar {
        id: titleBar
        z: 1
        window: mainWindow
        titleName: "Media Player"
        showBackButton: true
        onBackRequested: root.goBack()
        color0: '#082839'
        color1: '#10475E'
        color2: '#3D717E'
    }

    // ============================================ Main Content ================================================
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {position: 0.0; color: '#082839' }
            GradientStop {position: 0.5; color: '#10475E' }
            GradientStop {position: 1.0; color: '#000000' }
        }

        Canvas {
            anchors.fill: parent
            opacity: 0.04
            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = "#D08831"
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
            initialItem: mainPageComponent
            anchors.fill: parent
            // =========================================== Main Page ============================================
            Component{
                id: mainPageComponent
                Item {  // wrapper fills the StackView
                    anchors.fill: parent
                    Row {
                        id: mainRow
                        anchors.centerIn: parent
                        spacing: root.width / 15
                        MediaCard {
                            cardWidth: root.width / 5.5
                            cardHeight: root.height / 2.2
                            cardColSpacing: cardHeight / 40
                            first: '#D08831'
                            second: '#964405'
                            third: '#5A3211'
                            cardRadius: mainRow.spacing / 3
                            cardBorderColor: '#D08831'
                            cardBorderWidth: 3
                            cardOpacity: 0.85
                            cardText: qsTr("Radio")
                            cardIcon: "qrc:/assets//icons/radio.png"
                            cardTextFontSize: root.fontSize * 1.1
                            cardTextFontFamily: "Arial"
                            cardTextColor: '#f8ffff'
                            cardIconWidth: cardWidth / 1.4
                            cardIconHeight: cardHeight / 1.4

                            onCardClicked: stackView.push(radioPageComponent)
                            onCardEntred: {
                                first = Qt.lighter(first, 1.2)
                                second = Qt.lighter(second, 1.2)
                                third = Qt.lighter(third, 1.2)
                            }
                            onCardExited: {
                                first = '#D08831'
                                second = '#964405'
                                third = '#5A3211'
                            }
                        }

                        MediaCard {
                            cardWidth: root.width / 5.5
                            cardHeight: root.height / 2.2
                            cardColSpacing: cardHeight / 12
                            first: '#D08831'
                            second: '#964405'
                            third: '#5A3211'
                            cardRadius: mainRow.spacing / 3
                            cardBorderColor: '#D08831'
                            cardBorderWidth: 3
                            cardOpacity: 0.85
                            cardText: qsTr("Audio")
                            cardIcon: "qrc:/assets//icons/audio.png"
                            cardTextFontSize: root.fontSize * 1.1
                            cardTextFontFamily: "Arial"
                            cardTextColor: '#f8ffff'
                            cardIconWidth: cardWidth / 1.6
                            cardIconHeight: cardHeight / 1.6

                            onCardClicked: stackView.push(audioPageComponent)
                            onCardEntred: {
                                first = Qt.lighter(first, 1.2)
                                second = Qt.lighter(second, 1.2)
                                third = Qt.lighter(third, 1.2)
                            }
                            onCardExited: {
                                first = '#D08831'
                                second = '#964405'
                                third = '#5A3211'
                            }
                        }

                        MediaCard {
                            cardWidth: root.width / 5.5
                            cardHeight: root.height / 2.2
                            cardColSpacing: cardHeight / 20
                            first: '#D08831'
                            second: '#964405'
                            third: '#5A3211'
                            cardRadius: mainRow.spacing / 3
                            cardBorderColor: '#D08831'
                            cardBorderWidth: 3
                            cardOpacity: 0.85
                            cardText: qsTr("Video")
                            cardIcon: "qrc:/assets//icons/video.png"
                            cardTextFontSize: root.fontSize * 1.1
                            cardTextFontFamily: "Arial"
                            cardTextColor: '#f8ffff'
                            cardIconWidth: cardWidth / 1.5
                            cardIconHeight: cardHeight / 1.5

                            onCardClicked: stackView.push(videoPageComponent)
                            onCardEntred: {
                                first = Qt.lighter(first, 1.2)
                                second = Qt.lighter(second, 1.2)
                                third = Qt.lighter(third, 1.2)
                            }
                            onCardExited: {
                                first = '#D08831'
                                second = '#964405'
                                third = '#5A3211'
                            }
                        }
                    }
                }
            }
        }
    }

    // ============================================ Pages ===============================================
    Component{
        id: radioPageComponent
        Radio{
            stackView: stackView
        }
    }

    Component{
        id: audioPageComponent
        Audio{
            stackView: stackView
        }
    }

    Component{
        id: videoPageComponent
        Video{
            stackView: stackView
        }
    }
}