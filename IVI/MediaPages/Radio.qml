import QtQuick
import QtQuick.Controls
import QtMultimedia
import Qt5Compat.GraphicalEffects

Rectangle {
    id: radioPage
    required property StackView stackView
    anchors.fill: parent
    color: "transparent"

    property var currentStation: null
    property string searchQuery: ""
    property string tagFilter: ""
    property bool isLoading: false
    property bool searchAttempted: false

    RadioAPI {
        id: api
        stationsModel: stationsModel
        radioPlayer:   radioPlayer
        radioPage:     radioPage
        onLoadingStarted: radioPage.isLoading = true
        onLoadingFinished: radioPage.isLoading = false
    }

    ListModel { id: stationsModel }

    // Player
    MediaPlayer {
        id: radioPlayer
        audioOutput: AudioOutput {
            id: audioOut
            volume: volumeSlider.value
        }
        onMediaStatusChanged: {
            if (mediaStatus === MediaPlayer.BufferingMedia) statusDot.color = "#D08831"
            else if (mediaStatus === MediaPlayer.BufferedMedia) statusDot.color = "#00ffaa"
            else if (mediaStatus === MediaPlayer.StalledMedia) statusDot.color = "#964405"
            else if (mediaStatus === MediaPlayer.NoMedia) statusDot.color = "#5A3211"
        }
    }

    // BACKGROUND
    Rectangle {
        z: -1
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#082839" }
            GradientStop { position: 0.5; color: "#10475E" }
            GradientStop { position: 1.0; color: "#082839" }
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
    }

    // Layout
    Column {
        anchors.fill: parent
        anchors.margins: radioPage.width / 20
        anchors.topMargin: radioPage.height / 10
        spacing: radioPage.height / 40

        // Search bar
        Row {
            width: parent.width
            spacing: radioPage.width / 60
            height: radioPage.height / 18

            Rectangle {
                width: parent.width * 0.35
                height: parent.height
                radius: height / 2
                color: "#082839"
                border.color: "#3D717E"
                border.width: 1

                TextInput {
                    id: searchField
                    anchors { fill: parent; leftMargin: 14; rightMargin: 14; verticalCenter: parent.verticalCenter }
                    verticalAlignment: TextInput.AlignVCenter
                    color: "#e7f1ef"
                    font.pixelSize: radioPage.width / 60
                    font.family: "Arial"
                    clip: true
                    onTextChanged: {
                        radioPage.searchQuery = text
                        if (text === "") radioPage.searchAttempted = false
                    }
                    onAccepted: {
                        radioPage.searchAttempted = true
                        stationsModel.clear()
                        api.fetchStations()
                    }

                    Text {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        text: "🔍 Search station name..."
                        color: "#3D717E"
                        font.pixelSize: radioPage.width / 65
                        font.family: "Arial"
                        visible: searchField.text === ""
                    }
                }
            }

            // Search button
            Rectangle {
                width: parent.width * 0.15
                height: parent.height
                radius: height / 2
                color: searchBtnArea.containsMouse ? "#964405" : "#5A3211"
                border.color: "#D08831"
                border.width: 1
                Behavior on color { ColorAnimation { duration: 150 } }

                Text {
                    anchors.centerIn: parent
                    text: "Search"
                    color: "#e7f1ef"
                    font.pixelSize: radioPage.width / 60
                    font.family: "Arial"
                    font.bold: true
                }
                MouseArea {
                    id: searchBtnArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        radioPage.searchAttempted = true
                        stationsModel.clear()
                        api.fetchStations()
                    }
                }
            }

            Rectangle { width: 40; height: 1; color: "transparent" }

            // NOW PLAYING
            Item {
                width: parent.width / 4
                height: parent.height

                Rectangle {
                    id: titleGlass
                    anchors.fill: parent
                    radius: height / 5
                    color: radioPage.currentStation ? "#964405" : "#3D717E"
                    border.width: 1
                    border.color: "#50FFFFFF"
                    visible: false
                }

                InnerShadow {
                    id: titleInner
                    anchors.fill: titleGlass
                    source: titleGlass
                    horizontalOffset: -2
                    verticalOffset: -2
                    radius: 8
                    samples: 16
                    color: "#80FFFFFF"
                    visible: false
                }

                DropShadow {
                    anchors.fill: titleGlass
                    source: titleInner
                    horizontalOffset: 4
                    verticalOffset: 4
                    radius: 10
                    samples: 20
                    color: "#50000000"
                }

                Text {
                    anchors.centerIn: parent
                    text: radioPage.currentStation ? "▶ " + radioPage.currentStation.name : "📻  Radio Browser"
                    color: "#e7f1ef"
                    font.pixelSize: radioPage.width / 70
                    font.family: "Arial"
                    font.bold: true
                    elide: Text.ElideRight
                    width: parent.width - 20
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        // Station list
        Item {
            width: parent.width
            height: radioPage.height * 0.62

            Rectangle {
                id: listGlass
                anchors.fill: parent
                radius: radioPage.height / 50
                color: "#3D717E"
                border.width: 1
                border.color: "#50FFFFFF"
                visible: false
            }

            InnerShadow {
                id: listInner
                anchors.fill: listGlass
                source: listGlass
                horizontalOffset: -3
                verticalOffset: -3
                radius: 10
                samples: 20
                color: "#80FFFFFF"
                visible: false
            }

            DropShadow {
                anchors.fill: listGlass
                source: listInner
                horizontalOffset: 6
                verticalOffset: 6
                radius: 14
                samples: 28
                color: "#50000000"
            }

            // Loading spinner overlay
            Rectangle {
                anchors.fill: parent
                color: "#082839"
                opacity: 0.85
                visible: radioPage.isLoading
                radius: radioPage.height / 50
                z: 10

                Column {
                    anchors.centerIn: parent
                    spacing: 12

                    // Spinning arc
                    Canvas {
                        id: spinner
                        width: 48; height: 48
                        anchors.horizontalCenter: parent.horizontalCenter
                        onPaint: {
                            var ctx = getContext("2d")
                            var cx = width / 2, cy = height / 2, r = 18
                            ctx.clearRect(0, 0, width, height)
                            ctx.lineWidth = 4
                            ctx.lineCap = "round"
                            ctx.strokeStyle = "#D08831"
                            ctx.beginPath()
                            ctx.arc(cx, cy, r, -Math.PI / 2, -Math.PI / 2 + Math.PI * 1.5)
                            ctx.stroke()
                        }

                        RotationAnimation on rotation {
                            from: 0; to: 360
                            duration: 800
                            loops: Animation.Infinite
                        }
                    }

                    Text {
                        text: "Searching stations..."
                        color: "#D08831"
                        font { pixelSize: radioPage.width / 55; family: "Arial"; bold: true }
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            ListView {
                id: stationList
                anchors { fill: parent; margins: 6; rightMargin: 16 }
                model: stationsModel
                clip: true
                spacing: 4
                visible: !radioPage.isLoading

                ScrollBar.vertical: ScrollBar {
                    width: 8
                    policy: ScrollBar.AsNeeded
                    interactive: true

                    contentItem: Rectangle {
                        implicitWidth: 6
                        radius: width / 2
                        color: parent.pressed ? "#964405" : "#D08831"
                        opacity: parent.pressed ? 1.0 : 0.85
                        anchors.horizontalCenter: parent.horizontalCenter
                        Behavior on color { ColorAnimation { duration: 120 } }
                    }

                    background: Rectangle {
                        implicitWidth: 8
                        color: "#082839"
                        radius: width / 2
                        opacity: 0.5
                        anchors.fill: parent
                    }
                }

                delegate: Rectangle {
                    id: stationDelegate
                    required property string stationuuid
                    required property string name
                    required property string url
                    required property string favicon
                    required property string codec
                    required property string tags
                    required property string country
                    required property int index

                    width: stationList.width - 14
                    height: radioPage.height / 12
                    radius: height / 8
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    color: delegateArea.containsMouse ? "#964405" : (radioPage.currentStation && radioPage.currentStation.name === stationDelegate.name ? "#5A3211" : "#082839")
                    border.color: radioPage.currentStation && radioPage.currentStation.name === stationDelegate.name ? "#D08831" : "#3D717E"
                    border.width: 1
                    Behavior on color { ColorAnimation { duration: 120 } }

                    Row {
                        anchors { fill: parent; leftMargin: 12; rightMargin: 12 }
                        spacing: 12

                        Rectangle {
                            width: parent.height * 0.7
                            height: parent.height * 0.7
                            anchors.verticalCenter: parent.verticalCenter
                            radius: width / 5
                            color: "#3D717E"

                            Image {
                                anchors.fill: parent
                                anchors.margins: 3
                                source: stationDelegate.favicon || ""
                                fillMode: Image.PreserveAspectFit
                                visible: status === Image.Ready
                                asynchronous: true
                            }
                            Text {
                                anchors.centerIn: parent
                                text: "📻"
                                font.pixelSize: parent.width * 0.5
                                visible: parent.children[0].status !== Image.Ready
                            }
                        }

                        Column {
                            width: parent.width * 0.6
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.children[0].right
                            anchors.leftMargin: 8
                            spacing: 1

                            Text {
                                text: stationDelegate.name
                                color: "#e7f1ef"
                                font { pixelSize: radioPage.width / 80; bold: true; family: "Arial" }
                                elide: Text.ElideRight
                                width: parent.width
                            }
                            Text {
                                text: stationDelegate.country + " • " + stationDelegate.codec
                                color: "#D08831"
                                font { pixelSize: radioPage.width / 90; family: "Arial" }
                                elide: Text.ElideRight
                                width: parent.width
                            }
                            Text {
                                text: stationDelegate.tags
                                color: "#3D717E"
                                font { pixelSize: radioPage.width / 95; family: "Arial" }
                                elide: Text.ElideRight
                                width: parent.width
                            }
                        }

                        Rectangle {
                            width: parent.height * 0.6
                            height: parent.height * 0.6
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 12
                            radius: height / 5
                            color: playBtnArea.containsMouse ? "#082839" : "#5A3211"
                            border.color: "#D08831"
                            border.width: 1
                            Behavior on color { ColorAnimation { duration: 150 } }

                            Text {
                                anchors.centerIn: parent
                                text: radioPage.currentStation && radioPage.currentStation.name === stationDelegate.name
                                    && radioPlayer.playbackState === MediaPlayer.PlayingState ? "❚❚" : "▶"
                                color: "#ffffff"
                                font { pixelSize: parent.width * 0.35; family: "Arial"; bold: true }
                            }

                            MouseArea {
                                id: playBtnArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (radioPage.currentStation && radioPage.currentStation.name === stationDelegate.name)
                                        api.togglePlayPause()
                                    else
                                        api.playStation({ stationuuid: stationDelegate.stationuuid, name: stationDelegate.name,
                                                    url: stationDelegate.url, favicon: stationDelegate.favicon,
                                                    country: stationDelegate.country, codec: stationDelegate.codec,
                                                    tags: stationDelegate.tags })
                                }
                            }
                        }
                    }

                    MouseArea {
                        id: delegateArea
                        anchors.fill: parent
                        hoverEnabled: true
                        z: -1
                        onDoubleClicked: api.playStation({ stationuuid: stationDelegate.stationuuid, name: stationDelegate.name,
                                                    url: stationDelegate.url, favicon: stationDelegate.favicon,
                                                    country: stationDelegate.country, codec: stationDelegate.codec,
                                                    tags: stationDelegate.tags })
                    }
                }
            }

            // EMPTY STATE — sibling of ListView, not a child inside it
            Column {
                anchors.centerIn: parent
                spacing: 8
                visible: stationsModel.count === 0 && !radioPage.isLoading
                z: 5

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: radioPage.searchAttempted ? "⚠" : "📻"
                    color: "#D08831"
                    font { pixelSize: radioPage.width / 30; family: "Arial" }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: radioPage.searchAttempted
                        ? "No station found with that name."
                        : "No stations.\nSearch or filter above."
                    color: "#e7f1ef"
                    horizontalAlignment: Text.AlignHCenter
                    font { pixelSize: radioPage.width / 55; family: "Arial"; bold: true }
                }
            }
        }

        // Spacer
        Rectangle {width: parent.width; height: 3; color: "transparent" }

        // CONTROLS ROW — Back | centered Prev/Play/Next | Volume
        Row {
            id: audioContRow
            width: parent.width
            height: radioPage.height / 15
            spacing: 0

            // Back button (left)
            Rectangle {
                id: backBtnRect
                anchors.verticalCenter: parent.verticalCenter
                width: backText.width + 40
                height: backText.height + 14
                radius: height / 3
                color: backArea.containsMouse ? "#964405" : "#5A3211"
                border.color: "#D08831"
                border.width: 1
                Behavior on color { ColorAnimation { duration: 150 } }

                Text {
                    id: backText
                    anchors.centerIn: parent
                    text: "Back"
                    color: "#e7f1ef"
                    font { pixelSize: radioPage.width / 55; family: "Arial"; bold: true }
                }
                MouseArea {
                    id: backArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: { radioPlayer.stop(); radioPage.stackView.pop() }
                }
            }

            // Centered playback controls
            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: radioPage.width / 60

                // Previous
                Rectangle {
                    id: prevBtn
                    anchors.verticalCenter: parent.verticalCenter
                    width: radioPage.width / 25
                    height: width
                    radius: width / 2
                    color: prevArea.containsMouse ? "#082839" : "#5A3211"
                    border.color: "#D08831"
                    border.width: 1
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent
                        text: "◀◀"
                        color: '#ffffff'
                        font.pixelSize: (parent.width + parent.height) / 6
                        font.family: "Arial"
                        font.bold: true
                    }
                    MouseArea {
                        id: prevArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: api.playPrevious()
                    }
                }

                // Play/Pause
                Rectangle {
                    id: playBtn
                    anchors.verticalCenter: parent.verticalCenter
                    width: radioPage.width / 20
                    height: width
                    radius: width / 2
                    color: playArea.containsMouse ? "#082839" : "#5A3211"
                    border.color: "#D08831"
                    border.width: 2
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent
                        text: radioPlayer.playbackState === MediaPlayer.PlayingState ? "❚❚" : "▶"
                        color: '#ffffff'
                        font.pixelSize: radioPlayer.playbackState === MediaPlayer.PlayingState ? (parent.width + parent.height) / 5 : (parent.width + parent.height) / 4
                        font.family: "Arial"
                        font.bold: true
                    }
                    MouseArea {
                        id: playArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: if (radioPage.currentStation) {
                            radioPlayer.playbackState === MediaPlayer.PlayingState ? radioPlayer.pause() : radioPlayer.play()
                        }
                    }
                }

                // Next
                Rectangle {
                    id: nextBtn
                    anchors.verticalCenter: parent.verticalCenter
                    width: radioPage.width / 25
                    height: width
                    radius: width / 2
                    color: nextArea.containsMouse ? "#082839" : "#5A3211"
                    border.color: "#D08831"
                    border.width: 1
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent
                        text: "▶▶"
                        color: '#ffffff'
                        font.pixelSize: (parent.width + parent.height) / 6
                        font.family: "Arial"
                        font.bold: true
                    }
                    MouseArea {
                        id: nextArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: api.playNext()
                    }
                }
            }

            // Volume controls (right)
            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: radioPage.width / 50
                spacing: radioPage.width / 80

                // Mute
                Rectangle {
                    id: volumeBtn
                    property bool muted: false
                    width: radioPage.width / 25
                    height: width
                    radius: width / 2
                    color: muteArea.containsMouse ? "#082839" : "#5A3211"
                    border.color: "#D08831"
                    border.width: 1
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent
                        text: volumeBtn.muted ? "🔇" : volumeSlider.value < 0.5 ? "🔉" : "🔊"
                        font.pixelSize: (parent.width + parent.height) / 4
                        font.family: "Arial"
                    }
                    MouseArea {
                        id: muteArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            volumeBtn.muted = !volumeBtn.muted
                            audioOut.muted  = volumeBtn.muted
                        }
                    }
                }

                // Volume slider
                Slider {
                    id: volumeSlider
                    width: radioPage.width / 7
                    anchors.verticalCenter: parent.verticalCenter
                    from: 0; to: 1; value: 0.6
                    onValueChanged: { audioOut.volume = value; volumeBtn.muted = false; audioOut.muted = false }

                    background: Rectangle {
                        x: volumeSlider.leftPadding
                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                        width: volumeSlider.availableWidth; height: 6; radius: 3
                        color: "#082839"
                        Rectangle {
                            width: volumeSlider.visualPosition * parent.width
                            height: parent.height; radius: parent.radius
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop { position: 0.0; color: "#D08831" }
                                GradientStop { position: 1.0; color: '#964405' }
                            }
                        }
                    }
                }
            }
        }
    }
}