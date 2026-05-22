import QtQuick
import EVCluster

Item {
    id: root

    // ===========================
    // Public API
    // ===========================
    property string currentTime: "12:17"
    property string timePeriod: "AM"
    property int outsideTemp: 23
    property real tripKm: 128.4
    property int odometerKm: 36645
    property int chargeMinutes: 48
    property int chargePercent: 80
    property bool showCharge: true

    // ===========================
    // Sizing
    // ===========================
    implicitHeight: contentRow.implicitHeight + (Theme.sizes.bottomStripPadding * 2)

    // ===========================
    // The cells row, evenly distributed
    // ===========================
    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 0

        // Cell 1: Time
        Item {
            width: cellWidth
            height: timeCell.implicitHeight

            InfoCell {
                id: timeCell
                anchors.centerIn: parent
                value: root.currentTime
                unit: root.timePeriod
                valueColor: Theme.colors.textPrimary
            }
        }

        // Cell 2: Outside Temp
        Item {
            width: cellWidth
            height: tempCell.implicitHeight

            InfoCell {
                id: tempCell
                anchors.centerIn: parent
                label: "OUTSIDE"
                value: root.outsideTemp + "°"
                unit: "C"
            }
        }

        // Cell 3: Trip
        Item {
            width: cellWidth
            height: tripCell.implicitHeight

            InfoCell {
                id: tripCell
                anchors.centerIn: parent
                label: "TRIP"
                value: root.tripKm.toFixed(1)
                unit: "km"
            }
        }

        // Cell 4: Odometer
        Item {
            width: cellWidth
            height: odoCell.implicitHeight

            InfoCell {
                id: odoCell
                anchors.centerIn: parent
                label: "ODO"
                value: formatThousands(root.odometerKm)
                unit: "km"
            }
        }

        // Cell 5: Charge (only when charging)
        Item {
            width: cellWidth
            height: chargeCell.implicitHeight
            visible: root.showCharge

            InfoCell {
                id: chargeCell
                anchors.centerIn: parent
                label: "CHARGE"
                value: root.chargeMinutes + " min · " + root.chargePercent + "%"
                valueColor: Theme.colors.infoCellChargeAccent
                labelColor: Theme.colors.infoCellChargeAccent
            }
        }

        // ===========================
        // Live time updater
        // ===========================
        Timer {
            interval: 60000    // every minute (not every second — saves CPU)
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                const now = new Date()
                let hours = now.getHours()
                const minutes = now.getMinutes()

                root.timePeriod = hours >= 12 ? "PM" : "AM"
                hours = hours % 12
                if (hours === 0) hours = 12

                const minuteStr = minutes < 10 ? "0" + minutes : minutes.toString()
                root.currentTime = hours + ":" + minuteStr
            }
        }
    }

    // ===========================
    // Cell width = parent / 5 (even distribution)
    // ===========================
    readonly property int cellCount: 5
    readonly property real cellWidth: width / cellCount

    // ===========================
    // Helper: format integer with thousand separators
    // 36645 → "36,645"
    // ===========================
    function formatThousands(value) {
        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
    }
}
