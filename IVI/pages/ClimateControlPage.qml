import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Item {
    id: root

    signal goBack()

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

    WindowBar {
        id: titleBar
        z: 1
        window: mainWindow
        titleName: "HVAC"
        showBackButton: true
        onBackRequested: root.goBack()
        color0: '#01012e'
        color1: '#011129'
        color2: '#011a27'
    }

    // Main content
    Column {
        id: main
        anchors {
            top: titleBar.bottom; topMargin: root.height * 0.04
            bottom: parent.bottom; bottomMargin: root.height * 0.06
            left: parent.left; leftMargin: root.width * 0.1
            right: parent.right; rightMargin: root.width * 0.1
        }
        spacing: 20

        // Title
        Text {
            text: "Climate Control"
            font { pixelSize: 24; bold: true }
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Rectangle { width: parent.width * 0.8; height: 1; anchors.horizontalCenter: parent.horizontalCenter; color: "white"; opacity: 0.3 }
        Rectangle { width: parent.width * 0.9; height: 1; color: "transparent" }

        // Mode selector panel
        Rectangle {
            id: modePanel
            width: parent.width * 0.8
            height: (root.height - titleBar.height - 60) * 0.28
            anchors.horizontalCenter: parent.horizontalCenter
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: '#0e1639' }
                GradientStop { position: 0.5; color: '#0f1739' }
                GradientStop { position: 1.0; color: '#0e1536' }
            }
            radius: 12; border.color: "white"; border.width: 1

            Column {
                id: modeContent
                anchors.fill: parent
                spacing: 4

                Text {
                    text: "Mode"
                    font { pixelSize: modePanel.height * 0.12; bold: true }
                    color: "white"; opacity: 0.7
                    anchors { top: parent.top; topMargin: 10; left: parent.left; leftMargin: 10 }
                }

                Row {
                    spacing: modeContent.width * 0.04
                    anchors.horizontalCenter: modeContent.horizontalCenter
                    anchors.top: modeContent.top
                    anchors.topMargin: modeContent.height * 0.3

                    ModeIcon { iconSource: "qrc:/assets/icons/cool.png"; iconSize: modePanel.height * 0.55; onClicked: console.log("Cool") }
                    ModeIcon { iconSource: "qrc:/assets/icons/fan.png";  iconSize: modePanel.height * 0.55; onClicked: console.log("Fan")  }
                    ModeIcon { iconSource: "qrc:/assets/icons/heat.png"; iconSize: modePanel.height * 0.55; onClicked: console.log("Heat") }
                    ModeIcon { iconSource: "qrc:/assets/icons/auto.png"; iconSize: modePanel.height * 0.55; onClicked: console.log("Auto") }
                }
            }
        }

        // Controls panel
        Rectangle {
            id: controlsPanel
            width: parent.width * 0.8
            height: (root.height - titleBar.height - 60) * 0.5
            anchors.horizontalCenter: parent.horizontalCenter
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: '#0e1639' }
                GradientStop { position: 0.5; color: '#0f1739' }
                GradientStop { position: 1.0; color: '#0e1536' }
            }
            radius: 12; border.color: "white"; border.width: 1

            ColumnLayout {
                id: controlsContent
                anchors { fill: parent; margins: 10 }

                Text {
                    text: "Controls"
                    font { pixelSize: controlsContent.height * 0.06; bold: true }
                    color: "white"; opacity: 0.7
                    Layout.leftMargin: 2; Layout.topMargin: 2
                }
                Item { Layout.fillHeight: true }

                ControlLabel { iconSource: "qrc:/assets/icons/fan.png";      labelText: "Fan Speed";   percentage: fanSlider.value }
                ControlSlider { id: fanSlider; value: 57; trackColorLeft: "#44cc88"; trackColorRight: "#2266aa" }

                ControlLabel { iconSource: "qrc:/assets/icons/humidity.png"; labelText: "Humidity";    percentage: humSlider.value }
                ControlSlider { id: humSlider; value: 45; trackColorLeft: "#2288ff"; trackColorRight: "#224488" }

                ControlLabel { iconSource: "qrc:/assets/icons/air.png";      labelText: "Air Quality"; percentage: airSlider.value }
                ControlSlider { id: airSlider; value: 75; trackColorLeft: "#cc66ff"; trackColorRight: "#442288" }

                Item { Layout.fillHeight: true }
            }
        }
    }

    component ModeIcon: Rectangle {
        id: modeIcon
        property string iconSource: ""
        property real iconSize: 60
        signal clicked()

        width: iconSize; height: iconSize
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop { position: 0.0; color: '#04091a' }
            GradientStop { position: 1.0; color: '#071131' }
        }
        radius: height * 0.2; border.color: "#1e6e7d"; border.width: 1

        Image { anchors.centerIn: parent; source: iconSource; width: parent.width * 0.6; height: parent.height * 0.6 }

        MouseArea {
            anchors.fill: parent; hoverEnabled: true
            onEntered: modeIcon.opacity = 0.75
            onExited:  modeIcon.opacity = 1.0
            onClicked: modeIcon.clicked()
        }
    }

    component ControlLabel: RowLayout {
        id: controlLabel
        property string iconSource:  ""
        property string labelText:   ""
        property int    percentage:  0

        Layout.fillWidth: true; Layout.leftMargin: 18; Layout.rightMargin: 18

        Row {
            spacing: 8
            Image { source: controlLabel.iconSource; width: 30; height: 30; anchors.verticalCenter: parent.verticalCenter }
            Text  { 
                text: controlLabel.labelText
                font { pixelSize: 20; bold: true }
                color: "white"; anchors.verticalCenter: parent.verticalCenter 
            }
        }
        Item { Layout.fillWidth: true }
        Text { text: controlLabel.percentage + "%"
            font { pixelSize: 20; bold: true }
            color: "white" 
        }
    }

    component ControlSlider: Item {
        id: controlSlider
        property color trackColorLeft:  "#44cc88"
        property color trackColorRight: "#2266aa"
        property alias value: slider.value

        Layout.fillWidth: true; Layout.leftMargin: 18; Layout.rightMargin: 18
        implicitHeight: 32

        Slider {
            id: slider
            anchors.fill: parent
            from: 0; to: 100; stepSize: 1

            background: Item {
                implicitHeight: 32
                Rectangle { anchors.verticalCenter: parent.verticalCenter; width: parent.width; height: 6; radius: 3; color: Qt.rgba(1,1,1,0.10); border.color: Qt.rgba(1,1,1,0.06); border.width: 1 }
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    width: slider.visualPosition * parent.width; height: 6; radius: 3
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: controlSlider.trackColorLeft  }
                        GradientStop { position: 1.0; color: controlSlider.trackColorRight }
                    }
                }
            }

            handle: Rectangle {
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding  + slider.availableHeight / 2 - height / 2
                width: 28; height: 28; radius: 14
                color: Qt.rgba(0.85, 0.92, 1.0, 0.95)
                border.color: Qt.rgba(1,1,1,0.80); border.width: 1
                scale: slider.pressed ? 1.15 : 1.0
                Behavior on scale { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }
                Rectangle { width: 10; height: 10; radius: 5; anchors.centerIn: parent; color: controlSlider.trackColorLeft; opacity: 0.75 }
            }
        }
    }
}
