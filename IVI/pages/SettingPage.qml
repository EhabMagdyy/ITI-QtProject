import QtQuick
import QtQuick.Controls
import IVI.Volume 1.0
pragma ComponentBehavior: Bound

Item {
    id: root
    signal goBack()
    property real fontSize: (width + height) / 60
    property string preferredCity
    property color accentColor: "#45beff" // Unified app accent color

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

        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: mainPageComponent

            Component {
                id: mainPageComponent
                Item {
                    id: app
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.3

                    Row {
                        id: cardRow
                        spacing: root.width / 20
                        anchors.horizontalCenter: parent.horizontalCenter

                        // WI-FI CARD
                        Rectangle {
                            id: wifiCard
                            width: root.width / 5.5
                            height: root.height / 2.5
                            radius: height * 0.06
                            color: "#101e36"
                            scale: wifiHover.hovered ? 1.03 : 1.0
                            
                            border.color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.35)
                            border.width: 1.5

                            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }

                            // Glow Layer
                            Rectangle {
                                anchors.fill: parent
                                radius: parent.radius
                                color: "transparent"
                                border.color: root.accentColor
                                border.width: 2
                                opacity: wifiHover.hovered ? 0.55 : 0.0
                                Behavior on opacity { NumberAnimation { duration: 200 } }
                            }

                            // Top Accent Bar
                            Rectangle {
                                width: parent.width * 0.4
                                height: 3
                                radius: 2
                                color: root.accentColor
                                anchors { top: parent.top; horizontalCenter: parent.horizontalCenter }
                                opacity: 0.85
                            }

                            Column {
                                anchors.centerIn: parent
                                spacing: parent.height * 0.06

                                Rectangle {
                                    width: parent.parent.height * 0.32
                                    height: width
                                    radius: width / 2
                                    color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.12)
                                    border.color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.4)
                                    border.width: 1
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Image {
                                        source: "qrc:/assets/icons/wifi.png"
                                        anchors.centerIn: parent
                                        width: parent.width * 0.55
                                        height: parent.height * 0.55
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }

                                Text {
                                    text: qsTr("Wi-Fi")
                                    color: "#ffffff"
                                    font { bold: true; family: "Arial"; pixelSize: root.fontSize }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }

                                Text {
                                    text: qsTr("Manage connections")
                                    color: "#8899bb"
                                    font { family: "Arial"; pixelSize: root.fontSize * 0.6 }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }

                            HoverHandler { id: wifiHover }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: stackView.push(wifiPageComponent)
                            }
                        }

                        // BLUETOOTH CARD
                        Rectangle {
                            id: bluetoothCard
                            width: root.width / 5.5
                            height: root.height / 2.5
                            radius: height * 0.06
                            color: "#101e36"
                            scale: btHover.hovered ? 1.03 : 1.0
                            
                            border.color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.35)
                            border.width: 1.5

                            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }

                            // Glow Layer
                            Rectangle {
                                anchors.fill: parent
                                radius: parent.radius
                                color: "transparent"
                                border.color: root.accentColor
                                border.width: 2
                                opacity: btHover.hovered ? 0.55 : 0.0
                                Behavior on opacity { NumberAnimation { duration: 200 } }
                            }

                            // Top Accent Bar
                            Rectangle {
                                width: parent.width * 0.4
                                height: 3
                                radius: 2
                                color: root.accentColor
                                anchors { top: parent.top; horizontalCenter: parent.horizontalCenter }
                                opacity: 0.85
                            }

                            Column {
                                anchors.centerIn: parent
                                spacing: parent.height * 0.06

                                Rectangle {
                                    width: parent.parent.height * 0.32
                                    height: width
                                    radius: width / 2
                                    color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.12)
                                    border.color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.4)
                                    border.width: 1
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Image {
                                        source: "qrc:/assets/icons/bt.png"
                                        anchors.centerIn: parent
                                        width: parent.width * 0.55
                                        height: parent.height * 0.55
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }

                                Text {
                                    text: qsTr("Bluetooth")
                                    color: "#ffffff"
                                    font { bold: true; family: "Arial"; pixelSize: root.fontSize }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }

                                Text {
                                    text: qsTr("Pair your devices")
                                    color: "#8899bb"
                                    font { family: "Arial"; pixelSize: root.fontSize * 0.6 }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }

                            HoverHandler { id: btHover }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: stackView.push(bluetoothPageComponent)
                            }
                        }

                        // VOLUME CARD
                        Rectangle {
                            id: volumeCard
                            width: root.width / 5.5
                            height: root.height / 2.5
                            radius: height * 0.06
                            color: "#101e36"
                            scale: volumeHover.hovered ? 1.03 : 1.0
                            
                            border.color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.35)
                            border.width: 1.5

                            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }

                            // Glow Layer
                            Rectangle {
                                anchors.fill: parent
                                radius: parent.radius
                                color: "transparent"
                                border.color: root.accentColor
                                border.width: 2
                                opacity: volumeHover.hovered ? 0.55 : 0.0
                                Behavior on opacity { NumberAnimation { duration: 200 } }
                            }

                            // Top Accent Bar
                            Rectangle {
                                width: parent.width * 0.4
                                height: 3
                                radius: 2
                                color: root.accentColor
                                anchors { top: parent.top; horizontalCenter: parent.horizontalCenter }
                                opacity: 0.85
                            }

                            Column {
                                anchors.centerIn: parent
                                spacing: parent.height * 0.03
                                width: parent.width

                                // Icon Container
                                Rectangle {
                                    width: parent.parent.height * 0.3
                                    height: width
                                    radius: width / 2
                                    color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.12)
                                    border.color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.4)
                                    border.width: 1
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Image {
                                        source: "qrc:/assets/icons/volume.png"
                                        anchors.centerIn: parent
                                        width: parent.width * 0.55
                                        height: parent.height * 0.55
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }

                                // spacer
                                Rectangle {
                                    width: parent.width
                                    height: 1
                                    color: "transparent"
                                }

                                // Volume Text Metadata Container (Fixed from Row to Item)
                                Item {
                                    width: parent.parent.width * 0.75
                                    height: root.fontSize * 0.8
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Text {
                                        text: qsTr("Volume")
                                        font { pixelSize: root.fontSize * 0.6; bold: true; family: "Arial" }
                                        color: '#ffffff'
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    Text {
                                        text: systemVolume.volume + "%"
                                        font { pixelSize: root.fontSize * 0.6; bold: true; family: "Arial" }
                                        color: root.accentColor
                                        anchors.right: parent.right
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                // Upgraded Neon Slider
                                Slider {
                                    id: volumeSlider
                                    width: parent.parent.width * 0.75
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    from: 0
                                    to: 100
                                    stepSize: 1
                                    live: true
                                    value: systemVolume.volume
                                    
                                    onValueChanged: {
                                        if (pressed && systemVolume.volume !== value) {
                                            systemVolume.volume = value
                                        }
                                    }

                                    background: Rectangle {
                                        x: volumeSlider.leftPadding
                                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                        width: volumeSlider.availableWidth
                                        height: 6
                                        radius: 3
                                        color: '#1a2f4c'

                                        Rectangle {
                                            width: volumeSlider.visualPosition * parent.width
                                            height: parent.height
                                            color: root.accentColor
                                            radius: 3
                                        }
                                    }

                                    handle: Rectangle {
                                        x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                        implicitWidth: 16
                                        implicitHeight: 16
                                        radius: 8
                                        color: volumeSlider.pressed ? '#ffffff' : root.accentColor
                                        border.color: '#ffffff'
                                        border.width: 1.5
                                    }
                                }

                                // spacer
                                Rectangle {
                                    width: parent.width
                                    height: 1
                                    color: "transparent"
                                }
                                
                                // Custom Cyberpunk Mute Button
                                Rectangle {
                                    width: parent.parent.width * 0.5
                                    height: parent.parent.height * 0.12
                                    radius: height * 0.3
                                    color: muteArea.containsMouse ? Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.15) : "transparent"
                                    border.color: root.accentColor
                                    border.width: 1
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Text {
                                        anchors.centerIn: parent
                                        text: systemVolume.muted ? qsTr("Unmute") : qsTr("Mute")
                                        font { pixelSize: root.fontSize * 0.55; family: "Arial"; bold: true }
                                        color: '#ffffff'
                                    }

                                    MouseArea {
                                        id: muteArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: systemVolume.toggleMute()
                                    }
                                }
                            }
                            HoverHandler { id: volumeHover }
                        }

                        // WEATHER CITY CARD
                        Rectangle {
                            id: weatherCard
                            width: root.width / 5.5
                            height: root.height / 2.5
                            radius: height * 0.06
                            color: "#101e36"
                            scale: weatherHover.hovered ? 1.03 : 1.0
                            
                            border.color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.35)
                            border.width: 1.5

                            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }

                            // Glow Layer
                            Rectangle {
                                anchors.fill: parent
                                radius: parent.radius
                                color: "transparent"
                                border.color: root.accentColor
                                border.width: 2
                                opacity: weatherHover.hovered ? 0.55 : 0.0
                                Behavior on opacity { NumberAnimation { duration: 200 } }
                            }

                            // Top Accent Bar
                            Rectangle {
                                width: parent.width * 0.4
                                height: 3
                                radius: 2
                                color: root.accentColor
                                anchors { top: parent.top; horizontalCenter: parent.horizontalCenter }
                                opacity: 0.85
                            }

                            Column {
                                anchors.centerIn: parent
                                spacing: parent.height * 0.03
                                width: parent.width

                                // Icon Container
                                Rectangle {
                                    width: parent.parent.height * 0.3
                                    height: width
                                    radius: width / 2
                                    color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.12)
                                    border.color: Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.4)
                                    border.width: 1
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Image {
                                        source: "qrc:/assets/icons/weather.png"
                                        anchors.centerIn: parent
                                        width: parent.width * 0.55
                                        height: parent.height * 0.55
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }

                                // spacer
                                Rectangle {
                                    width: parent.width
                                    height: 1
                                    color: "transparent"
                                }

                                Text {
                                    text: qsTr("Weather City")
                                    font { pixelSize: root.fontSize * 0.6; bold: true; family: "Arial" }
                                    color: '#ffffff'
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }

                                // Dark Theme Matching Input Field
                                TextField {
                                    id: cityInput
                                    width: parent.parent.width * 0.75
                                    height: parent.parent.height * 0.13
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    placeholderText: "Enter city..."
                                    placeholderTextColor: "#556a8a"
                                    font.pixelSize: root.fontSize * 0.4
                                    horizontalAlignment: Text.AlignHCenter
                                    color: '#ffffff'
                                    selectedTextColor: "#ffffff"
                                    selectionColor: root.accentColor
                                                                        
                                    background: Rectangle {
                                        radius: height * 0.25
                                        color: '#1a2f4c'
                                        border.color: cityInput.focus ? root.accentColor : Qt.rgba(1,1,1,0.1)
                                        border.width: 1.5
                                    }
                                    
                                    Keys.onReturnPressed: weatherCard.saveCity()
                                    Keys.onEnterPressed: weatherCard.saveCity()
                                }

                                // spacer
                                Rectangle {
                                    width: parent.width
                                    height: 1
                                    color: "transparent"
                                }

                                // Custom Cyberpunk Save Button
                                Rectangle {
                                    width: parent.parent.width * 0.5
                                    height: parent.parent.height * 0.12
                                    radius: height * 0.3
                                    color: saveArea.containsMouse ? Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.15) : "transparent"
                                    border.color: root.accentColor
                                    border.width: 1
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Text {
                                        anchors.centerIn: parent
                                        text: qsTr("Save")
                                        font { pixelSize: root.fontSize * 0.55; family: "Arial"; bold: true }
                                        color: '#ffffff'
                                    }

                                    MouseArea {
                                        id: saveArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: weatherCard.saveCity()
                                    }
                                }
                            }

                            function saveCity() {
                                var newCity = cityInput.text.trim()
                                if (newCity.length > 0) {
                                    root.preferredCity = newCity
                                    cityInput.focus = false
                                }
                            }
                            HoverHandler { id: weatherHover }
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