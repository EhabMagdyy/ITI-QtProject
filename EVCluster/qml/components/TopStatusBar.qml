import QtQuick
import QtQuick.Shapes
import EVCluster

Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property bool leftSignal: false
    property bool rightSignal: true
    property bool lowBeam: true
    property bool highBeam: true
    property bool autoHold: true
    property bool seatbelt: true
    property bool brakeWarning: false
    property bool hazardWarning: false

    property string driveMode: "SPORT"       // SPORT, COMFORT, ECO
    property bool awdActive: true
    property bool assistReady: true

    // ===========================
    // Sizing — spec: 1024×54
    // ===========================
    implicitWidth: Theme.layout.clusterWidth
    implicitHeight: 54

    // ===========================
    // Bottom border line
    // ===========================
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        color: Qt.rgba(1, 1, 1, 0.04)
    }

    // ===========================
    // Bottom glow accent line (center 60%)
    // ===========================
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -1
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.6
        height: 1
        opacity: 0.55

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: Theme.colors.accentBlueSoft }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    // ===========================
    // LEFT TELLTALE GROUP
    // ===========================
    Row {
        id: leftGroup
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.verticalCenter: parent.verticalCenter
        spacing: 18

        // Left turn signal (blinking)
        TelltaleIcon {
            iconType: "signalLeft"
            active: root.leftSignal
            activeColor: Theme.colors.semanticSuccess
            blinking: root.leftSignal
        }

        // Low beam
        TelltaleIcon {
            iconType: "lowBeam"
            active: root.lowBeam
            activeColor: "#ffffff"
        }

        // High beam
        TelltaleIcon {
            iconType: "highBeam"
            active: root.highBeam
            activeColor: Theme.colors.semanticInfo
        }

        // Auto-hold
        TelltaleIcon {
            iconType: "autoHold"
            active: root.autoHold
            activeColor: Theme.colors.semanticSuccess
        }
    }

    // ===========================
    // CENTER TELLTALE (seatbelt)
    // ===========================
    TelltaleIcon {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        iconType: "seatbelt"
        active: root.seatbelt
        activeColor: "#ffffff"
    }

    // ===========================
    // RIGHT TELLTALE GROUP
    // ===========================
    Row {
        id: rightGroup
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.verticalCenter: parent.verticalCenter
        spacing: 18

        // Brake warning
        TelltaleIcon {
            iconType: "brakeWarning"
            active: root.brakeWarning
            activeColor: Theme.colors.accentAmber
        }

        // Hazard
        TelltaleIcon {
            iconType: "hazard"
            active: root.hazardWarning
            activeColor: "#ffffff"
        }

        // Right turn signal (blinking)
        TelltaleIcon {
            iconType: "signalRight"
            active: root.rightSignal
            activeColor: Theme.colors.semanticSuccess
            blinking: root.rightSignal
        }
    }

    // ===========================
    // MODE BANNER — centered, y=34 from top of cluster
    // Positioned below the telltale bar
    // ===========================
    Row {
        id: modeBanner
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -26
        spacing: 10

        // Blue dot
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 6; height: 6
            radius: 3
            color: Theme.colors.accentBlue
        }

        // Mode name
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.driveMode
            font.family: Theme.fonts.ui
            font.weight: Theme.fonts.weightMedium
            font.pixelSize: 11
            font.letterSpacing: 4.62   // 0.42em × 11px
            color: Qt.rgba(0.886, 0.910, 0.941, 0.85)
        }

        // Separator 1
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 34; height: 1
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: Qt.rgba(0.37, 0.66, 1.0, 0.6) }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        // AWD icon (simplified chassis)
        Item {
            anchors.verticalCenter: parent.verticalCenter
            width: 18; height: 18
            visible: root.awdActive

            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.strokeStyle = Qt.rgba(0.58, 0.64, 0.72, 0.85)
                    ctx.lineWidth = 1.4
                    ctx.fillStyle = Qt.rgba(0.58, 0.64, 0.72, 0.85)

                    // Chassis body
                    var bx = 3, by = 2, bw = 12, bh = 14, br = 1
                    ctx.beginPath()
                    ctx.roundedRect(bx, by, bw, bh, br, br)
                    ctx.stroke()

                    // 4 wheels
                    var wr = 1.8
                    var positions = [[bx, by], [bx + bw, by], [bx, by + bh], [bx + bw, by + bh]]
                    for (var i = 0; i < 4; i++) {
                        ctx.beginPath()
                        ctx.arc(positions[i][0], positions[i][1], wr, 0, 2 * Math.PI)
                        ctx.fill()
                    }
                }
            }
        }

        // AWD text
        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.awdActive
            text: "AWD"
            font.family: Theme.fonts.ui
            font.weight: Theme.fonts.weightMedium
            font.pixelSize: 11
            font.letterSpacing: 4.62
            color: Qt.rgba(0.58, 0.64, 0.72, 0.85)
        }

        // Separator 2
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 34; height: 1
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: Qt.rgba(0.37, 0.66, 1.0, 0.6) }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        // Assist icon (dashed circle + dot + lines)
        Item {
            anchors.verticalCenter: parent.verticalCenter
            width: 18; height: 18
            visible: root.assistReady

            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    var cx = 9, cy = 9
                    ctx.strokeStyle = Qt.rgba(0.58, 0.64, 0.72, 0.65)
                    ctx.fillStyle = Qt.rgba(0.58, 0.64, 0.72, 0.65)
                    ctx.lineWidth = 1.4

                    // Dashed outer circle
                    ctx.setLineDash([2, 2])
                    ctx.beginPath()
                    ctx.arc(cx, cy, 7, 0, 2 * Math.PI)
                    ctx.stroke()

                    // Center dot
                    ctx.setLineDash([])
                    ctx.beginPath()
                    ctx.arc(cx, cy, 2, 0, 2 * Math.PI)
                    ctx.fill()

                    // 3 directional lines
                    ctx.beginPath()
                    ctx.moveTo(cx, cy - 2); ctx.lineTo(cx, cy - 7)    // top
                    ctx.moveTo(cx - 2, cy + 1); ctx.lineTo(cx - 6, cy + 4) // bottom-left
                    ctx.moveTo(cx + 2, cy + 1); ctx.lineTo(cx + 6, cy + 4) // bottom-right
                    ctx.stroke()
                }
            }
        }

        // Assist text
        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.assistReady
            text: "ASSIST READY"
            font.family: Theme.fonts.ui
            font.weight: Theme.fonts.weightMedium
            font.pixelSize: 11
            font.letterSpacing: 4.62
            color: Qt.rgba(0.58, 0.64, 0.72, 0.65)
        }
    }
}
