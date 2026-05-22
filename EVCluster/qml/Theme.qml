pragma Singleton
import QtQuick

QtObject {
    id: theme

    readonly property QtObject colors: QtObject {
        readonly property color bgDeep: "#000308"
        readonly property color bgElevated: "#0a1628"
        readonly property color bgStage: "#050a14"
        readonly property color bgClusterMid: "#03070f"
        readonly property color bgClusterCore: "#000308"

        readonly property color accentBlue: "#5fa8ff"
        readonly property color accentBlueSoft: Qt.rgba(0.37, 0.66, 1.0, 0.55)
        readonly property color accentCyan: "#22d3ee"
        readonly property color accentCyanBright: "#67e8f9"
        readonly property color accentAmber: "#fbbf24"
        readonly property color accentViolet: "#a78bfa"

        readonly property color semanticSuccess: "#4ade80"
        readonly property color semanticWarning: "#fbbf24"
        readonly property color semanticDanger: "#ef4444"
        readonly property color semanticDangerDark: "#dc2626"
        readonly property color semanticInfo: "#bfdbfe"

        readonly property color textPrimary: "#e8f0ff"
        readonly property color textSecondary: "#e2e8f0"
        readonly property color textTertiary: "#94a3b8"
        readonly property color textMuted: Qt.rgba(0.58, 0.64, 0.72, 0.55)
        readonly property color textDark: "#0a1628"

        readonly property color batteryHealthy: "#4ade80"
        readonly property color batteryWarning: "#fbbf24"
        readonly property color batteryCritical: "#ef4444"
        readonly property color batteryCharging: "#22d3ee"

        readonly property color powerPositive: "#fbbf24"   // amber
        readonly property color powerNegative: "#22d3ee"   // cyan
        readonly property color powerBarBg: "#1e293b"      // dark slate
        readonly property color powerTickMark: "#475569"   // muted

        readonly property color speedLimitBorder: "#ef4444"   // red
        readonly property color speedLimitBackground: "#ffffff"
        readonly property color speedLimitText: "#000000"

        readonly property color gearActiveText: "#f8fafc"     // primary
        readonly property color gearActiveBorder: Qt.rgba(0.37, 0.66, 1.0, 1.0)
        readonly property color gearActiveGlow: Qt.rgba(0.37, 0.66, 1.0, 0.25)
        readonly property color gearInactiveText: Qt.rgba(0.58, 0.64, 0.72, 0.35)
        readonly property color gearHeaderLabel: Qt.rgba(0.58, 0.64, 0.72, 0.55)

        readonly property color infoCellLabel: Qt.rgba(0.58, 0.64, 0.72, 0.55)
        readonly property color infoCellValue: "#e2e8f0"
        readonly property color infoCellUnit: Qt.rgba(0.58, 0.64, 0.72, 0.75)
        readonly property color infoCellChargeAccent: "#22d3ee"


    }

    readonly property QtObject fonts: QtObject {
        readonly property string display: "Barlow Condensed"
        readonly property string ui: "Saira"
        readonly property string uiCondensed: "Saira Condensed"

        readonly property int weightThin: 100
        readonly property int weightExtraLight: 200
        readonly property int weightLight: 300
        readonly property int weightRegular: 400
        readonly property int weightMedium: 500
        readonly property int weightSemiBold: 600
    }

    readonly property QtObject sizes: QtObject {
        readonly property int speedDisplay: 160
        readonly property int speedUnit: 18
        readonly property int gearActive: 72
        readonly property int gearInactive: 24
        readonly property int gearLabel: 11
        readonly property int gearMode: 10
        readonly property int modeBanner: 11
        readonly property int speedLimit: 42
        readonly property int batteryPercent: 54
        readonly property int batteryPercentSuffix: 22
        readonly property int batteryRange: 15
        readonly property int batteryRangeValue: 24
        readonly property int powerBarWidth: 600
        readonly property int powerBarHeight: 4
        readonly property int powerBarThumbSize: 12
        readonly property int batteryRingSize: 170
        readonly property int batteryRingStrokeWidth: 6
        readonly property int batteryTickCount: 40
        readonly property int batteryTickLength: 8
        readonly property int speedLimitSize: 78
        readonly property int speedLimitBorderWidth: 8
        readonly property int speedLimitFontSize: 42

        readonly property int gearModuleWidth: 220
        readonly property int gearModuleHeight: 320
        readonly property int gearActiveSize: 72        // active D height
        readonly property int gearInactiveSize: 22      // inactive P R N
        readonly property int gearActiveBoxSize: 108    // bracket frame
        readonly property int gearItemSpacing: 4
        readonly property int gearLabelSize: 11
        readonly property int gearModeFooterSize: 10
        readonly property int gearBracketLength: 14
        readonly property int gearBracketThickness: 1


        readonly property int infoCellLabelSize: 10
        readonly property int infoCellValueSize: 16
        readonly property int infoCellUnitSize: 11
        readonly property int infoCellSpacing: 6
        readonly property int bottomStripPadding: 32



    }

    readonly property QtObject spacing: QtObject {
        readonly property int xxs: 4
        readonly property int xs: 8
        readonly property int sm: 12
        readonly property int md: 16
        readonly property int lg: 24
        readonly property int xl: 32
        readonly property int xxl: 48
    }

    readonly property QtObject layout: QtObject {
        readonly property int clusterWidth: 1024
        readonly property int clusterHeight: 600
        readonly property int safePadding: 24
    }

    readonly property QtObject animation: QtObject {
        readonly property int durationFast: 150
        readonly property int durationNormal: 300
        readonly property int durationSlow: 500
        readonly property int durationGlow: 2000
    }
}
