import QtQuick
import EVCluster

Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property int value: 0           // speed limit in km/h
    property bool detected: true    // hide when no sign detected

    // ===========================
    // Sizing
    // ===========================
    implicitWidth: Theme.sizes.speedLimitSize
    implicitHeight: Theme.sizes.speedLimitSize

    visible: detected

    // ===========================
    // Optional: subtle red glow halo around the sign
    // (simulates the visual emphasis from the mockup)
    // ===========================
    Rectangle {
        id: glowHalo
        anchors.centerIn: parent
        width: parent.width * 1.15
        height: width
        radius: width / 2
        color: "transparent"
        border.color: Theme.colors.speedLimitBorder
        border.width: 1
        opacity: 0.25
    }

    // ===========================
    // Outer red ring (the border of the sign)
    // ===========================
    Rectangle {
        id: outerRing
        anchors.fill: parent
        radius: width / 2
        color: Theme.colors.speedLimitBorder
    }

    // ===========================
    // Inner white circle (the sign face)
    // ===========================
    Rectangle {
        id: innerCircle
        anchors.centerIn: parent
        width: parent.width - (Theme.sizes.speedLimitBorderWidth * 2)
        height: width
        radius: width / 2
        color: Theme.colors.speedLimitBackground
    }

    // ===========================
    // The number itself
    // ===========================
    Text {
        anchors.centerIn: innerCircle
        text: root.value
        font.family: Theme.fonts.display
        font.weight: Theme.fonts.weightMedium
        font.pixelSize: Theme.sizes.speedLimitFontSize
        font.features: { "tnum": 1 }
        color: Theme.colors.speedLimitText
    }
}
