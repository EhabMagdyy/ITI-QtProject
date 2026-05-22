import QtQuick
import EVCluster

// Reusable info cell for status displays.
// Layout: LABEL on left + VALUE on right (with optional unit & accent color)
Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property string label: ""        // e.g. "ODO"
    property string value: ""        // e.g. "36,645"
    property string unit: ""         // e.g. "km" (optional)
    property color valueColor: Theme.colors.infoCellValue
    property color labelColor: Theme.colors.infoCellLabel

    // ===========================
    // Sizing - hugs content
    // ===========================
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Row {
        id: row
        anchors.centerIn: parent
        spacing: Theme.sizes.infoCellSpacing

        // Label
        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.label !== ""
            text: root.label
            font.family: Theme.fonts.ui
            font.weight: Theme.fonts.weightMedium
            font.pixelSize: Theme.sizes.infoCellLabelSize
            font.letterSpacing: 3
            color: root.labelColor
        }

        // Value
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.value
            font.family: Theme.fonts.uiCondensed
            font.weight: Theme.fonts.weightLight
            font.pixelSize: Theme.sizes.infoCellValueSize
            font.features: { "tnum": 1 }
            color: root.valueColor
        }

        // Unit (optional)
        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.unit !== ""
            text: root.unit
            font.family: Theme.fonts.ui
            font.weight: Theme.fonts.weightLight
            font.pixelSize: Theme.sizes.infoCellUnitSize
            font.letterSpacing: 2
            color: root.labelColor
        }
    }
}
