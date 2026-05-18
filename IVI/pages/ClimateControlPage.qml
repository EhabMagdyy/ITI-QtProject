import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Qt5Compat.GraphicalEffects

Item {
    id: root
    anchors.fill: parent

    signal goBack()

    property bool syncActive: true
    property bool recircActive: false
    property bool airQualityActive: false
    property bool autoActive: false
    property bool frontPowerOn: false
    property bool backPowerOn: false

    // BACKGROUND
    Rectangle {
        z: -1
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0a1628" }
            GradientStop { position: 0.5; color: "#0d1f3c" }
            GradientStop { position: 1.0; color: "#0a1628" }
        }

        Canvas {
            anchors.fill: parent
            opacity: 0.04
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
    }

    // EXTERNAL COMPONENTS
    WindowBar {
        id: titleBar
        z: 100
        window: root.Window.window
        titleName: "HVAC"
        showBackButton: true
        onBackRequested: root.goBack()
        color0: '#01012e'
        color1: '#011129'
        color2: '#011a27'
    }

    WindowResize {
        z: 99
        anchors.fill: parent
        window: root.Window.window
    }

    // MAIN CONTENT
    Item {
        id: mainContent
        anchors {
            top: titleBar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 12
        }

        // RowLayout stops above the bottom bar so they never overlap
        RowLayout {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: bottomBar.top
                bottomMargin: 8
            }
            spacing: 10

            Item { Layout.fillWidth: true }

            // FRONT PANEL
            Item {
                Layout.preferredWidth: 250
                Layout.preferredHeight: 420
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignVCenter

                Rectangle {
                    id: frontPanel
                    anchors.fill: parent
                    radius: 32
                    color: '#ccbc89e8'
                    border.width: 1
                    border.color: "#50FFFFFF"
                    visible: false
                }

                InnerShadow {
                    id: frontInner
                    anchors.fill: frontPanel
                    source: frontPanel
                    horizontalOffset: -3
                    verticalOffset: -3
                    radius: 10
                    samples: 20
                    color: "#80FFFFFF"
                    visible: false
                }

                DropShadow {
                    anchors.fill: frontPanel
                    source: frontInner
                    horizontalOffset: 6
                    verticalOffset: 6
                    radius: 14
                    samples: 28
                    color: "#50000000"
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 0

                    Text {
                        text: "FRONT"
                        color: '#2f204c'
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 2
                    }

                    Item { Layout.preferredHeight: 6 }

                    RowLayout {
                        id: frontModes
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 8
                        property int currentIndex: 0

                        Repeater {
                            model: [
                                "qrc:/assets/icons/parallel.png",
                                "qrc:/assets/icons/feet.png",
                                "qrc:/assets/icons/parallel-feet.png"
                            ]
                            Rectangle {
                                width: 38; height: 38
                                radius: 10
                                color: frontModes.currentIndex === index ? '#ca9ef9' : '#ad98e4'
                                border.width: frontModes.currentIndex === index ? 2 : 0
                                border.color: "#FFFFFF"

                                Image {
                                    anchors.centerIn: parent
                                    width: 20
                                    height: 20
                                    source: modelData
                                    fillMode: Image.PreserveAspectFit
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: frontModes.currentIndex = index
                                }
                            }
                        }
                    }

                    Item { Layout.preferredHeight: 6 }

                    Loader {
                        id: frontTempLoader
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 120
                        sourceComponent: dialComponent
                        onLoaded: {
                            item.minValue = 16
                            item.maxValue = 30
                            item.value = 23
                            item.suffix = "°"
                            item.label = "Temperature"
                        }
                    }

                    Item { Layout.preferredHeight: 4 }

                    Loader {
                        id: frontFanLoader
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 120
                        sourceComponent: dialComponent
                        onLoaded: {
                            item.minValue = 0
                            item.maxValue = 7
                            item.value = 3
                            item.suffix = ""
                            item.label = "Fan Speed"
                            item.step = 1
                        }
                    }

                    Item { Layout.preferredHeight: 6 }

                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 40; height: 40
                        radius: 20
                        color: root.frontPowerOn ? '#ff6600' : "#2f204c"

                        Text {
                            anchors.centerIn: parent
                            text: "⏻"
                            color: "#FFFFFF"
                            font.pixelSize: 18
                        }

                        MouseArea {
                            id: frontPower
                            anchors.fill: parent
                            onClicked: root.frontPowerOn = !root.frontPowerOn
                        }
                    }

                    Item { Layout.preferredHeight: 4 }
                }
            }

            Item { Layout.preferredWidth: 4 }

            Image {
                Layout.preferredWidth: 400
                Layout.preferredHeight: 340
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                source: "qrc:/assets/images/mercedes_interior.png"
                fillMode: Image.PreserveAspectFit
                rotation: 90
                opacity: 0.35
            }

            Item { Layout.preferredWidth: 4 }

            // BACK PANEL
            Item {
                Layout.preferredWidth: 250
                Layout.preferredHeight: 420
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignVCenter

                Rectangle {
                    id: backPanel
                    anchors.fill: parent
                    radius: 32
                    color: '#ccbc89e8'
                    border.width: 1
                    border.color: '#50FFFFFF'
                    visible: false
                }

                InnerShadow {
                    id: backInner
                    anchors.fill: backPanel
                    source: backPanel
                    horizontalOffset: 3
                    verticalOffset: -3
                    radius: 10
                    samples: 20
                    color: "#80FFFFFF"
                    visible: false
                }

                DropShadow {
                    anchors.fill: backPanel
                    source: backInner
                    horizontalOffset: -6
                    verticalOffset: 6
                    radius: 14
                    samples: 28
                    color: "#50000000"
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 0

                    Text {
                        text: "BACK"
                        color: '#372559'
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 2
                    }

                    Item { Layout.preferredHeight: 6 }

                    RowLayout {
                        id: backModes
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 8
                        property int currentIndex: 0

                        Repeater {
                            model: [
                                "qrc:/assets/icons/parallel.png",
                                "qrc:/assets/icons/feet.png",
                                "qrc:/assets/icons/parallel-feet.png"
                            ]
                            Rectangle {
                                width: 38; height: 38
                                radius: 10
                                color: backModes.currentIndex === index ? '#d3abfd' : '#b09be5'
                                border.width: backModes.currentIndex === index ? 2 : 0
                                border.color: "#FFFFFF"

                                Image {
                                    anchors.centerIn: parent
                                    width: 20
                                    height: 20
                                    source: modelData
                                    fillMode: Image.PreserveAspectFit
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: backModes.currentIndex = index
                                }
                            }
                        }
                    }

                    Item { Layout.preferredHeight: 6 }

                    Loader {
                        id: backTempLoader
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 120
                        sourceComponent: dialComponent
                        onLoaded: {
                            item.minValue = 16
                            item.maxValue = 30
                            item.value = 23
                            item.suffix = "°"
                            item.label = "Temperature"
                        }
                    }

                    Item { Layout.preferredHeight: 4 }

                    Loader {
                        id: backFanLoader
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 120
                        sourceComponent: dialComponent
                        onLoaded: {
                            item.minValue = 0
                            item.maxValue = 7
                            item.value = 3
                            item.suffix = ""
                            item.label = "Fan Speed"
                            item.step = 1
                        }
                    }

                    Item { Layout.preferredHeight: 6 }

                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 40; height: 40
                        radius: 20
                        color: root.backPowerOn ? "#FF8C00" : "#2f204c"

                        Text {
                            anchors.centerIn: parent
                            text: "⏻"
                            color: "#FFFFFF"
                            font.pixelSize: 18
                        }

                        MouseArea {
                            id: backPower
                            anchors.fill: parent
                            onClicked: root.backPowerOn = !root.backPowerOn
                        }
                    }

                    Item { Layout.preferredHeight: 4 }
                }
            }

            Item { Layout.fillWidth: true }
        }

        // BOTTOM GLOBAL CONTROLS
        Rectangle {
            id: bottomBar
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 18
            anchors.horizontalCenter: parent.horizontalCenter
            width: 320
            height: 64
            radius: 20
            color: '#ccc593f1'
            border.width: 1
            border.color: "#50FFFFFF"
            visible: false
        }

        InnerShadow {
            id: bottomInner
            anchors.fill: bottomBar
            source: bottomBar
            horizontalOffset: 0
            verticalOffset: -3
            radius: 10
            samples: 20
            color: "#80FFFFFF"
            visible: false
        }

        DropShadow {
            anchors.fill: bottomBar
            source: bottomInner
            horizontalOffset: 0
            verticalOffset: 6
            radius: 14
            samples: 28
            color: "#50000000"
        }

        RowLayout {
            anchors.fill: bottomBar
            anchors.margins: 10
            spacing: 6

            Item { Layout.fillWidth: true }

            // Recirculation
            Rectangle {
                width: 44; height: 44
                radius: 12
                color: recircMouse.pressed ? "#D8B4FE" : (root.recircActive ? '#d1a9fc' : '#b09be6')
                border.color: "#FFFFFF"
                border.width: root.recircActive ? 2 : 0

                Text {
                    anchors.centerIn: parent
                    text: root.recircActive ? "Recycle" : "Fresh"
                    font.pixelSize: 10
                    color: '#372559'
                }

                MouseArea {
                    id: recircMouse
                    anchors.fill: parent
                    onClicked: root.recircActive = !root.recircActive
                }
            }

            Item { Layout.fillWidth: true }

            // Air Quality
            Rectangle {
                width: 44; height: 44
                radius: 12
                color: aqMouse.pressed ? "#D8B4FE" : (root.airQualityActive ? '#d1a9fc' : '#b09be6')
                border.color: "#FFFFFF"
                border.width: root.airQualityActive ? 2 : 0

                Text {
                    anchors.centerIn: parent
                    text: root.airQualityActive ? "🍃" : "AQ"
                    color: '#372559'
                    font.pixelSize: root.airQualityActive ? 18 : 14
                    font.bold: true
                }

                MouseArea {
                    id: aqMouse
                    anchors.fill: parent
                    onClicked: root.airQualityActive = !root.airQualityActive
                }
            }

            Item { Layout.fillWidth: true }

            // Auto
            Rectangle {
                width: 44; height: 44
                radius: 12
                color: autoMouse.pressed ? "#D8B4FE" : (root.autoActive ? '#d1a9fc' : '#b09be6')
                border.color: "#FFFFFF"
                border.width: root.autoActive ? 2 : 0

                Text {
                    anchors.centerIn: parent
                    text: root.autoActive ? "AUTO" : "Manual"
                    color: '#372559'
                    font.pixelSize: 10
                    font.bold: true
                }

                MouseArea {
                    id: autoMouse
                    anchors.fill: parent
                    onClicked: root.autoActive = !root.autoActive
                }
            }

            Item { Layout.fillWidth: true }

            // Sync
            Rectangle {
                width: 44; height: 44
                radius: 12
                color: syncMouse.pressed ? "#D8B4FE" : (root.syncActive ? '#d1a9fc' : '#b09be6')
                border.color: "#FFFFFF"
                border.width: root.syncActive ? 2 : 0

                Text {
                    anchors.centerIn: parent
                    text: "SYNC"
                    color: '#372559'
                    font.pixelSize: 11
                    font.bold: true
                }

                MouseArea {
                    id: syncMouse
                    anchors.fill: parent
                    onClicked: root.syncActive = !root.syncActive
                }
            }

            Item { Layout.fillWidth: true }
        }
    }

    // SYNC LOGIC
    onSyncActiveChanged: {
        if (syncActive) {
            if (backTempLoader.item && frontTempLoader.item)
                backTempLoader.item.value = frontTempLoader.item.value
            if (backFanLoader.item && frontFanLoader.item)
                backFanLoader.item.value = frontFanLoader.item.value
        }
    }

    Connections {
        target: frontTempLoader.item
        function onValueChanged() {
            if (root.syncActive && backTempLoader.item)
                backTempLoader.item.value = frontTempLoader.item.value
        }
    }

    Connections {
        target: frontFanLoader.item
        function onValueChanged() {
            if (root.syncActive && backFanLoader.item)
                backFanLoader.item.value = frontFanLoader.item.value
        }
    }

    // DIAL COMPONENT
    Component {
        id: dialComponent

        Item {
            id: dialItem
            width: 120
            height: 120

            property real value: 0
            property real minValue: 0
            property real maxValue: 100
            property int step: 1
            property string suffix: ""
            property string label: "LABEL"

            readonly property real startDeg: 135
            readonly property real endDeg: 405
            readonly property real sweepDeg: 270

            function setValueFromMouse(mx, my) {
                var cx = width / 2
                var cy = height / 2
                var dx = mx - cx
                var dy = my - cy
                var rad = Math.atan2(dy, dx)
                var deg = rad * 180 / Math.PI
                if (deg < 0) deg += 360

                var t = 0
                if (deg >= 135 && deg <= 360) {
                    t = (deg - startDeg) / sweepDeg
                } else if (deg >= 0 && deg <= 45) {
                    t = (deg + 360 - startDeg) / sweepDeg
                } else {
                    t = (value > (minValue + maxValue) / 2) ? 1 : 0
                }

                var newVal = minValue + t * (maxValue - minValue)
                if (step > 0) newVal = Math.round(newVal / step) * step
                newVal = Math.max(minValue, Math.min(maxValue, newVal))

                if (newVal !== value) value = newVal
            }

            Canvas {
                id: dialCanvas
                anchors.fill: parent
                antialiasing: true

                onPaint: {
                    var ctx = getContext("2d")
                    var cx = width / 2
                    var cy = height / 2
                    var r = (Math.min(width, height) / 2) - 12

                    var t = (dialItem.value - dialItem.minValue) / (dialItem.maxValue - dialItem.minValue)
                    t = Math.max(0, Math.min(1, t))
                    var currentRad = (dialItem.startDeg + t * dialItem.sweepDeg) * Math.PI / 180

                    ctx.clearRect(0, 0, width, height)

                    ctx.beginPath()
                    ctx.arc(cx, cy, r, dialItem.startDeg * Math.PI / 180, dialItem.endDeg * Math.PI / 180)
                    ctx.lineWidth = 8
                    ctx.strokeStyle = '#38265b'
                    ctx.lineCap = "round"
                    ctx.stroke()

                    ctx.beginPath()
                    ctx.arc(cx, cy, r, dialItem.startDeg * Math.PI / 180, currentRad)
                    ctx.lineWidth = 8
                    ctx.strokeStyle = '#cca1fa'
                    ctx.lineCap = "round"
                    ctx.stroke()

                    var kx = cx + r * Math.cos(currentRad)
                    var ky = cy + r * Math.sin(currentRad)

                    ctx.beginPath()
                    ctx.arc(kx, ky, 8, 0, 2 * Math.PI)
                    ctx.fillStyle = '#d3abfd'
                    ctx.globalAlpha = 0.35
                    ctx.fill()
                    ctx.globalAlpha = 1.0

                    ctx.beginPath()
                    ctx.arc(kx, ky, 5, 0, 2 * Math.PI)
                    ctx.fillStyle = "#FFFFFF"
                    ctx.fill()

                    ctx.fillStyle = '#372558'
                    ctx.font = "bold 24px sans-serif"
                    ctx.textAlign = "center"
                    ctx.textBaseline = "middle"
                    ctx.fillText(Math.round(dialItem.value) + dialItem.suffix, cx, cy - 4)

                    ctx.font = "10px sans-serif"
                    ctx.fillStyle = '#38265c'
                    ctx.globalAlpha = 0.7
                    ctx.fillText(dialItem.label, cx, cy + 18)
                    ctx.globalAlpha = 1.0
                }
            }

            MouseArea {
                anchors.fill: parent
                onPressed: (mouse) => dialItem.setValueFromMouse(mouse.x, mouse.y)
                onPositionChanged: (mouse) => {
                    if (pressed) dialItem.setValueFromMouse(mouse.x, mouse.y)
                }
            }

            onValueChanged: dialCanvas.requestPaint()
            Component.onCompleted: dialCanvas.requestPaint()
        }
    }
}