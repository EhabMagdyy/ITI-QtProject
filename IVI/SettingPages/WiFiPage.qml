import QtQuick
import QtQuick.Controls

Rectangle {
    id: wifiPage
    width: parent ? parent.width : 0
    height: parent ? parent.height : 0
    color: "transparent"
    required property StackView stackView

    // Backend Connections
    Connections {
        target: WifiManager

        function onWifiEnabledChanged(enabled) {
            wifiSwitch.checked = enabled
        }
        function onScanStarted() {
            showToast("Scanning for networks...", false)
        }
        function onScanFinished(networks) {
            networkListModel.clear()
            for (var i = 0; i < networks.length; i++)
                networkListModel.append({ "name": networks[i] })
            scanResultsPopup.open()
        }
        function onScanFailed(reason) {
            showToast("Scan failed: " + reason, true)
        }
        function onConnectSuccess(ssid) {
            showToast("Connected to " + ssid, false)
        }
        function onConnectFailed(reason) {
            showToast(reason, true)
        }
        function onPasswordRequired(ssid) {
            passwordPopupSsid.text = ssid
            passwordPopup.open()
        }
        // React to connected SSID changing (system-side or our call)
        function onConnectedSsidChanged(ssid) {
            if (ssid === "")
                showToast("Disconnected", false)
        }
    }

    // Main Content Column
    Column {
        id: wifiPageCol
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: wifiPage.width * 0.06
        anchors.topMargin: wifiPage.height * 0.08
        anchors.bottomMargin: wifiPage.height * 0.05
        spacing: wifiPage.height * 0.02

        // Page Title
        Text {
            text: qsTr("Wi-Fi Settings")
            font.pixelSize: wifiPage.width / 28
            color: '#ffffff'
            font.bold: true
            font.family: "Arial"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Divider
        Rectangle {
            width: parent.width
            height: 1
            color: '#2674cc'
            opacity: 0.5
        }

        // Wi-Fi Toggle Card
        Rectangle {
            width: parent.width
            height: wifiPage.height / 10
            radius: height / 4
            gradient: Gradient {
                GradientStop { position: 0.0; color: '#0d1f3c' }
                GradientStop { position: 1.0; color: '#0a1628' }
            }
            border.color: wifiSwitch.checked ? '#2674cc' : '#1a3a5c'
            border.width: 2

            Row {
                anchors.fill: parent
                anchors.leftMargin: parent.width * 0.05
                anchors.rightMargin: parent.width * 0.05

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width - wifiSwitch.width - parent.anchors.leftMargin - parent.anchors.rightMargin
                    spacing: 2
                    Text {
                        text: qsTr("Wi-Fi")
                        font.pixelSize: wifiPage.height * 0.025
                        color: '#ffffff'
                        font.bold: true
                        font.family: "Arial"
                    }
                    Text {
                        text: wifiSwitch.checked ? qsTr("ON") : qsTr("OFF")
                        font.pixelSize: wifiPage.height * 0.022
                        color: wifiSwitch.checked ? '#36a9de' : '#8899bb'
                        font.family: "Arial"
                    }
                }

                Switch {
                    id: wifiSwitch
                    anchors.verticalCenter: parent.verticalCenter
                    checked: WifiManager.wifiEnabled
                    onCheckedChanged: WifiManager.wifiEnabled = checked
                }
            }
        }

        // Scan Button
        Rectangle {
            width: parent.width
            height: wifiPage.height / 12
            radius: height / 4
            opacity: wifiSwitch.checked ? 1.0 : 0.4
            gradient: Gradient {
                GradientStop { id: stop11; position: 0.0; color: '#36a9de' }
                GradientStop { id: stop12; position: 1.0; color: '#1e6ab8' }
            }
            border.color: '#4a9de0'
            border.width: 1

            Row {
                anchors.centerIn: parent
                spacing: parent.width * 0.03
                Text {
                    text: "⟳"
                    font.pixelSize: parent.parent.height * 0.45
                    color: '#ffffff'
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: qsTr("Scan for Networks")
                    font.pixelSize: parent.parent.height * 0.38
                    color: '#ffffff'
                    font.bold: true
                    font.family: "Arial"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                id: scanArea
                anchors.fill: parent
                enabled: wifiSwitch.checked
                hoverEnabled: true
                onEntered: { stop11.color = '#2674cc'; stop12.color = '#155a9e' }
                onExited:  { stop11.color = '#36a9de'; stop12.color = '#1e6ab8' }
                onClicked:  WifiManager.scanNetworks()
            }
        }

        // Divider
        Rectangle {
            width: parent.width
            height: 1
            color: '#2674cc'
            opacity: 0.3
        }

        // Connect to Hidden Networks Card
        Rectangle {
            width: parent.width
            height: connectCol.implicitHeight + wifiPage.height * 0.1
            radius: wifiPage.height * 0.02
            opacity: wifiSwitch.checked ? 1.0 : 0.4
            gradient: Gradient {
                GradientStop { position: 0.0; color: '#0d1f3c' }
                GradientStop { position: 1.0; color: '#0a1628' }
            }
            border.color: '#1a3a5c'
            border.width: 2

            Column {
                id: connectCol
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: wifiPage.width * 0.03
                spacing: wifiPage.height * 0.018

                Text {
                    text: qsTr("Connect to Hidden Networks")
                    font.pixelSize: wifiPage.height * 0.03
                    color: '#ffffff'
                    font.bold: true
                    font.family: "Arial"
                }

                // SSID Field
                Rectangle {
                    width: parent.width
                    height: wifiPage.height / 13
                    radius: height / 4
                    color: '#0a1628'
                    border.color: ssidField.activeFocus ? '#2674cc' : '#1a3a5c'
                    border.width: ssidField.activeFocus ? 2 : 1

                    TextInput {
                        id: ssidField
                        anchors.fill: parent
                        anchors.leftMargin: parent.width * 0.05
                        anchors.rightMargin: parent.width * 0.05
                        verticalAlignment: TextInput.AlignVCenter
                        font.pixelSize: parent.height * 0.38
                        color: '#ffffff'
                        font.family: "Arial"
                        enabled: wifiSwitch.checked
                        clip: true
                        Text {
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            text: qsTr("Network Name (SSID)")
                            font.pixelSize: parent.height * 0.38
                            color: '#8899bb'
                            font.family: "Arial"
                            visible: !ssidField.text && !ssidField.activeFocus
                        }
                    }
                }

                // Password Field
                Rectangle {
                    width: parent.width
                    height: wifiPage.height / 13
                    radius: height / 4
                    color: '#0a1628'
                    border.color: passField.activeFocus ? '#2674cc' : '#1a3a5c'
                    border.width: passField.activeFocus ? 2 : 1

                    TextInput {
                        id: passField
                        anchors.fill: parent
                        anchors.leftMargin: parent.width * 0.05
                        anchors.rightMargin: parent.width * 0.05
                        verticalAlignment: TextInput.AlignVCenter
                        font.pixelSize: parent.height * 0.38
                        color: '#ffffff'
                        font.family: "Arial"
                        echoMode: TextInput.Password
                        enabled: wifiSwitch.checked
                        clip: true
                        Text {
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            text: qsTr("Password")
                            font.pixelSize: parent.height * 0.38
                            color: '#8899bb'
                            font.family: "Arial"
                            visible: !passField.text && !passField.activeFocus
                        }
                        Keys.onPressed: (event) => {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                if (ssidField.text !== "" && passField.text.length >= 8)
                                    WifiManager.connectToNetwork(ssidField.text, passField.text)
                                else
                                    showToast("Enter valid SSID and password (8+ chars)", true)
                                event.accepted = true
                            }
                        }
                    }
                }

                // Connect Button
                Rectangle {
                    width: parent.width
                    height: wifiPage.height / 12
                    radius: height / 4
                    gradient: Gradient {
                        GradientStop { id: stop1; position: 0.0; color: connectArea.pressed ? '#155a9e' : '#2674cc' }
                        GradientStop { id: stop2; position: 1.0; color: connectArea.pressed ? '#0d4a85' : '#1e6ab8' }
                    }
                    border.color: '#4a9de0'
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("Connect")
                        font.pixelSize: parent.height * 0.38
                        color: '#ffffff'
                        font.bold: true
                        font.family: "Arial"
                    }

                    MouseArea {
                        id: connectArea
                        anchors.fill: parent
                        enabled: wifiSwitch.checked
                        hoverEnabled: true
                        onEntered: { stop1.color = '#155a9e'; stop2.color = '#0d4a85' }
                        onExited:  { stop1.color = '#2674cc'; stop2.color = '#1e6ab8' }
                        onClicked: {
                            if (ssidField.text !== "" && passField.text.length >= 8)
                                WifiManager.connectToNetwork(ssidField.text, passField.text)
                            else
                                showToast("Enter valid SSID and password (8+ chars)", true)
                        }
                    }
                }
            }
        }
    }

    ListModel { id: networkListModel }

    // Scan Results Popup
    Popup {
        id: scanResultsPopup
        width: parent.width * 0.8
        height: parent.height * 0.7
        anchors.centerIn: parent
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            gradient: Gradient {
                GradientStop { position: 0.0; color: '#0d1f3c' }
                GradientStop { position: 1.0; color: '#0a1628' }
            }
            radius: 10
            border.color: '#2674cc'
            border.width: 2
        }

        Column {
            anchors.fill: parent
            anchors.margins: scanResultsPopup.width * 0.05
            spacing: scanResultsPopup.height * 0.015

            // Title Row
            Row {
                width: parent.width
                height: scanResultsPopup.height * 0.1

                Text {
                    text: qsTr("Available Networks")
                    font.pixelSize: scanResultsPopup.height * 0.05
                    color: '#ffffff'
                    font.bold: true
                    font.family: "Arial"
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width - closeBtn.width
                }

                Rectangle {
                    id: closeBtn
                    width: scanResultsPopup.height * 0.08
                    height: width
                    radius: width / 2
                    color: closeBtnArea.containsMouse ? '#ff4422' : '#1a3a5c'
                    anchors.verticalCenter: parent.verticalCenter
                    Behavior on color { ColorAnimation { duration: 120 } }

                    Text {
                        anchors.centerIn: parent
                        text: "✕"
                        font.pixelSize: parent.height * 0.5
                        color: '#ffffff'
                        font.family: "Arial"
                    }
                    MouseArea {
                        id: closeBtnArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: scanResultsPopup.close()
                    }
                }
            }

            // Divider
            Rectangle {
                width: parent.width
                height: 1
                color: '#2674cc'
                opacity: 0.5
            }

            // Network count
            Text {
                text: networkListModel.count + qsTr(" networks found")
                font.pixelSize: scanResultsPopup.height * 0.032
                color: '#36a9de'
                font.family: "Arial"
            }

            // Scrollable list
            ListView {
                id: networkListView
                width: parent.width
                height: scanResultsPopup.height
                        - scanResultsPopup.height * 0.1
                        - 1
                        - scanResultsPopup.height * 0.032
                        - scanResultsPopup.width * 0.1
                        - scanResultsPopup.height * 0.015 * 3
                clip: true
                model: networkListModel
                spacing: scanResultsPopup.height * 0.015

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                    contentItem: Rectangle {
                        implicitWidth: 4
                        radius: 2
                        color: '#2674cc'
                        opacity: 0.8
                    }
                }

                Text {
                    anchors.centerIn: parent
                    visible: networkListView.count === 0
                    text: qsTr("No networks found.\nTry scanning again.")
                    font.pixelSize: scanResultsPopup.height * 0.04
                    color: '#8899bb'
                    font.family: "Arial"
                    horizontalAlignment: Text.AlignHCenter
                }

                delegate: Rectangle {
                    width: networkListView.width - 8
                    height: scanResultsPopup.height * 0.11
                    radius: height / 4
                    color: rowHover.containsMouse ? '#132a4a' : '#0d1f3c'
                    border.color: rowHover.containsMouse ? '#2674cc' : '#1a3a5c'
                    border.width: 1
                    Behavior on color { ColorAnimation { duration: 100 } }
                    Behavior on border.color { ColorAnimation { duration: 100 } }

                    // Is this the currently connected network?
                    property bool isConnected: WifiManager.connectedSsid === model.name

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: parent.width * 0.04
                        anchors.rightMargin: parent.width * 0.04
                        spacing: parent.width * 0.03

                        // Icon
                        Text {
                            text: "▲"
                            font.pixelSize: parent.parent.height * 0.4
                            color: parent.parent.isConnected ? '#36a9de' : '#36a9de'
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        // SSID
                        Text {
                            text: model.name
                            font.pixelSize: parent.parent.height * 0.4
                            color: parent.parent.isConnected ? '#36a9de' : '#ffffff'
                            font.bold: true
                            font.family: "Arial"
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                                   - selectBtn.width
                                   - parent.parent.height * 0.36
                                   - parent.spacing * 2
                            elide: Text.ElideRight
                        }

                        // Connect / Disconnect button
                        Rectangle {
                            id: selectBtn
                            width: scanResultsPopup.width * 0.26
                            height: parent.parent.height * 0.58
                            radius: height / 3
                            anchors.verticalCenter: parent.verticalCenter

                            // Green = connected, Red = not connected
                            color: {
                                if (parent.parent.isConnected)
                                    return selectArea.containsMouse ? '#1a5a99' : '#2674cc'
                                return selectArea.containsMouse ? '#1a5a99' : '#2674cc'
                            }
                            Behavior on color { ColorAnimation { duration: 150 } }

                            Text {
                                anchors.centerIn: parent
                                // Text changes based on state
                                text: parent.parent.parent.isConnected
                                      ? qsTr("Connected") : qsTr("Connect")
                                font.pixelSize: parent.height * 0.36
                                color: '#ffffff'
                                font.bold: true
                                font.family: "Arial"
                            }

                            MouseArea {
                                id: selectArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (parent.parent.parent.isConnected) {
                                        // Already connected → disconnect
                                        WifiManager.disconnectFromNetwork()
                                        scanResultsPopup.close()
                                    } else {
                                        // Not connected → connect
                                        WifiManager.connectToSelectedNetwork(model.name)
                                        scanResultsPopup.close()
                                    }
                                }
                            }
                        }
                    }

                    MouseArea {
                        id: rowHover
                        anchors.fill: parent
                        hoverEnabled: true
                        propagateComposedEvents: true
                        z: -1
                        onClicked: (mouse) => mouse.accepted = false
                    }
                }
            }
        }
    }

    // Password Popup
    Popup {
        id: passwordPopup
        width: parent.width * 0.7
        height: parent.height * 0.38
        anchors.centerIn: parent
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            gradient: Gradient {
                GradientStop { position: 0.0; color: '#0d1f3c' }
                GradientStop { position: 1.0; color: '#0a1628' }
            }
            radius: 10
            border.color: '#2674cc'
            border.width: 2
        }

        Column {
            anchors.fill: parent
            anchors.margins: passwordPopup.width * 0.06
            spacing: wifiPage.height * 0.02

            Text {
                id: passwordPopupSsid
                font.pixelSize: wifiPage.height * 0.028
                color: '#36a9de'
                font.bold: true
                font.family: "Arial"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: qsTr("Enter password to connect")
                font.pixelSize: wifiPage.height * 0.022
                color: '#ffffff'
                font.family: "Arial"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                width: parent.width
                height: wifiPage.height / 13
                radius: height / 4
                color: '#0a1628'
                border.color: popupPassField.activeFocus ? '#2674cc' : '#1a3a5c'
                border.width: popupPassField.activeFocus ? 2 : 1

                TextInput {
                    id: popupPassField
                    anchors.fill: parent
                    anchors.leftMargin: parent.width * 0.05
                    anchors.rightMargin: parent.width * 0.05
                    verticalAlignment: TextInput.AlignVCenter
                    font.pixelSize: parent.height * 0.38
                    color: '#ffffff'
                    font.family: "Arial"
                    echoMode: TextInput.Password
                    clip: true
                    Text {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("Password")
                        font.pixelSize: parent.height * 0.38
                        color: '#8899bb'
                        font.family: "Arial"
                        visible: !popupPassField.text && !popupPassField.activeFocus
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            if (popupPassField.text.length >= 8) {
                                WifiManager.connectToNetwork(passwordPopupSsid.text, popupPassField.text)
                                popupPassField.text = ""
                                passwordPopup.close()
                            } else {
                                showToast("Password must be 8+ characters", true)
                            }
                            event.accepted = true
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: wifiPage.height / 12
                radius: height / 4
                color: popupConnectArea.containsMouse ? '#155a9e' : '#2674cc'
                Behavior on color { ColorAnimation { duration: 100 } }

                Text {
                    anchors.centerIn: parent
                    text: qsTr("Connect")
                    font.pixelSize: parent.height * 0.38
                    color: '#ffffff'
                    font.bold: true
                    font.family: "Arial"
                }

                MouseArea {
                    id: popupConnectArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if (popupPassField.text.length >= 8) {
                            WifiManager.connectToNetwork(passwordPopupSsid.text, popupPassField.text)
                            popupPassField.text = ""
                            passwordPopup.close()
                        } else {
                            showToast("Password must be 8+ characters", true)
                        }
                    }
                }
            }
        }
    }

    // Status Toast
    Rectangle {
        id: statusToast
        width: parent.width * 0.5
        height: parent.height * 0.08
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.05
        radius: height / 2
        color: statusToast.isError ? '#3d0a00' : '#0a1f3a'
        border.color: statusToast.isError ? '#ff4422' : '#2674cc'
        border.width: 1
        opacity: 0
        visible: opacity > 0
        z: 20
        property bool isError: false
        Behavior on opacity { NumberAnimation { duration: 400 } }

        Text {
            id: toastText
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.3
            color: statusToast.isError ? '#ff8a7a' : '#36a9de'
            font.family: "Arial"
            font.bold: true
        }
        Timer {
            id: toastTimer
            interval: 3000
            onTriggered: statusToast.opacity = 0
        }
    }

    function showToast(message, isError) {
        toastText.text = message
        statusToast.isError = isError
        statusToast.opacity = 1
        toastTimer.restart()
    }

    // Back Button
    Rectangle {
        width: parent.width / 6.5
        height: parent.height / 15
        color: '#ffffff'
        radius: height / 4
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: parent.height * 0.05
        anchors.leftMargin: parent.width * 0.05
        border.color: '#2674cc'
        border.width: 2

        Text {
            text: qsTr("Back")
            font.pixelSize: height * 0.8
            color: '#0d1f3c'
            font.bold: true
            font.family: "Arial"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.color = '#d6e6f5'
            onExited:  parent.color = '#ffffff'
            onClicked: wifiPage.stackView.pop()
        }
    }
}