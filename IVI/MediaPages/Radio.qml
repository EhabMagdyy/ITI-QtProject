import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle {
    id: radioPage
    required property StackView stackView
    anchors.fill: parent
    color: "transparent"

    property var currentStation: null
    property string searchQuery: ""
    property string tagFilter: ""

    RadioAPI {
        id: api
        stationsModel: stationsModel
        radioPlayer:   radioPlayer
        radioPage:     radioPage
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
            if (mediaStatus === MediaPlayer.BufferingMedia) statusDot.color = "#ffaa00"
            else if (mediaStatus === MediaPlayer.BufferedMedia) statusDot.color = "#00ffaa"
            else if (mediaStatus === MediaPlayer.StalledMedia) statusDot.color = "#ff4444"
            else if (mediaStatus === MediaPlayer.NoMedia) statusDot.color = "#555555"
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
                color: "#102a30"
                border.color: "#204d55"
                border.width: 1

                TextInput {
                    id: searchField
                    anchors { fill: parent; leftMargin: 14; rightMargin: 14; verticalCenter: parent.verticalCenter }
                    verticalAlignment: TextInput.AlignVCenter
                    color: "#e7f1ef"
                    font.pixelSize: radioPage.width / 60
                    font.family: "Arial"
                    clip: true
                    onTextChanged: radioPage.searchQuery = text
                    onAccepted: api.fetchStations()

                    Text {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        text: "🔍 Search station name..."
                        color: "#557a7f"
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
                color: searchBtnArea.containsMouse ? "#1a5c66" : "#204d55"
                border.color: "#00ffaa44"
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
                    onClicked: api.fetchStations()
                }
            }

            Rectangle{
                width: 40
                height: 1
                color: "transparent"
            }

            // Title label
            Rectangle {
                width: parent.width / 4
                height: parent.height
                radius: height / 5
                color: "#204d55"
                border.color: "#efffffff"
                border.width: 2

                Text {
                    anchors.centerIn: parent
                    text: radioPage.currentStation ? radioPage.currentStation.name : "📻  Radio Browser"
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
        Rectangle {
            width: parent.width
            height: radioPage.height * 0.6
            radius: radioPage.height / 50
            color: "#0d2b30"
            border.color: "#204d55"
            border.width: 1

            ListView {
                id: stationList
                anchors { fill: parent; margins: 6 }
                model: stationsModel
                clip: true
                spacing: 4

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

                    width: stationList.width
                    height: radioPage.height / 12
                    radius: height / 8
                    color: delegateArea.containsMouse ? "#1a4a52" : (radioPage.currentStation && radioPage.currentStation.name === stationDelegate.name ? "#163f47" : "#102a30")
                    border.color: radioPage.currentStation && radioPage.currentStation.name === stationDelegate.name ? "#00ffaa" : "#204d55"
                    border.width: 1
                    Behavior on color { ColorAnimation { duration: 120 } }

                    Row {
                        anchors { fill: parent; leftMargin: 12; rightMargin: 12 }
                        spacing: 12

                        // Favicon
                        Rectangle {
                            width: parent.height * 0.7
                            height: parent.height * 0.7
                            anchors.verticalCenter: parent.verticalCenter
                            radius: width / 5
                            color: "#204d55"

                            Image {
                                anchors.fill: parent
                                anchors.margins: 3
                                source: stationDelegate.favicon
                                fillMode: Image.PreserveAspectFit
                                visible: status === Image.Ready
                            }
                            Text {
                                anchors.centerIn: parent
                                text: "📻"
                                font.pixelSize: parent.width * 0.5
                                visible: parent.children[0].status !== Image.Ready
                            }
                        }

                        // Info
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
                                color: "#7abfc7"
                                font { pixelSize: radioPage.width / 90; family: "Arial" }
                                elide: Text.ElideRight
                                width: parent.width
                            }
                            Text {
                                text: stationDelegate.tags
                                color: "#557a7f"
                                font { pixelSize: radioPage.width / 95; family: "Arial" }
                                elide: Text.ElideRight
                                width: parent.width
                            }
                        }

                        // Play button
                        Rectangle {
                            width: parent.height * 0.6
                            height: parent.height * 0.6
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 12
                            radius: height / 5
                            color: playBtnArea.containsMouse ? "#021418" : "#072a30"
                            border.color: "#00e4ffff"
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
                        onDoubleClicked: playStation({ stationuuid: stationDelegate.stationuuid, name: stationDelegate.name,
                                                       url: stationDelegate.url, favicon: stationDelegate.favicon,
                                                       country: stationDelegate.country, codec: stationDelegate.codec,
                                                       tags: stationDelegate.tags })
                    }
                }

                // Empty state
                Text {
                    anchors.centerIn: parent
                    text: "No stations.\nSearch or filter above."
                    color: "#557a7f"
                    horizontalAlignment: Text.AlignHCenter
                    font { pixelSize: radioPage.width / 55; family: "Arial" }
                    visible: stationsModel.count === 0
                }
            }
        }

        Row {
            id: audioContRow
            width: parent.width
            height: radioPage.height / 15
            
            spacing: parent.width / 80

            // Play/Pause
            Rectangle {
                id: playBtn
                anchors.verticalCenter: parent.verticalCenter
                width:  parent.width / 20
                height: width
                radius: width / 2
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 2
                color:  playArea.containsMouse ? "#021316" : "#042929"
                border.color: "#00e4ffff"; border.width: 1
                Behavior on color { ColorAnimation { duration: 150 } }

                Text {
                    anchors.centerIn: parent
                    text: radioPlayer.playbackState === MediaPlayer.PlayingState ? "❚❚" : "▶"
                    color: '#ffffff'
                    font.pixelSize: radioPlayer.playbackState === MediaPlayer.PlayingState ? (parent.width + parent.height) / 5 : (parent.width + parent.height) / 4
                    font.family: "Arial"; font.bold: true
                }
                MouseArea {
                    id: playArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: if (radioPage.currentStation){
                        radioPlayer.playbackState === MediaPlayer.PlayingState ? radioPlayer.pause() : radioPlayer.play()
                    }
                }
            }

            Rectangle { width: audioContainer.width / 4; height: 1; color: "transparent" }

            // Mute
            Rectangle {
                id: volumeBtn
                property bool muted: false
                anchors.verticalCenter: parent.verticalCenter
                width:  parent.width / 25
                height: width
                radius: width / 2
                anchors.left: playBtn.right
                anchors.leftMargin: parent.width / 10
                color:  muteArea.containsMouse ? "#021316" : "#042929"
                border.color: "#00e4ffff"; border.width: 1
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
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: volumeBtn.right
                anchors.leftMargin: parent.width / 50
                width: parent.width / 7
                from: 0; to: 1; value: 0.6
                onValueChanged: { audioOut.volume = value; volumeBtn.muted = false; audioOut.muted = false }

                background: Rectangle {
                    x: volumeSlider.leftPadding
                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                    width: volumeSlider.availableWidth; height: 6; radius: 3
                    color: "#05262c"
                    Rectangle {
                        width: volumeSlider.visualPosition * parent.width
                        height: parent.height; radius: parent.radius
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: "#37c596" }
                            GradientStop { position: 1.0; color: '#138660' }
                        }
                    }
                }
            }
        }
        
        // Back button
        Rectangle {
            width: backText.width + 50
            height: backText.height + 18
            radius: height / 3
            color: backArea.containsMouse ? "#1a3a40" : "#204d55"
            border.color: "#00ffaa44"; border.width: 1
            Behavior on color { ColorAnimation { duration: 150 } }

            Text {
                id: backText
                anchors.centerIn: parent
                text: "Back"
                color: "#e7f1ef"
                font { pixelSize: radioPage.width / 50; family: "Arial"; bold: true }
            }
            MouseArea {
                id: backArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: { radioPlayer.stop(); radioPage.stackView.pop() }
            }
        }
    }
}