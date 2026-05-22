import QtQuick

// Loads all custom fonts used by the cluster.
// Place this once at the top of the application tree.
Item {
    id: fontProvider

    FontLoader { source: "qrc:/qt/qml/EVCluster/resources/fonts/BarlowCondensed-Thin.ttf" }
    FontLoader { source: "qrc:/qt/qml/EVCluster/resources/fonts/BarlowCondensed-ExtraLight.ttf" }
    FontLoader { source: "qrc:/qt/qml/EVCluster/resources/fonts/BarlowCondensed-Medium.ttf" }
    FontLoader { source: "qrc:/qt/qml/EVCluster/resources/fonts/Saira-Light.ttf" }
    FontLoader { source: "qrc:/qt/qml/EVCluster/resources/fonts/Saira-Medium.ttf" }
    FontLoader { source: "qrc:/qt/qml/EVCluster/resources/fonts/SairaCondensed-Light.ttf" }
}
