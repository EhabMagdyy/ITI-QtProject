import QtQuick
import EVCluster

// Large stats panel showing % and range, sits next to the BatteryRing.
Item {
    id: root

    property real batteryLevel: 0
    property int rangeKm: 0

    property real animatedBattery: batteryLevel
    property real animatedRange: rangeKm

    Behavior on animatedBattery { NumberAnimation { duration: 800; easing.type: Easing.OutQuad } }
    Behavior on animatedRange { NumberAnimation { duration: 800; easing.type: Easing.OutQuad } }

    implicitWidth: column.implicitWidth
    implicitHeight: column.implicitHeight

    Column {
        id: column
        anchors.centerIn: parent
        spacing: 8

        // Big percentage
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 2

            Text {
                anchors.bottom: parent.bottom
                text: Math.round(root.animatedBattery * 100)
                font.family: Theme.fonts.display
                font.weight: Theme.fonts.weightThin
                font.pixelSize: 64
                font.features: { "tnum": 1 }
                color: Theme.colors.textPrimary
            }

            Text {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                text: "%"
                font.family: Theme.fonts.display
                font.weight: Theme.fonts.weightLight
                font.pixelSize: 22
                color: Theme.colors.textTertiary
            }
        }

        // Range + label
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Math.round(root.animatedRange)
                font.family: Theme.fonts.display
                font.weight: Theme.fonts.weightLight
                font.pixelSize: 24
                font.features: { "tnum": 1 }
                color: Theme.colors.textSecondary
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "km · RANGE"
                font.family: Theme.fonts.ui
                font.weight: Theme.fonts.weightMedium
                font.pixelSize: 11
                font.letterSpacing: 4
                color: Theme.colors.textTertiary
            }
        }
    }
}
