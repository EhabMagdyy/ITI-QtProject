import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Item {
    id: root

    signal goBack()

    // ── Background ─────────────────────────────────────────────────────────────
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop { position: 0.0; color: "#062429" }
            GradientStop { position: 0.5; color: "#052227" }
            GradientStop { position: 1.0; color: "#073036" }
        }
    }

    // ── Custom title bar ───────────────────────────────────────────────────────
    Rectangle {
        id: titleBar
        width: parent.width - 20; height: 38
        anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
        color: "#0d3f48"; opacity: 0.9; radius: 12
        border.color: "#ffffff"; border.width: 1
        z: 10

        Behavior on opacity { NumberAnimation { duration: 120 } }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                var win = root
                while (win && !(win instanceof Window)) win = win.parent
                if (win) win.startSystemMove()
            }
            hoverEnabled: true
            onEntered: titleBar.opacity = 1.0
            onExited:  titleBar.opacity = 0.9
        }

        // ← Back button
        Text {
            id: backBtn
            text: "← Back"
            color: "#44e0b8"
            font { bold: true; family: "Arial"; pointSize: 13 }
            anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
            Behavior on opacity { NumberAnimation { duration: 100 } }
            MouseArea {
                anchors.fill: parent; hoverEnabled: true
                onEntered: backBtn.opacity = 0.7
                onExited:  backBtn.opacity = 1.0
                onClicked: root.goBack()
            }
        }

        Text {
            anchors.centerIn: parent
            text: "Climate Control"
            color: "#ffffff"
            font { bold: true; family: "Arial"; pointSize: 14 }
        }

        Row {
            spacing: 14
            anchors { right: parent.right; rightMargin: 14; verticalCenter: parent.verticalCenter }
            Text { text: "−"; color: "#ffffff"; font { bold: true; pointSize: 16 }
                MouseArea { anchors.fill: parent; onClicked: { var w = root; while (w && !(w instanceof Window)) w = w.parent; if(w) w.showMinimized() } } }
            Text { text: "□"; color: "#ffffff"; font { bold: true; pointSize: 14 }
                MouseArea { anchors.fill: parent; onClicked: { var w = root; while (w && !(w instanceof Window)) w = w.parent; if(w) w.visibility === Window.Maximized ? w.showNormal() : w.showMaximized() } } }
            Text { text: "✕"; color: "#ffffff"; font { bold: true; pointSize: 14 }
                MouseArea { anchors.fill: parent; onClicked: Qt.quit() } }
        }
    }

    // ── Main content (centred column, preserves original HVAC layout) ──────────
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
            width: parent.width * 0.9
            height: (root.height - titleBar.height - 60) * 0.28
            anchors.horizontalCenter: parent.horizontalCenter
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#0d3f48" }
                GradientStop { position: 0.5; color: "#0c4048" }
                GradientStop { position: 1.0; color: "#0b414a" }
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

                    ModeIcon { iconSource: "qrc:/assets/icons/cool.png"; iconSize: modePanel.height * 0.45; onClicked: console.log("Cool") }
                    ModeIcon { iconSource: "qrc:/assets/icons/fan.png";  iconSize: modePanel.height * 0.45; onClicked: console.log("Fan")  }
                    ModeIcon { iconSource: "qrc:/assets/icons/heat.png"; iconSize: modePanel.height * 0.45; onClicked: console.log("Heat") }
                    ModeIcon { iconSource: "qrc:/assets/icons/auto.png"; iconSize: modePanel.height * 0.45; onClicked: console.log("Auto") }
                }
            }
        }

        // Controls panel
        Rectangle {
            id: controlsPanel
            width: parent.width * 0.9
            height: (root.height - titleBar.height - 60) * 0.5
            anchors.horizontalCenter: parent.horizontalCenter
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#0d3f48" }
                GradientStop { position: 0.5; color: "#0c4048" }
                GradientStop { position: 1.0; color: "#0b414a" }
            }
            radius: 12; border.color: "white"; border.width: 1

            ColumnLayout {
                id: controlsContent
                anchors { fill: parent; margins: 10 }

                Text {
                    text: "Controls"
                    font { pixelSize: controlsContent.height * 0.045; bold: true }
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

    // ── Inline components (kept local, identical to Task07) ────────────────────

    component ModeIcon: Rectangle {
        id: modeIcon
        property string iconSource: ""
        property real   iconSize:   60
        signal clicked()

        width: iconSize; height: iconSize
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop { position: 0.0; color: "#04171a" }
            GradientStop { position: 1.0; color: "#072a31" }
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

        Layout.fillWidth: true; Layout.leftMargin: 12; Layout.rightMargin: 12

        Row {
            spacing: 8
            Image { source: controlLabel.iconSource; width: 20; height: 20; anchors.verticalCenter: parent.verticalCenter }
            Text  { 
                text: controlLabel.labelText
                font { pixelSize: 14; bold: true }
                color: "white"; anchors.verticalCenter: parent.verticalCenter 
            }
        }
        Item { Layout.fillWidth: true }
        Text { text: controlLabel.percentage + "%"
            font { pixelSize: 14; bold: true }
            color: "white" 
        }
    }

    component ControlSlider: Item {
        id: controlSlider
        property color trackColorLeft:  "#44cc88"
        property color trackColorRight: "#2266aa"
        property alias value: slider.value

        Layout.fillWidth: true; Layout.leftMargin: 12; Layout.rightMargin: 12
        implicitHeight: 28

        Slider {
            id: slider
            anchors.fill: parent
            from: 0; to: 100; stepSize: 1

            background: Item {
                implicitHeight: 28
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
