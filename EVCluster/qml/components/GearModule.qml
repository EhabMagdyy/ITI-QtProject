import QtQuick
import EVCluster
import QtQuick.Effects


Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property string activeGear: "D"
    property string driveMode: "SPORT"
    property string driveSubMode: "ONE-PEDAL"

    // ===========================
    // Sizing
    // ===========================
    implicitWidth: Theme.sizes.gearModuleWidth
    implicitHeight: Theme.sizes.gearModuleHeight

    // ===========================
    // Gear lookup
    // ===========================
    readonly property var gearList: ["P", "R", "N", "D"]
    readonly property int activeIndex: gearList.indexOf(activeGear)

    // ===========================
    // Header (fixed top)
    // ===========================
    Text {
        id: headerLabel
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: "GEAR"
        font.family: Theme.fonts.ui
        font.weight: Theme.fonts.weightMedium
        font.pixelSize: Theme.sizes.gearLabelSize
        font.letterSpacing: 4
        color: Theme.colors.gearHeaderLabel
    }

    // ===========================
    // ACTIVE BOX (fixed center)
    // ===========================
    Item {
        id: activeBox
        anchors.centerIn: parent
        width: Theme.sizes.gearActiveBoxSize
        height: width

        // ===========================
        // Outer soft halo (rounded square, subtle)
        // ===========================
        Rectangle {
            anchors.centerIn: parent
            width: parent.width + 24
            height: parent.height + 24
            radius: 24
            color: "transparent"
            border.color: Theme.colors.gearActiveBorder
            border.width: 1
            opacity: 0.12
        }

        // ===========================
        // Inner glow (rounded square background)
        // ===========================
        Rectangle {
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                    radius: 18
                    opacity: 1.0
                    color: "transparent"
                    border.color: Qt.rgba(0.37, 0.66, 1.0, 0.45)
                    border.width: 1
                }

                // Radial glow overlay (top-center blue tint)
                Rectangle {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -15
                    width: parent.width * 0.7
                    height: parent.height * 0.7
                    radius: 14
                    color: Qt.rgba(0.37, 0.66, 1.0, 0.08)
                    opacity: 0.4
                }
        // ===========================
        // 4 Corner brackets (keep as is)
        // ===========================
        Repeater {
            model: 4

            Item {
                readonly property bool isTop: index < 2
                readonly property bool isLeft: index % 2 === 0

                width: Theme.sizes.gearBracketLength
                height: width
                x: isLeft ? 6 : activeBox.width - width - 6
                 y: isTop ? 6 : activeBox.height - height - 6

                Rectangle {
                    width: Theme.sizes.gearBracketLength
                    height: Theme.sizes.gearBracketThickness
                    color: Theme.colors.gearActiveBorder
                    y: parent.isTop ? 0 : parent.height - height
                }
                Rectangle {
                    width: Theme.sizes.gearBracketThickness
                    height: Theme.sizes.gearBracketLength
                    color: Theme.colors.gearActiveBorder
                    x: parent.isLeft ? 0 : parent.width - width
                }
            }
        }

        // ===========================
        // The active gear letter (with cross-fade)
        // ===========================
        Text {
            id: activeLetter
            anchors.centerIn: parent
            text: root.activeGear
            font.family: Theme.fonts.display
            font.weight: Theme.fonts.weightLight
            font.pixelSize: Theme.sizes.gearActiveSize
            color: Theme.colors.gearActiveText

            Connections {
                target: root
                function onActiveGearChanged() {
                    letterChangeAnim.restart()
                }
            }

            SequentialAnimation {
                id: letterChangeAnim
                NumberAnimation {
                    target: activeLetter
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 120
                    easing.type: Easing.InQuad
                }
                NumberAnimation {
                    target: activeLetter
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 180
                    easing.type: Easing.OutQuad
                }
            }
            MultiEffect {
                        source: activeLetter
                        anchors.fill: activeLetter
                        autoPaddingEnabled: true
                        shadowEnabled: true
                        shadowColor: Theme.colors.accentBlue
                        shadowBlur: 0.8
                        shadowOpacity: 0.7
                        blurMax: 16
                    }

        }

    }


    // ===========================
    // INACTIVE GEARS — fixed slot positions
    // ===========================

    // Slot positions are based on offsets from activeBox center
    readonly property int slotSpacing: 38   // distance between slots

    Repeater {
        model: root.gearList

        Text {
            id: inactiveText

            readonly property int relativeSlot: index - root.activeIndex
            readonly property bool isAbove: relativeSlot < 0
            readonly property bool isBelow: relativeSlot > 0
            readonly property int slotDistance: Math.abs(relativeSlot)

            opacity: (relativeSlot !== 0) ? 1.0 : 0.0

            anchors.horizontalCenter: activeBox.horizontalCenter

            // Cleaner math:
            // - For slots above: position above activeBox.y by slotDistance * spacing
            // - For slots below: position below activeBox.y + height by slotDistance * spacing
            y: {
                if (isAbove) {
                    return activeBox.y - (slotDistance * root.slotSpacing) - height / 2
                } else if (isBelow) {
                    return activeBox.y + activeBox.height + ((slotDistance - 1) * root.slotSpacing) + height / 2
                } else {
                    return activeBox.y + activeBox.height / 2 - height / 2
                }
            }

            text: modelData
            font.family: Theme.fonts.display
            font.weight: Theme.fonts.weightThin
            font.pixelSize: Theme.sizes.gearInactiveSize
            color: Theme.colors.gearInactiveText

            Behavior on opacity { NumberAnimation { duration: 250 } }
            Behavior on y { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
        }
    }

    // ===========================
    // Footer (fixed bottom)
    // ===========================
    Text {
        id: footerLabel
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: root.driveMode + " · " + root.driveSubMode
        font.family: Theme.fonts.ui
        font.weight: Theme.fonts.weightMedium
        font.pixelSize: Theme.sizes.gearModeFooterSize
        font.letterSpacing: 4
        color: Theme.colors.gearHeaderLabel
    }
}
