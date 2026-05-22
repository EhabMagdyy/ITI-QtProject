import QtQuick
import EVCluster

// Debug status bar — toggleable via the `visible` property.
// Shows live VehicleState values for development.
Text {
    id: root

    // Public API — toggle on/off
    property bool active: true

    visible: active

    text: "Speed: " + VehicleState.speed + " km/h" +
          " | Battery: " + (VehicleState.batteryLevel * 100).toFixed(0) + "%" +
          " | Power: " + VehicleState.power + " kW" +
          " | Range: " + VehicleState.range + " km" +
          " | Gear: " + VehicleState.gear

    font.family: Theme.fonts.ui
    font.weight: Theme.fonts.weightLight
    font.pixelSize: 14
    font.letterSpacing: 2
    font.features: { "tnum": 1 }
    color: Theme.colors.textTertiary

    MouseArea {
        anchors.fill: parent
        onClicked: {
            var gears = ["P", "R", "N", "D"]
            var currentIdx = gears.indexOf(VehicleState.gear)
            var nextIdx = (currentIdx + 1) % 4
            VehicleState.gear = gears[nextIdx]
        }
    }

}

