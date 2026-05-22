import QtQuick
import QtQuick.Shapes
import EVCluster

Item {
    id: root
    
    // ===========================
    // Public API
    // ===========================
    property real value: 0          // current power in kW
    property real minValue: -50     // regen limit
    property real maxValue: 150     // power limit

    property bool showHeaderLabels: true       // REGEN / POWER
    property bool showCenterReadout: true      // "24 KW · DRIVE"
    property string driveMode: "DRIVE"         // gear shown next to value
    
    // ===========================
    // Sizing
    // ===========================
    implicitWidth: Theme.sizes.powerBarWidth
    implicitHeight: Theme.sizes.powerBarThumbSize +60


    // ===========================
    // Interpolated value
    // ===========================
    property real animatedValue: value

    Behavior on animatedValue {
        NumberAnimation {
            duration: 350
            easing.type: Easing.OutQuad
        }
    }

    // ===========================
    // Internal computed values
    // ===========================
    
    // Where the "0" position sits on the bar (0.0 to 1.0)
    readonly property real zeroPosition: -minValue / (maxValue - minValue)
    
    // In valuePosition computation:
    readonly property real valuePosition: {
        const clamped = Math.max(minValue, Math.min(maxValue, animatedValue))
        return (clamped - minValue) / (maxValue - minValue)
    }

    readonly property bool isRegen: animatedValue < 0
    
    // ===========================
    // Header labels: REGEN (left) | "24 KW · DRIVE" (center) | POWER (right)
    // ===========================

    // REGEN label (left, with arrow)
    Text {
        id: regenLabel
        visible: root.showHeaderLabels
        anchors.bottom: track.top
        anchors.bottomMargin: 24
        anchors.left: track.left
        text: "←  REGEN"
        font.family: Theme.fonts.ui
        font.weight: Theme.fonts.weightMedium
        font.pixelSize: 11
        font.letterSpacing: 4
        color: Theme.colors.powerNegative
    }

    // POWER label (right, with arrow)
    Text {
        id: powerLabel
        visible: root.showHeaderLabels
        anchors.bottom: track.top
        anchors.bottomMargin: 24
        anchors.right: track.right
        text: "POWER  →"
        font.family: Theme.fonts.ui
        font.weight: Theme.fonts.weightMedium
        font.pixelSize: 11
        font.letterSpacing: 4
        color: Theme.colors.powerPositive
    }

    // Center: "24 KW · DRIVE"
    Row {
        id: centerReadout
        visible: root.showCenterReadout
        anchors.bottom: track.top
        anchors.bottomMargin: 14
        anchors.horizontalCenter: track.horizontalCenter
        spacing: 8

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Math.round(Math.abs(root.animatedValue))
            font.family: Theme.fonts.display
            font.weight: Theme.fonts.weightLight
            font.pixelSize: 22
            font.features: { "tnum": 1 }
            color: Theme.colors.textPrimary
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "kW"
            font.family: Theme.fonts.ui
            font.weight: Theme.fonts.weightLight
            font.pixelSize: 11
            font.letterSpacing: 3
            color: Theme.colors.textTertiary
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "·"
            font.family: Theme.fonts.ui
            font.pixelSize: 12
            color: Theme.colors.textTertiary
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.driveMode
            font.family: Theme.fonts.ui
            font.weight: Theme.fonts.weightMedium
            font.pixelSize: 11
            font.letterSpacing: 3
            color: Theme.colors.textTertiary
        }
    }






    // ===========================
    // Background track
    // ===========================
    Rectangle {
        id: track
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: Theme.sizes.powerBarHeight
        radius: height / 2
        color: Theme.colors.powerBarBg
    }
    
    // ===========================
    // Center marker (the "0" position)
    // ===========================
    Rectangle {
        id: centerMark
        anchors.verticalCenter: track.verticalCenter
        x: track.x + (track.width * root.zeroPosition) - width / 2
        width: 2
        height: Theme.sizes.powerBarThumbSize * 1.5
        color: Theme.colors.textTertiary
        opacity: 0.6
    }
    
    // ===========================
    // Filled segment (current value)
    // ===========================
    Rectangle {
        id: filledSegment
        anchors.verticalCenter: track.verticalCenter
        height: track.height
        radius: height / 2
        
        // Start from center if regen, otherwise grow rightward from center
        x: root.isRegen 
            ? track.x + (track.width * root.valuePosition)
            : track.x + (track.width * root.zeroPosition)
        
        width: root.isRegen
            ? track.width * (root.zeroPosition - root.valuePosition)
            : track.width * (root.valuePosition - root.zeroPosition)
        
        color: root.isRegen ? Theme.colors.powerNegative : Theme.colors.powerPositive
        
        // Smooth transitions
        Behavior on color { ColorAnimation { duration: 400 } }
    }
    
    // ===========================
    // Current value indicator (the "pip" at the end)
    // ===========================
    Rectangle {
        id: thumb
        anchors.verticalCenter: track.verticalCenter
        width: Theme.sizes.powerBarThumbSize
        height: width
        radius: width / 2
        
        x: track.x + (track.width * root.valuePosition) - width / 2
        
        color: root.isRegen ? Theme.colors.powerNegative : Theme.colors.powerPositive
        
        // Glow effect via outer transparent ring
        Rectangle {
            anchors.centerIn: parent
            width: parent.width * 1.8
            height: width
            radius: width / 2
            color: "transparent"
            border.width: 2
            border.color: parent.color
            opacity: 0.4
        }
        
        Behavior on color { ColorAnimation { duration: 400 } }
    }
    
    // ===========================
    // Tick marks (-50, 0, +75, +150)
    // ===========================
    // ===========================
    // Tick marks (-50, 0, +75, +150)
    // ===========================
    Repeater {
        model: [
            { label: "-50", position: 0.0 },
            { label: "0", position: root.zeroPosition },
            { label: "+75", position: (75 - root.minValue) / (root.maxValue - root.minValue) },
            { label: "+150", position: 1.0 }
        ]

        Item {
            anchors.top: track.bottom
            anchors.topMargin: 8
            x: track.x + (track.width * modelData.position) - width / 2
            width: tickLabel.implicitWidth
            height: tickLabel.implicitHeight

            Text {
                id: tickLabel
                text: modelData.label
                font.family: Theme.fonts.ui
                font.weight: Theme.fonts.weightLight
                font.pixelSize: 11
                font.letterSpacing: 1.5
                color: Theme.colors.powerTickMark
            }
        }
    }
}
