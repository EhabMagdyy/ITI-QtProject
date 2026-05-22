import QtQuick
import QtQuick.Shapes
import EVCluster
import QtQuick.Effects


Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property real value: 0.5         // 0.0 to 1.0 (battery level)
    property int rangeKm: 0          // remaining range in km
    property bool isCharging: false


    property bool showHeaderLabel: true
    property string headerLabel: "BATTERY"
    property bool showStatusLabel: true   // "Charging" / "Healthy" etc
    // ===========================
    // Sizing
    // ===========================
    implicitWidth: Theme.sizes.batteryRingSize
    implicitHeight: Theme.sizes.batteryRingSize


    // ===========================
    // Interpolated values for smooth animation
    // ===========================
    property real animatedValue: value
    property real animatedRangeKm: rangeKm

    Behavior on animatedValue {
        NumberAnimation {
            duration: 800
            easing.type: Easing.OutQuad
        }
    }

    Behavior on animatedRangeKm {
        NumberAnimation {
            duration: 800
            easing.type: Easing.OutQuad
        }
    }

    // ===========================
    // Internal geometry
    // ===========================
    readonly property real centerX: width / 2
    readonly property real centerY: height / 2
    readonly property real radius: (Math.min(width, height) / 2) - Theme.sizes.batteryRingStrokeWidth

    // Arc spans from -240° (start) to +60° (end) — 300° span, smaller bottom gap
    readonly property real startAngleDeg: -220
    readonly property real endAngleDeg: 40
    readonly property real arcSpanDeg: endAngleDeg - startAngleDeg   // = 260°

    // Clamp value
    readonly property real clampedValue: Math.max(0, Math.min(1, animatedValue))   // ⬅ CHANGED

    // Current end angle based on value
    readonly property real currentEndAngleDeg: startAngleDeg + (arcSpanDeg * clampedValue)

    // Color based on battery level
    readonly property color arcColor: {
        if (isCharging) return Theme.colors.batteryCharging
        if (clampedValue > 0.5) return Theme.colors.batteryHealthy
        if (clampedValue > 0.2) return Theme.colors.batteryWarning
        return Theme.colors.batteryCritical
    }

    // Convert degrees to radians
    function degToRad(deg) {
        return deg * Math.PI / 180
    }

    // Get point on circle at given angle (degrees)
    function pointOnCircle(angleDeg, r) {
        const rad = degToRad(angleDeg)
        return {
            x: centerX + r * Math.cos(rad),
            y: centerY + r * Math.sin(rad)
        }
    }

    // ===========================
    // Background arc (full)
    // ===========================
    Shape {
        anchors.fill: parent
        smooth: true

        ShapePath {
            strokeWidth: Theme.sizes.batteryRingStrokeWidth
            strokeColor: Theme.colors.powerBarBg
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap

            startX: root.pointOnCircle(root.startAngleDeg, root.radius).x
            startY: root.pointOnCircle(root.startAngleDeg, root.radius).y

            PathArc {
                x: root.pointOnCircle(root.endAngleDeg, root.radius).x
                y: root.pointOnCircle(root.endAngleDeg, root.radius).y
                radiusX: root.radius
                radiusY: root.radius
                useLargeArc: true
                direction: PathArc.Clockwise
            }
        }
    }
    // ===========================
        // Outer glow ring (subtle white-to-transparent)
        // ===========================
        Shape {
            anchors.fill: parent
            smooth: true

            ShapePath {
                strokeWidth: 1.2
                strokeColor: Qt.rgba(1, 1, 1, 0.10)
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap

                startX: root.pointOnCircle(root.startAngleDeg, root.radius + 18).x
                startY: root.pointOnCircle(root.startAngleDeg, root.radius + 18).y

                PathArc {
                    x: root.pointOnCircle(root.endAngleDeg, root.radius + 18).x
                    y: root.pointOnCircle(root.endAngleDeg, root.radius + 18).y
                    radiusX: root.radius + 18
                    radiusY: root.radius + 18
                    useLargeArc: true
                    direction: PathArc.Clockwise
                }
            }
        }
    // ===========================
    // Foreground arc (filled portion)
    // ===========================
    Shape {
         id: foregroundArc
        anchors.fill: parent
        smooth: true

        ShapePath {
            strokeWidth: Theme.sizes.batteryRingStrokeWidth
            strokeColor: root.arcColor
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            startX: root.pointOnCircle(root.startAngleDeg, root.radius).x
            startY: root.pointOnCircle(root.startAngleDeg, root.radius).y

            PathArc {
                x: root.pointOnCircle(root.currentEndAngleDeg, root.radius).x
                y: root.pointOnCircle(root.currentEndAngleDeg, root.radius).y
                radiusX: root.radius
                radiusY: root.radius
                useLargeArc: (root.currentEndAngleDeg - root.startAngleDeg) > 180
                direction: PathArc.Clockwise
            }

            Behavior on strokeColor { ColorAnimation { duration: 500 } }
        }
    }
    MultiEffect {
            source: foregroundArc
            anchors.fill: foregroundArc
            autoPaddingEnabled: true
            shadowEnabled: true
            shadowColor: root.arcColor
            shadowBlur: 0.8
            shadowOpacity: 0.5
            blurMax: 16
        }

    MultiEffect {
           source: foregroundArc
           anchors.fill: foregroundArc
           autoPaddingEnabled: true
           shadowEnabled: true
           shadowColor: root.arcColor
           shadowBlur: 0.2
           shadowOpacity: 0.5
           blurMax: 8
       }
    // ===========================
    // End cap (dot at the current value)
    // ===========================
    Rectangle {
        id: endCap
        width: Theme.sizes.batteryRingStrokeWidth + 6
        height: width
        radius: width / 2
        color: root.arcColor

        x: root.pointOnCircle(root.currentEndAngleDeg, root.radius).x - width / 2
        y: root.pointOnCircle(root.currentEndAngleDeg, root.radius).y - height / 2

        Behavior on color { ColorAnimation { duration: 500 } }
    }
    // Inner white dot on end cap
        Rectangle {
            width: 5
            height: 5
            radius: 2.5
            color: "#ffffff"
            x: root.pointOnCircle(root.currentEndAngleDeg, root.radius).x - 2.5
            y: root.pointOnCircle(root.currentEndAngleDeg, root.radius).y - 2.5
        }
    // ===========================
        // Charge bolt icon — at 100% position on the arc
        // ===========================
        Canvas {
            id: chargeBolt
            visible: true
            width: 36; height: 36

            readonly property var pos100: root.pointOnCircle(root.endAngleDeg, root.radius + 28)

            x: pos100.x - width / 2
            y: pos100.y - height / 2

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

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

                ctx.fillStyle = Qt.rgba(root.arcColor.r, root.arcColor.g, root.arcColor.b, 0.7)
                ctx.fill()

                ctx.strokeStyle = root.arcColor
                ctx.lineWidth = 1.5
                ctx.lineJoin = "round"
                ctx.stroke()

                ctx.restore()
            }

            Component.onCompleted: requestPaint()

            Connections {
                target: root
                function onArcColorChanged() { chargeBolt.requestPaint() }
            }
            // Pulse animation
            SequentialAnimation on opacity {
                running: root.isCharging
                loops: Animation.Infinite
                NumberAnimation { from: 0.7; to: 1.0; duration: 900; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 1.0; to: 0.7; duration: 900; easing.type: Easing.InOutQuad }
            }
        }
    // ===========================
    // Tick marks around the ring
    // ===========================
    Repeater {
        model: Theme.sizes.batteryTickCount

        Rectangle {
            id: tick
            width: 1
            height: Theme.sizes.batteryTickLength
            color: (tick.tickAngleDeg <= root.currentEndAngleDeg) ? "#cbd5e1" : Theme.colors.powerTickMark
                      opacity: (tick.tickAngleDeg <= root.currentEndAngleDeg) ? 0.9 : 0.5

            readonly property real tickAngleDeg:
                root.startAngleDeg + (root.arcSpanDeg / (Theme.sizes.batteryTickCount - 1)) * index
            readonly property real tickRadius: root.radius + Theme.sizes.batteryRingStrokeWidth / 2 + 8

            x: root.centerX + tickRadius * Math.cos(root.degToRad(tickAngleDeg)) - width / 2
            y: root.centerY + tickRadius * Math.sin(root.degToRad(tickAngleDeg)) - height / 2

            transform: Rotation {
                origin.x: tick.width / 2
                origin.y: tick.height / 2
                angle: tick.tickAngleDeg + 90
            }
        }
    }

    // ===========================
        // Tick number labels: 0, 50, 100
        // ===========================
        Repeater {
            model: [
                { label: "0",   index: 0 },
                { label: "50",  index: 0.5 },
                { label: "100", index: 1.0 }
            ]

            Text {
                readonly property real labelAngleDeg:
                    root.startAngleDeg + (root.arcSpanDeg * modelData.index)
                readonly property real labelRadius: root.radius - 24

                x: root.centerX + labelRadius * Math.cos(root.degToRad(labelAngleDeg)) - implicitWidth / 2
                y: root.centerY + labelRadius * Math.sin(root.degToRad(labelAngleDeg)) - implicitHeight / 2

                text: modelData.label
                font.family: Theme.fonts.uiCondensed
                font.weight: Theme.fonts.weightLight
                font.pixelSize: 13
                font.letterSpacing: 2
                color: Qt.rgba(0.58, 0.64, 0.72, 0.55)
            }
        }
    // ===========================
    // Center labels
    // ===========================
    // Column {
    //     anchors.centerIn: parent
    //     spacing: 4

    //     Text {
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         text: Math.round(root.clampedValue * 100) + "%"
    //         font.family: Theme.fonts.display
    //         font.weight: Theme.fonts.weightLight
    //         font.pixelSize: 48
    //         font.features: { "tnum": 1 }
    //         color: Theme.colors.textPrimary
    //     }

    //     Text {
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         text: Math.round(root.animatedRangeKm) + " km"
    //         font.family: Theme.fonts.ui
    //         font.weight: Theme.fonts.weightLight
    //         font.pixelSize: 14
    //         font.letterSpacing: 2
    //         color: Theme.colors.textTertiary
    //     }
    // }

    // ===========================
    // External labels (HEADER + STATUS)
    // ===========================

    // "BATTERY" label - top left of the ring
    Text {
        id: headerText
        visible: root.showHeaderLabel
        anchors.bottom: parent.top
        anchors.bottomMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 30
        text: root.headerLabel
        font.family: Theme.fonts.ui
        font.weight: Theme.fonts.weightMedium
        font.pixelSize: 11
        font.letterSpacing: 4
        color: Theme.colors.textTertiary
    }

    // "Charging" / status label - top right of the ring
    Text {
        id: statusText
         visible: root.showStatusLabel && root.isCharging
        anchors.bottom: parent.top
        anchors.bottomMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 30
        text: root.isCharging ? "Charging" : ""
        font.family: Theme.fonts.ui
        font.weight: Theme.fonts.weightLight
        font.pixelSize: 14
        color: root.isCharging ? Theme.colors.batteryCharging : Theme.colors.textTertiary
    }

}
