import QtQuick
import EVCluster

Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property string iconType: ""         // signalLeft, signalRight, lowBeam, highBeam, autoHold, seatbelt, brakeWarning, hazard
    property bool active: false
    property color activeColor: "#ffffff"
    property bool blinking: false

    // ===========================
    // Sizing — spec: 30×30 container, 24×24 icon
    // ===========================
    width: 30; height: 30

    // ===========================
    // Blink timer — hard toggle at 850ms (steps(1,end))
    // ===========================
    property bool blinkVisible: true

    Timer {
        id: blinkTimer
        interval: 425   // half of 850ms cycle
        running: root.blinking && root.active
        repeat: true
        onTriggered: root.blinkVisible = !root.blinkVisible
    }

    onBlinkingChanged: {
        if (!blinking) blinkVisible = true
    }

    // ===========================
    // Icon drawing
    // ===========================
    Canvas {
        id: iconCanvas
        anchors.centerIn: parent
        width: 24; height: 24

        opacity: {
            if (!root.active) return 0.32
            if (root.blinking) return root.blinkVisible ? 1.0 : 0.15
            return 1.0
        }

        Behavior on opacity {
            // No behavior for blink (instant), smooth for on/off
            enabled: !root.blinking
            NumberAnimation { duration: 200 }
        }

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var c = root.active ? root.activeColor : Qt.rgba(0.58, 0.64, 0.72, 0.32)
            ctx.fillStyle = c
            ctx.strokeStyle = c
            ctx.lineWidth = 2

            switch (root.iconType) {
            case "signalLeft":
                drawSignalLeft(ctx)
                break
            case "signalRight":
                drawSignalRight(ctx)
                break
            case "lowBeam":
                drawLowBeam(ctx)
                break
            case "highBeam":
                drawHighBeam(ctx)
                break
            case "autoHold":
                drawAutoHold(ctx)
                break
            case "seatbelt":
                drawSeatbelt(ctx)
                break
            case "brakeWarning":
                drawBrakeWarning(ctx)
                break
            case "hazard":
                drawHazard(ctx)
                break
            }
        }

        onVisibleChanged: requestPaint()
        Component.onCompleted: requestPaint()

        // Repaint when active state changes
        Connections {
            target: root
            function onActiveChanged() { iconCanvas.requestPaint() }
            function onActiveColorChanged() { iconCanvas.requestPaint() }
        }

        // ===========================
        // Drawing functions — from spec SVG paths
        // Scaled to fit 24×24, offset by ~-4 from the 32×32 viewBox
        // ===========================

        function drawSignalLeft(ctx) {
            // Arrow left + bar: M22 8 L10 16 L22 24 Z M14 14 L26 14 L26 18 L14 18 Z
            // Scale from viewBox 32 → 24: multiply by 0.75
            ctx.beginPath()
            ctx.moveTo(16.5, 6)
            ctx.lineTo(7.5, 12)
            ctx.lineTo(16.5, 18)
            ctx.closePath()
            ctx.fill()

            ctx.fillRect(10.5, 10.5, 9, 3)
        }

        function drawSignalRight(ctx) {
            // Mirror: M10 8 L22 16 L10 24 Z M6 14 L18 14 L18 18 L6 18 Z
            ctx.beginPath()
            ctx.moveTo(7.5, 6)
            ctx.lineTo(16.5, 12)
            ctx.lineTo(7.5, 18)
            ctx.closePath()
            ctx.fill()

            ctx.fillRect(4.5, 10.5, 9, 3)
        }

        function drawLowBeam(ctx) {
            // Headlamp body + 3 diverging beams
            ctx.fillStyle = Qt.rgba(ctx.fillStyle.r || 1, ctx.fillStyle.g || 1, ctx.fillStyle.b || 1, 0.25)

            // Lamp body (half ellipse)
            ctx.beginPath()
            ctx.moveTo(4, 12)
            ctx.bezierCurveTo(4, 7, 8, 4, 13, 4)
            ctx.lineTo(13, 20)
            ctx.bezierCurveTo(8, 20, 4, 17, 4, 12)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()

            // 3 beams
            ctx.beginPath()
            ctx.moveTo(15, 8);  ctx.lineTo(20, 6)
            ctx.moveTo(15, 12); ctx.lineTo(21, 12)
            ctx.moveTo(15, 16); ctx.lineTo(20, 18)
            ctx.stroke()
        }

        function drawHighBeam(ctx) {
            // Headlamp body + 5 parallel beams
            ctx.fillStyle = Qt.rgba(ctx.fillStyle.r || 1, ctx.fillStyle.g || 1, ctx.fillStyle.b || 1, 0.25)

            ctx.beginPath()
            ctx.moveTo(4, 12)
            ctx.bezierCurveTo(4, 7, 8, 4, 13, 4)
            ctx.lineTo(13, 20)
            ctx.bezierCurveTo(8, 20, 4, 17, 4, 12)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()

            // 5 parallel beams
            ctx.beginPath()
            ctx.moveTo(15, 6);  ctx.lineTo(21, 6)
            ctx.moveTo(15, 9);  ctx.lineTo(21, 9)
            ctx.moveTo(15, 12); ctx.lineTo(21, 12)
            ctx.moveTo(15, 15); ctx.lineTo(21, 15)
            ctx.moveTo(15, 18); ctx.lineTo(21, 18)
            ctx.stroke()
        }

        function drawAutoHold(ctx) {
            ctx.fillStyle = Qt.rgba(ctx.fillStyle.r || 1, ctx.fillStyle.g || 1, ctx.fillStyle.b || 1, 0.22)

            ctx.beginPath()
            ctx.moveTo(4, 12)
            ctx.bezierCurveTo(4, 7, 8, 4, 13, 4)
            ctx.lineTo(13, 20)
            ctx.bezierCurveTo(8, 20, 4, 17, 4, 12)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()

            // "A" letter
            ctx.fillStyle = root.active ? root.activeColor : Qt.rgba(0.58, 0.64, 0.72, 0.32)
            ctx.font = "600 10px Saira"
            ctx.textAlign = "center"
            ctx.textBaseline = "middle"
            ctx.fillText("A", 17, 12)
        }

        function drawSeatbelt(ctx) {
            ctx.lineWidth = 2
            ctx.lineCap = "round"

            // Head circle
            ctx.beginPath()
            ctx.arc(12, 6, 2.5, 0, 2 * Math.PI)
            ctx.stroke()

            // Body lines
            ctx.beginPath()
            ctx.moveTo(8, 20); ctx.lineTo(10, 10)
            ctx.moveTo(16, 20); ctx.lineTo(14, 10)
            ctx.stroke()

            // Belt across
            ctx.beginPath()
            ctx.moveTo(8, 16); ctx.lineTo(16, 16)
            ctx.stroke()
        }

        function drawBrakeWarning(ctx) {
            ctx.lineWidth = 2

            // Disc shape (half circle + base)
            ctx.beginPath()
            ctx.moveTo(4, 16)
            ctx.bezierCurveTo(4, 10, 8, 7, 12, 7)
            ctx.bezierCurveTo(16, 7, 20, 10, 20, 16)
            ctx.closePath()
            ctx.stroke()

            // Base line
            ctx.beginPath()
            ctx.moveTo(4, 16); ctx.lineTo(20, 16)
            ctx.stroke()

            // "!" exclamation
            ctx.fillStyle = root.active ? root.activeColor : Qt.rgba(0.58, 0.64, 0.72, 0.32)
            ctx.font = "500 8px Saira"
            ctx.textAlign = "center"
            ctx.textBaseline = "middle"
            ctx.fillText("!", 12, 13)
        }

        function drawHazard(ctx) {
            ctx.lineWidth = 2
            ctx.fillStyle = Qt.rgba(ctx.fillStyle.r || 1, ctx.fillStyle.g || 1, ctx.fillStyle.b || 1, 0.15)

            // Triangle
            ctx.beginPath()
            ctx.moveTo(12, 4)
            ctx.lineTo(21, 19)
            ctx.lineTo(3, 19)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()

            // "!" inside
            ctx.fillStyle = root.active ? root.activeColor : Qt.rgba(0.58, 0.64, 0.72, 0.32)
            ctx.beginPath()
            ctx.moveTo(12, 10); ctx.lineTo(12, 15)
            ctx.stroke()

            ctx.beginPath()
            ctx.arc(12, 17, 1, 0, 2 * Math.PI)
            ctx.fill()
        }
    }
}
