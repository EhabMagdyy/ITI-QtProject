import QtQuick
import EVCluster
import QtQuick.Effects


Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property int value: 0
    property string unit: "km/h"

    // ===========================
    // Interpolated value for smooth animation
    // ===========================
    property real animatedValue: value

    Behavior on animatedValue {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutQuad
        }
    }

    // ===========================
    // Sizing
    // ===========================
    implicitWidth: Math.max(speedText.implicitWidth, unitText.implicitWidth)
    implicitHeight: speedText.implicitHeight + unitText.implicitHeight + unitText.anchors.topMargin

    // ===========================
    // Visual elements
    // ===========================
    Text {
        id: speedText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        text: Math.round(root.animatedValue)   //  CHANGED from root.value

        font.family: Theme.fonts.display
        font.weight: Theme.fonts.weightThin
        font.pixelSize: Theme.sizes.speedDisplay
        font.features: { "tnum": 1 }

        color: Theme.colors.textPrimary
    }
    MultiEffect {
            source: speedText
            anchors.fill: speedText
            autoPaddingEnabled: true
            shadowEnabled: true
            shadowColor: Theme.colors.accentBlue
            shadowBlur: 1
            shadowOpacity: 1
            shadowScale: 1.0
            blurMax: 16
        }
    MultiEffect {
        source: speedText
        anchors.fill: speedText
        autoPaddingEnabled: true
        shadowEnabled: true
        shadowColor: "#bfdbfe"
        shadowBlur: 0.3
        shadowOpacity: 0.6
        blurMax: 8
    }
    Text {
        id: unitText
        anchors.horizontalCenter: speedText.horizontalCenter
        anchors.top: speedText.bottom
        anchors.topMargin: -20

        text: root.unit

        font.family: Theme.fonts.uiCondensed
        font.weight: Theme.fonts.weightLight
        font.pixelSize: Theme.sizes.speedUnit
        font.letterSpacing: 4

        color: Theme.colors.textTertiary
    }
}
