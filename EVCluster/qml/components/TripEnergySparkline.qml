import QtQuick
import EVCluster

Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property var dataPoints: [22,18,24,30,26,16,12,14,19,21,17,15,18,23,28,24,20,17,19,22]
    property real averageValue: 20.3
    property string averageUnit: "kWh / 100km avg"
    property string headerLabel: "TRIP ENERGY · LAST 10 KM"

    // ===========================
    // Sizing — spec: 520×54
    // ===========================
    implicitWidth: 520
    implicitHeight: 54

    // Data range
    readonly property real yMin: 8
    readonly property real yMax: 32
    readonly property real chartHeight: 30
    readonly property real chartWidth: width

    // ===========================
    // Header row
    // ===========================
    // Left label
    Text {
        id: headerLeft
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.baseline: avgValue.baseline
        text: root.headerLabel
        font.family: Theme.fonts.ui
        font.weight: Theme.fonts.weightMedium
        font.pixelSize: 10
        font.letterSpacing: 3.2    // 0.32em × 10px
        color: Theme.colors.textMuted
    }

    // Right: average value + unit
    Row {
        id: avgRow
        anchors.top: parent.top
        anchors.right: parent.right
        spacing: 4

        Text {
            id: avgValue
            text: root.averageValue.toFixed(1)
            font.family: Theme.fonts.display
            font.weight: Theme.fonts.weightLight
            font.pixelSize: 16
            font.features: { "tnum": 1 }
            color: Theme.colors.textPrimary
        }

        Text {
            anchors.baseline: avgValue.baseline
            text: root.averageUnit
            font.family: Theme.fonts.ui
            font.weight: Theme.fonts.weightLight
            font.pixelSize: 11
            font.letterSpacing: 2.2   // 0.2em × 11px
            color: Qt.rgba(0.58, 0.64, 0.72, 0.65)
        }
    }

    // ===========================
    // Sparkline chart (Canvas)
    // ===========================
    Canvas {
        id: sparkCanvas
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: root.chartHeight

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var pts = root.dataPoints
            if (pts.length < 2) return

            var w = width, h = height
            var stepX = w / (pts.length - 1)

            // Convert data to canvas coords
            function yPos(val) {
                var normalized = (val - root.yMin) / (root.yMax - root.yMin)
                return h - (normalized * h)
            }

            // ===========================
            // Area fill gradient (top: accent blue 55% → bottom: transparent)
            // ===========================
            var areaGrad = ctx.createLinearGradient(0, 0, 0, h)
            areaGrad.addColorStop(0, Qt.rgba(0.37, 0.66, 1.0, 0.55))
            areaGrad.addColorStop(1, "transparent")

            ctx.beginPath()
            ctx.moveTo(0, yPos(pts[0]))
            for (var i = 1; i < pts.length; i++) {
                ctx.lineTo(i * stepX, yPos(pts[i]))
            }
            // Close area to bottom
            ctx.lineTo((pts.length - 1) * stepX, h)
            ctx.lineTo(0, h)
            ctx.closePath()
            ctx.fillStyle = areaGrad
            ctx.fill()

            // ===========================
            // Stroke line gradient (left: #bfdbfe → right: #5fa8ff)
            // ===========================
            var strokeGrad = ctx.createLinearGradient(0, 0, w, 0)
            strokeGrad.addColorStop(0, "#bfdbfe")
            strokeGrad.addColorStop(1, "#5fa8ff")

            ctx.beginPath()
            ctx.moveTo(0, yPos(pts[0]))
            for (var j = 1; j < pts.length; j++) {
                ctx.lineTo(j * stepX, yPos(pts[j]))
            }
            ctx.strokeStyle = strokeGrad
            ctx.lineWidth = 1.4
            ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.stroke()

            // ===========================
            // Baseline
            // ===========================
            ctx.beginPath()
            ctx.moveTo(0, h - 0.5)
            ctx.lineTo(w, h - 0.5)
            ctx.strokeStyle = Qt.rgba(0.58, 0.64, 0.72, 0.18)
            ctx.lineWidth = 1
            ctx.stroke()

            // ===========================
            // End dot — outer ring + inner white dot
            // ===========================
            var lastX = (pts.length - 1) * stepX
            var lastY = yPos(pts[pts.length - 1])

            // Outer glow
            ctx.beginPath()
            ctx.arc(lastX, lastY, 5, 0, 2 * Math.PI)
            ctx.fillStyle = Qt.rgba(0.37, 0.66, 1.0, 0.35)
            ctx.fill()

            // Inner dot
            ctx.beginPath()
            ctx.arc(lastX, lastY, 2.4, 0, 2 * Math.PI)
            ctx.fillStyle = "#ffffff"
            ctx.fill()
        }

        Component.onCompleted: requestPaint()
    }
}
