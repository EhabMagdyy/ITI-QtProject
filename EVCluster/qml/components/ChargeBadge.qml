import QtQuick
import EVCluster

Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property bool charging: false

    // ===========================
    // Sizing — spec: 56×56
    // ===========================
    width: 56; height: 56
    visible: charging

    // ===========================
    // Glow background circle
    // ===========================
    Rectangle {
        id: glowBg
        anchors.fill: parent
        radius: 28
        color: "transparent"

        // Radial gradient approximation
        Rectangle {
            anchors.fill: parent
            radius: 28
            color: Qt.rgba(0.133, 0.827, 0.933, 0.20)
            opacity: pulseAnim.running ? root._pulseOpacity : 0.7
        }
    }

    // ===========================
    // Outer glow ring
    // ===========================
    Rectangle {
        anchors.centerIn: parent
        width: parent.width + 16
        height: width
        radius: width / 2
        color: "transparent"
        border.color: Qt.rgba(0.133, 0.827, 0.933, 0.25)
        border.width: 1
        opacity: root._pulseOpacity
    }

    // ===========================
    // Bolt icon (Canvas)
    // Path: M19 3 L8 18 L14 18 L12 29 L24 13 L18 13 Z
    // viewBox 0 0 32 32, drawn at 36×36
    // ===========================
    Canvas {
        id: boltCanvas
        anchors.centerIn: parent
        width: 36; height: 36

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            // Scale from viewBox 32 → 36
            var s = 36 / 32

            ctx.save()
            ctx.scale(s, s)

            ctx.beginPath()
            ctx.moveTo(19, 3)
            ctx.lineTo(8, 18)
            ctx.lineTo(14, 18)
            ctx.lineTo(12, 29)
            ctx.lineTo(24, 13)
            ctx.lineTo(18, 13)
            ctx.closePath()

            ctx.fillStyle = Qt.rgba(0.133, 0.827, 0.933, 0.7)   // #22d3ee @ 70%
            ctx.fill()

            ctx.strokeStyle = "#67e8f9"
            ctx.lineWidth = 1.5
            ctx.lineJoin = "round"
            ctx.stroke()

            ctx.restore()
        }

        Component.onCompleted: requestPaint()
    }

    // ===========================
    // Pulse animation — spec: chargePulse 1.6s ease-in-out infinite
    // ===========================
    property real _pulseOpacity: 0.55

    SequentialAnimation {
        id: pulseAnim
        running: root.charging
        loops: Animation.Infinite

        NumberAnimation {
            target: root
            property: "_pulseOpacity"
            from: 0.55; to: 0.95
            duration: 800
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: root
            property: "_pulseOpacity"
            from: 0.95; to: 0.55
            duration: 800
            easing.type: Easing.InOutQuad
        }
    }
}
