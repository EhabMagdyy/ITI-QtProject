#ifndef FAKEDATAPROVIDER_H
#define FAKEDATAPROVIDER_H

#include <QObject>
#include <QTimer>
#include <QElapsedTimer>

class VehicleState;  // Forward declaration

class FakeDataProvider : public QObject
{
    Q_OBJECT

public:
    explicit FakeDataProvider(VehicleState *vehicleState, QObject *parent = nullptr);
    
    void start();
    void stop();

private slots:
    void onTick();

private:
    VehicleState *m_vehicleState;   // Non-owning pointer
    QTimer *m_timer;
    QElapsedTimer m_elapsed;
    
    // Configuration
    static constexpr int TICK_INTERVAL_MS = 50;      // 20 Hz update rate
    static constexpr double SPEED_CYCLE_SEC = 80.0;  // Full speed cycle
    static constexpr double POWER_CYCLE_SEC = 15.0;
    static constexpr int MAX_SPEED = 180;            // km/h
    static constexpr int MAX_POWER = 120;            // kW
    static constexpr int MIN_POWER = -40;            // kW (regen)
};

#endif // FAKEDATAPROVIDER_H
