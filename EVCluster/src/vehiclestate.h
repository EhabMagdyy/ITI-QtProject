#ifndef VEHICLESTATE_H
#define VEHICLESTATE_H

#include <QObject>
#include <QString>

class VehicleState : public QObject
{
    Q_OBJECT

    // Speed in km/h (0-220)
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    
    // Battery state of charge (0.0 - 1.0, e.g. 0.68 = 68%)
    Q_PROPERTY(double batteryLevel READ batteryLevel WRITE setBatteryLevel NOTIFY batteryLevelChanged)
    
    // Range in km
    Q_PROPERTY(int range READ range WRITE setRange NOTIFY rangeChanged)
    
    // Power in kW (negative = regen, positive = consumption)
    Q_PROPERTY(int power READ power WRITE setPower NOTIFY powerChanged)
    
    // Current gear: "P", "R", "N", "D"
    Q_PROPERTY(QString gear READ gear WRITE setGear NOTIFY gearChanged)
    
    // Charging state
    Q_PROPERTY(bool isCharging READ isCharging WRITE setIsCharging NOTIFY isChargingChanged)
    
    // Outside temperature in Celsius
    Q_PROPERTY(int outsideTemp READ outsideTemp WRITE setOutsideTemp NOTIFY outsideTempChanged)
    
    // Odometer (total km)
    Q_PROPERTY(int odometer READ odometer WRITE setOdometer NOTIFY odometerChanged)

public:
    explicit VehicleState(QObject *parent = nullptr);

    // Getters
    int speed() const;
    double batteryLevel() const;
    int range() const;
    int power() const;
    QString gear() const;
    bool isCharging() const;
    int outsideTemp() const;
    int odometer() const;

    // Setters
    void setSpeed(int value);
    void setBatteryLevel(double value);
    void setRange(int value);
    void setPower(int value);
    void setGear(const QString &value);
    void setIsCharging(bool value);
    void setOutsideTemp(int value);
    void setOdometer(int value);

signals:
    void speedChanged();
    void batteryLevelChanged();
    void rangeChanged();
    void powerChanged();
    void gearChanged();
    void isChargingChanged();
    void outsideTempChanged();
    void odometerChanged();

private:
    int m_speed = 0;
    double m_batteryLevel = 0.68;       // start at 68%
    int m_range = 313;                  // 313 km
    int m_power = 0;                    // 0 kW
    QString m_gear = "P";               // start in Park
    bool m_isCharging = false;
    int m_outsideTemp = 23;             // 23°C
    int m_odometer = 36645;             // 36,645 km
};

#endif // VEHICLESTATE_H
