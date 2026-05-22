import QtQuick
import QtQuick.Window
import EVCluster
import Qt5Compat.GraphicalEffects


Window {
    id: window
    width: Theme.layout.clusterWidth
    height: Theme.layout.clusterHeight
    visible: true
    title: qsTr("EV Cluster")
    color: Theme.colors.bgDeep
    flags: Qt.Window | Qt.FramelessWindowHint

    FontProvider {}

    Item {
        id: clusterCanvas
        anchors.fill: parent

        // ===========================
                // Background gradient layers (matching HTML mockup CSS)
                // ===========================

                // Safety floor
                Rectangle { anchors.fill: parent; color: "#000308" }

                // 4) Base navy radial — 120% × 100% centered
                RadialGradient {
                    anchors.fill: parent
                    horizontalRadius: parent.width * 0.60
                    verticalRadius: parent.height * 0.50
                    horizontalOffset: 0
                    verticalOffset: 0
                    gradient: Gradient {
                        GradientStop { position: 0.00; color: "#0a1628" }
                        GradientStop { position: 0.55; color: "#03070f" }
                        GradientStop { position: 1.00; color: "#000308" }
                    }
                }

                // 3) Amber glow — bottom-left
                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: -parent.width * 0.50
                    verticalOffset: parent.height * 0.50
                    horizontalRadius: parent.width * 0.40
                    verticalRadius: parent.height * 0.35
                    gradient: Gradient {
                        GradientStop { position: 0.00; color: Qt.rgba(0.984, 0.749, 0.141, 0.06) }
                        GradientStop { position: 0.60; color: "transparent" }
                    }
                }

                // 2) Cyan glow — bottom-right
                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: parent.width * 0.50
                    verticalOffset: parent.height * 0.50
                    horizontalRadius: parent.width * 0.40
                    verticalRadius: parent.height * 0.35
                    gradient: Gradient {
                        GradientStop { position: 0.00; color: Qt.rgba(0.133, 0.827, 0.933, 0.16) }
                        GradientStop { position: 0.60; color: "transparent" }
                    }
                }

                // 1) Blue key — top-center
                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: 0
                    verticalOffset: -parent.height * 0.60
                    horizontalRadius: parent.width * 0.30
                    verticalRadius: parent.height * 0.20
                    gradient: Gradient {
                        GradientStop { position: 0.00; color: Qt.rgba(0.373, 0.659, 1.0, 0.30) }
                        GradientStop { position: 0.80; color: "transparent" }
                    }
                }

                // Edge light — top blue rim
                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    height: parent.height * 0.12
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(0.373, 0.659, 1.0, 0.35) }
                        GradientStop { position: 1.0; color: "transparent" }
                    }
                }

                // Edge light — bottom cyan rim
                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: parent.height * 0.14
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "transparent" }
                        GradientStop { position: 1.0; color: Qt.rgba(0.133, 0.827, 0.933, 0.12) }
                    }
                }


        // ===========================
        // TOP: Status Bar (Telltales + Mode Banner)
        // Spec: y=0, height=54
        // ===========================
        TopStatusBar {
            id: topStatusBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            leftSignal: false
            rightSignal: true
            lowBeam: true
            highBeam: true
            autoHold: true
            seatbelt: true
            brakeWarning: false
            hazardWarning: false
            driveMode: "SPORT"
            awdActive: true
            assistReady: true
        }

        // ===========================
        // LEFT PANEL: Gear Module
        // Spec: x=24, y=78, w=240, h=430
        // ===========================
        GearModule {
            id: gearModule
            x: 24
            y: 78
            width: 240
            implicitHeight: 430
            activeGear: VehicleState.gear
            driveMode: "SPORT"
            driveSubMode: "ONE-PEDAL"
        }

        // ===========================
        // SPEED LIMIT ROUNDEL
        // Spec: x=292 (calc(50% - 220px)), y=108
        // ===========================
        SpeedLimitRoundel {
            id: speedLimit
            x: 330
            y: 100
            value: 90
            detected: true
        }

        // ===========================
        // HERO: Speed Display
        // Spec: centered at x=512, y=324 (54% of 600)
        // ===========================
        SpeedDisplay {
            id: speedDisplay
            anchors.horizontalCenter: parent.horizontalCenter
            y: 324 - height / 2
            value: VehicleState.speed
            unit: "km/h"
        }

        // ===========================
        // RIGHT PANEL: Battery Ring
        // Spec: x=760, y=78, w=240, h=430
        // Ring SVG viewBox 400×430, center cx=200, cy=215
        // ===========================
        // ===========================
                // RIGHT PANEL: Battery Ring + Readout
                // Spec: x=760, y=78, w=240, h=430
                // ===========================
                Item {
                    id: rightPanel
                    x: 760
                    y: 78
                    width: 240
                    height: 430

                    // "BATTERY" label — top left
                    Text {
                        id: batteryHeader
                        anchors.top: parent.top
                        anchors.left: parent.left
                        text: "BATTERY"
                        font.family: Theme.fonts.ui
                        font.weight: Theme.fonts.weightMedium
                        font.pixelSize: 11
                        font.letterSpacing: 3.52
                        color: Qt.rgba(0.58, 0.64, 0.72, 0.7)
                    }

                    // "Charging" / "Healthy" — top right
                    Text {
                        id: batteryStatus
                        anchors.top: parent.top
                        anchors.right: parent.right
                        text: VehicleState.isCharging ? "CHARGING" : (VehicleState.batteryLevel > 0.5 ? "Healthy" : (VehicleState.batteryLevel > 0.2 ? "Plan charge" : "Critical"))
                        font.family: Theme.fonts.ui
                        font.weight: Theme.fonts.weightLight
                        font.pixelSize: 13
                        font.letterSpacing: 0.52
                        color: VehicleState.isCharging ? Theme.colors.batteryCharging : Qt.rgba(0.886, 0.910, 0.941, 0.85)
                    }

                    // Battery Ring — fills most of the panel
                    BatteryRing {
                        id: batteryRing
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 40
                        width: 240
                        height: 240
                        value: VehicleState.batteryLevel
                        rangeKm: VehicleState.range
                        isCharging: VehicleState.isCharging
                        showHeaderLabel: false
                        showStatusLabel: false
                    }

                    // Charge badge — right edge
                    ChargeBadge {
                        id: chargeBadge
                        anchors.right: parent.right
                        anchors.rightMargin: -14
                        y: 104
                        charging: VehicleState.isCharging
                    }
                }

                // ===========================
                // BATTERY READOUT — bottom right, outside the panel
                // Spec: positioned at bottom-right of the screen
                // ===========================
                Column {
                    id: batteryReadout
                    anchors.right: parent.right
                    anchors.rightMargin: 60
                    y: 400
                    spacing: 4

                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 2

                        Text {
                            text: Math.round(VehicleState.batteryLevel * 100)
                            font.family: Theme.fonts.display
                            font.weight: Theme.fonts.weightExtraLight
                            font.pixelSize: 54
                            font.letterSpacing: -1.08
                            font.features: { "tnum": 1 }
                            color: Theme.colors.textPrimary
                            anchors.bottom: parent.bottom
                        }

                        Text {
                            text: "%"
                            font.family: Theme.fonts.ui
                            font.pixelSize: 22
                            color: Qt.rgba(1, 1, 1, 0.75)
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                        }
                    }

                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 6

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: VehicleState.range
                            font.family: Theme.fonts.display
                            font.weight: Theme.fonts.weightExtraLight
                            font.pixelSize: 24
                            font.letterSpacing: -0.24
                            font.features: { "tnum": 1 }
                            color: Theme.colors.textPrimary
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "KM · RANGE"
                            font.family: Theme.fonts.uiCondensed
                            font.weight: Theme.fonts.weightLight
                            font.pixelSize: 15
                            font.letterSpacing: 4.2
                            color: Qt.rgba(0.58, 0.64, 0.72, 0.85)
                        }
                    }
                }

        // ===========================
        // POWER BAR
        // Spec: centered at y=430, width=520
        // ===========================
        PowerBar {
            id: powerBar
            anchors.horizontalCenter: parent.horizontalCenter
            y: 430
            width: 520
            value: VehicleState.power
            driveMode: VehicleState.power < 0 ? "REGEN" : "DRIVE"
            showHeaderLabels: true
            showCenterReadout: true
        }

        // ===========================
        // TRIP ENERGY SPARKLINE
        // Spec: centered at y=506, width=520
        // ===========================
        TripEnergySparkline {
            id: sparkline
            anchors.horizontalCenter: parent.horizontalCenter
            y: 506
            width: 520
        }

        // ===========================
        // BOTTOM INFO STRIP
        // Spec: y=554, height=46, full width
        // ===========================
        BottomInfoStrip {
            anchors.left: parent.left
            anchors.right: parent.right
            y: 535
            outsideTemp: VehicleState.outsideTemp
            tripKm: 128.4
            odometerKm: VehicleState.odometer
            chargeMinutes: 48
            chargePercent: 80
            showCharge: VehicleState.isCharging
        }
    }

    DebugOverlay {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        active: false
    }
}
