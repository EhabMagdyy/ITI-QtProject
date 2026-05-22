cmake_minimum_required(VERSION 3.16)

project(EVCluster VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick QuickControls2 Core5Compat Quick3D)
qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appEVCluster
    main.cpp
    src/vehiclestate.h
    src/vehiclestate.cpp
    src/fakedataprovider.h 
    src/fakedataprovider.cpp
)

qt_add_qml_module(appEVCluster
    URI EVCluster
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/components/SpeedDisplay.qml
        qml/components/PowerBar.qml
        qml/components/BatteryRing.qml
        qml/components/FontProvider.qml
        qml/components/DebugOverlay.qml
        qml/components/SpeedLimitRoundel.qml
        qml/components/GearModule.qml
        qml/components/InfoCell.qml
        qml/components/BottomInfoStrip.qml
        qml/components/BatterySideStats.qml
        qml/components/TopStatusBar.qml
        qml/components/TelltaleIcon.qml
        qml/components/TripEnergySparkline.qml
        qml/components/ChargeBadge.qml


    RESOURCES
        resources/fonts/BarlowCondensed-Thin.ttf
        resources/fonts/BarlowCondensed-ExtraLight.ttf
        resources/fonts/BarlowCondensed-Medium.ttf
        resources/fonts/Saira-Light.ttf
        resources/fonts/Saira-Medium.ttf
        resources/fonts/SairaCondensed-Light.ttf

)
set_source_files_properties(qml/Theme.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)




# Re-add Theme.qml as singleton
qt_target_qml_sources(appEVCluster
    QML_FILES
           qml/Theme.qml


)

set_target_properties(appEVCluster PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appEVCluster
    PRIVATE
        Qt6::Quick
        Qt6::QuickControls2
        Qt6::Core5Compat
        Qt6::Quick3D
)

include(GNUInstallDirs)
install(TARGETS appEVCluster
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
