#include "vehiclestate.h"

VehicleState::VehicleState(QObject *parent)
    : QObject(parent)
{
    // All defaults are already set in the header (m_speed = 0, etc.)
}

// ============================================================
// GETTERS
// ============================================================

int VehicleState::speed() const
{
    return m_speed;
}

double VehicleState::batteryLevel() const
{
    return m_batteryLevel;
}

int VehicleState::range() const
{
    return m_range;
}

int VehicleState::power() const
{
    return m_power;
}

QString VehicleState::gear() const
{
    return m_gear;
}

bool VehicleState::isCharging() const
{
    return m_isCharging;
}

int VehicleState::outsideTemp() const
{
    return m_outsideTemp;
}

int VehicleState::odometer() const
{
    return m_odometer;
}

// ============================================================
// SETTERS
// ============================================================

void VehicleState::setSpeed(int value)
{
    if (m_speed == value)
        return;
    m_speed = value;
    emit speedChanged();
}

void VehicleState::setBatteryLevel(double value)
{
    // Clamp to valid range [0.0, 1.0]
    if (value < 0.0) value = 0.0;
    if (value > 1.0) value = 1.0;
    
    if (qFuzzyCompare(m_batteryLevel, value))
        return;
    m_batteryLevel = value;
    emit batteryLevelChanged();
}

void VehicleState::setRange(int value)
{
    if (m_range == value)
        return;
    m_range = value;
    emit rangeChanged();
}

void VehicleState::setPower(int value)
{
    if (m_power == value)
        return;
    m_power = value;
    emit powerChanged();
}

void VehicleState::setGear(const QString &value)
{
    if (m_gear == value)
        return;
    m_gear = value;
    emit gearChanged();
}

void VehicleState::setIsCharging(bool value)
{
    if (m_isCharging == value)
        return;
    m_isCharging = value;
    emit isChargingChanged();
}

void VehicleState::setOutsideTemp(int value)
{
    if (m_outsideTemp == value)
        return;
    m_outsideTemp = value;
    emit outsideTempChanged();
}

void VehicleState::setOdometer(int value)
{
    if (m_odometer == value)
        return;
    m_odometer = value;
    emit odometerChanged();
}
