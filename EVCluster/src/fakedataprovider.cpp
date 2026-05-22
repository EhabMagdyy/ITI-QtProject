#include "fakedataprovider.h"
#include "vehiclestate.h"
#include <cmath>
#include <QtMath>

FakeDataProvider::FakeDataProvider(VehicleState *vehicleState, QObject *parent)
    : QObject(parent)
    , m_vehicleState(vehicleState)
    , m_timer(new QTimer(this))
{
    // Configure the timer
    m_timer->setInterval(TICK_INTERVAL_MS);
    m_timer->setTimerType(Qt::PreciseTimer);   // request OS for precise timing
    
    // Connect timer signal to our slot
    connect(m_timer, &QTimer::timeout, this, &FakeDataProvider::onTick);
}

void FakeDataProvider::start()
{
    m_elapsed.start();   // start the stopwatch
    m_timer->start();    // start firing every 50ms
}

void FakeDataProvider::stop()
{
    m_timer->stop();
}

void FakeDataProvider::onTick()
{
    if (!m_vehicleState)
        return;   // Safety check
    
    // Get elapsed time in seconds
    const double seconds = m_elapsed.elapsed() / 1000.0;
    
    // ====================================================
    // Speed: sine wave from 0 to MAX_SPEED, cycle every 30s
    // ====================================================
    const double speedPhase = (seconds / SPEED_CYCLE_SEC) * 2.0 * M_PI;
    const double speedNormalized = (std::sin(speedPhase) + 1.0) / 2.0;  // 0 to 1
    const int speed = static_cast<int>(speedNormalized * MAX_SPEED);
    m_vehicleState->setSpeed(speed);
    
    // ====================================================
    // Power: roughly correlated with speed, plus oscillation
    // When speed is high → high power consumption
    // When speed drops → regen (negative power)
    // ====================================================
    const double powerPhase = (seconds / POWER_CYCLE_SEC) * 2.0 * M_PI;
    const double powerSine = std::sin(powerPhase);   // -1 to 1
    int power;
    if (powerSine >= 0) {
        // Driving — positive power
        power = static_cast<int>(powerSine * MAX_POWER);
    } else {
        // Regen — negative power, smaller magnitude
        power = static_cast<int>(powerSine * std::abs(MIN_POWER));
    }
    m_vehicleState->setPower(power);
    
    // ====================================================
    // Battery: slowly drains (1% per 30 seconds = 0.033%/sec)
    // Drain proportional to power consumption when positive
    // Regenerate slightly when power is negative (regen)
    // ====================================================
    // ====================================================
    // Battery: sine wave cycle between 0.15 and 0.95
    // ====================================================
    const double batteryPhase = (seconds / 120.0) * 2.0 * M_PI;
    const double batteryNorm = (std::sin(batteryPhase) + 1.0) / 2.0;
    const double newBattery = 0.15 + (batteryNorm * 0.80);
    m_vehicleState->setBatteryLevel(newBattery);
    
    // ====================================================
    // Range: roughly proportional to battery level
    // Full battery = 450 km, empty = 0 km
    // ====================================================
    const int newRange = std::max(0, static_cast<int>(newBattery * 450));
    m_vehicleState->setRange(newRange);

     m_vehicleState->setIsCharging(newBattery < 0.15);
    
    // ====================================================
    // Gear: stays in "D" for the fake demo
    // (Will be controlled by user input or CAN later)
    // ====================================================
    const QString gears[] = {"P","R", "N", "D"};
    const int gearIndex = static_cast<int>(seconds / 10.0) % 4;
    m_vehicleState->setGear(gears[gearIndex]);

}
