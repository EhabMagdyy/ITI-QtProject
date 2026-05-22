#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/vehiclestate.h"
#include "src/fakedataprovider.h" 


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Create the VehicleState singleton instance
    // Parented to app, so it's destroyed when app exits
    VehicleState *vehicleState = new VehicleState(&app);
    
    
      // Set initial values for the demo
    vehicleState->setGear("D");        
    vehicleState->setBatteryLevel(0.85); 

    // Register it as a QML singleton accessible as "VehicleState"
    qmlRegisterSingletonInstance("EVCluster", 1, 0, "VehicleState", vehicleState);

       // Create and start the fake data provider
    FakeDataProvider *dataProvider = new FakeDataProvider(vehicleState, &app);  
    dataProvider->start();                                                       

       
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("EVCluster", "Main");

    return app.exec();
}
