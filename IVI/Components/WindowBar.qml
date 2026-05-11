import QtQuick
import QtQuick.Window

Rectangle {
    id: titleBar
    width: parent.width - 20
    height: 35
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: '#01012e' }
        GradientStop { position: 0.5; color: '#011129' }
        GradientStop { position: 1.0; color: '#011a27' }
    }
    opacity: 0.9
    anchors.topMargin: 10
    anchors.rightMargin: 10
    anchors.leftMargin: 10
    topLeftRadius: 15
    topRightRadius: 15
    bottomLeftRadius: 15
    bottomRightRadius: 15

    required property var window

    Behavior on opacity {NumberAnimation {duration: 120}}

    MouseArea {
        anchors.fill: parent
        onPressed: titleBar.window.startSystemMove()
        hoverEnabled: true
        onEntered: titleBar.opacity = 1.0
        onExited: titleBar.opacity = 0.9
    }

    Text {
        anchors.centerIn: parent
        text: "Weather"
        color: "white"
        font.bold: true
        font.family: "Arial"
        font.pointSize: 14
    }

    Text {
        text: "−"
        color: "white"
        font.bold: true
        font.family: "Arial"
        font.pointSize: 16
        anchors { right: maximizeBtn.left; rightMargin: 14; verticalCenter: parent.verticalCenter }
        MouseArea {
            anchors.fill: parent
            onClicked: titleBar.window.showMinimized()
            hoverEnabled: true
            onEntered: parent.scale = 1.1
            onExited: parent.scale = 1.0
        }
    }

    Text {
        id: maximizeBtn
        text: titleBar.window.visibility === Window.Maximized ? "❐" : "□"
        color: "white"
        font.bold: true
        font.family: "Arial"
        font.pointSize: 14
        anchors { right: closeBtn.left; rightMargin: 14; verticalCenter: parent.verticalCenter }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (titleBar.window.visibility === Window.Maximized)
                    titleBar.window.showNormal()
                else
                    titleBar.window.showMaximized()
            }
            hoverEnabled: true
            onEntered: parent.scale = 1.1
            onExited: parent.scale = 1.0
        }
    }

    Text {
        id: closeBtn
        text: "x"
        color: "white"
        font.bold: true
        font.family: "Arial"
        font.pointSize: 16
        anchors { right: parent.right; rightMargin: 14; verticalCenter: parent.verticalCenter }
        MouseArea {
            anchors.fill: parent
            onClicked: titleBar.window.close()
            hoverEnabled: true
            onEntered: parent.scale = 1.1
            onExited: parent.scale = 1.0
        }
    }
}