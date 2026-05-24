import QtQuick
import QtQuick.Window

Rectangle {
    id: titleBar
    width: parent.width - 20
    height: 30
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: titleBar.color0 }
        GradientStop { position: 0.5; color: titleBar.color1 }
        GradientStop { position: 1.0; color: titleBar.color2 }
    }
    opacity: 0.9
    anchors.topMargin: 10
    anchors.rightMargin: 10
    anchors.leftMargin: 10
    topLeftRadius: 10
    topRightRadius: 10
    bottomLeftRadius: 10
    bottomRightRadius: 10

    required property var window
    required property string titleName
    required property bool showBackButton
    required property string color0
    required property string color1
    required property string color2

    signal backRequested()

    Behavior on opacity { NumberAnimation { duration: 120 } }

    MouseArea {
        anchors.fill: parent
        onPressed: titleBar.window.startSystemMove()
        hoverEnabled: true
        onEntered: titleBar.opacity = 1.0
        onExited: titleBar.opacity = 0.9
    }

    // BACK BUTTON
    Rectangle {
        id: backBtn
        width: 22; height: 22; radius: 8
        color: backMouse.pressed ? "#D08831" : "transparent"
        border.color: "#D08831"
        border.width: 1
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        visible: showBackButton

        Image {
            anchors.centerIn: parent
            source: "qrc:/assets/icons/home.png"
            width: 13; height: 13
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            id: backMouse
            anchors.fill: parent
            onClicked: titleBar.backRequested()
            hoverEnabled: true
            onEntered: parent.scale = 1.03
            onExited: parent.scale = 1.0
        }
    }

    // TITLE
    Text {
        anchors.centerIn: parent
        text: titleName
        color: "#D08831"           // Warm orange title
        font.bold: true
        font.family: "Arial"
        font.pointSize: 14
    }

    // WINDOW CONTROLS (Min / Max / Close)
    Row {
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        // Minimize
        Rectangle {
            width: 22; height: 22; radius: 8
            color: minMouse.pressed ? "#D08831" : "transparent"
            border.color: "#D08831"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: "−"
                color: "#FFFFFF"
                font.bold: true
                font.family: "Arial"
                font.pointSize: 16
            }

            MouseArea {
                id: minMouse
                anchors.fill: parent
                onClicked: titleBar.window.showMinimized()
                hoverEnabled: true
                onEntered: parent.scale = 1.03
                onExited: parent.scale = 1.0
            }
        }

        // Maximize / Restore
        Rectangle {
            width: 22; height: 22; radius: 8
            color: maxMouse.pressed ? "#D08831" : "transparent"
            border.color: "#D08831"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: titleBar.window.visibility === Window.Maximized ? "❐" : "□"
                color: "#FFFFFF"
                font.bold: true
                font.family: "Arial"
                font.pixelSize: 12
            }

            MouseArea {
                id: maxMouse
                anchors.fill: parent
                onClicked: {
                    if (titleBar.window.visibility === Window.Maximized)
                        titleBar.window.showNormal()
                    else
                        titleBar.window.showMaximized()
                }
                hoverEnabled: true
                onEntered: parent.scale = 1.03
                onExited: parent.scale = 1.0
            }
        }

        // Close
        Rectangle {
            width: 22; height: 22; radius: 8
            color: closeMouse.pressed ? "#964405" : "transparent"
            border.color: "#964405"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: "×"
                color: "#FFFFFF"
                font.bold: true
                font.family: "Arial"
                font.pixelSize: 16
            }

            MouseArea {
                id: closeMouse
                anchors.fill: parent
                onClicked: titleBar.window.close()
                hoverEnabled: true
                onEntered: parent.scale = 1.03
                onExited: parent.scale = 1.0
            }
        }
    }
}