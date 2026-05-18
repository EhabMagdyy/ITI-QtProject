import QtQuick
import QtQuick.Controls
import QtQuick.Window

pragma ComponentBehavior: Bound

Item {
    id: root

    signal goBack()
    property int currentHour: 2
    property string city: "Giza"

    // App background
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:/assets/images/weatherbackground.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    // Dark overlay so text stays readable
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.15
    }

    WindowBar {
        id: titleBar
        z: 1
        window: mainWindow
        titleName: "Weather"
        showBackButton: true
        onBackRequested: root.goBack()
        color0: '#01012e'
        color1: '#011129'
        color2: '#011a27'
    }

    // Weather helper
    function weatherEmoji(code, isDay) {
        if (code === 0)  return isDay ? "☀️"  : "🌙"
        if (code <= 2)   return isDay ? "🌤️" : "🌙"
        if (code === 3)  return "☁️"
        if (code <= 48)  return "🌫️"
        if (code <= 55)  return "🌦️"
        if (code <= 57)  return "🌧️"
        if (code <= 65)  return "🌧️"
        if (code <= 67)  return "🌨️"
        if (code <= 75)  return "❄️"
        if (code <= 77)  return "🌨️"
        if (code <= 82)  return "🌦️"
        if (code <= 86)  return "❄️"
        if (code <= 99)  return "⛈️"
        return "🌡️"
    }

    // Models
    ListModel {
        id: weatherInfoModel
        ListElement { label: "Wind Speed";     emoji: "💨"; value: "12 km/h"  }
        ListElement { label: "Humidity";       emoji: "💧"; value: "65%"      }
        ListElement { label: "Wind Direction"; emoji: "🧭"; value: "270°"     }
        ListElement { label: "Pressure";       emoji: "🔵"; value: "1013 hPa" }
    }
    ListModel {
        id: hourlyWeatherModel
        ListElement { time: "12 AM"; temp: "19°C" } ListElement { time: "1 AM";  temp: "18°C" }
        ListElement { time: "2 AM";  temp: "18°C" } ListElement { time: "3 AM";  temp: "17°C" }
        ListElement { time: "4 AM";  temp: "17°C" } ListElement { time: "5 AM";  temp: "17°C" }
        ListElement { time: "6 AM";  temp: "18°C" } ListElement { time: "7 AM";  temp: "19°C" }
        ListElement { time: "8 AM";  temp: "21°C" } ListElement { time: "9 AM";  temp: "23°C" }
        ListElement { time: "10 AM"; temp: "25°C" } ListElement { time: "11 AM"; temp: "27°C" }
        ListElement { time: "12 PM"; temp: "29°C" } ListElement { time: "1 PM";  temp: "30°C" }
        ListElement { time: "2 PM";  temp: "31°C" } ListElement { time: "3 PM";  temp: "31°C" }
        ListElement { time: "4 PM";  temp: "30°C" } ListElement { time: "5 PM";  temp: "28°C" }
        ListElement { time: "6 PM";  temp: "26°C" } ListElement { time: "7 PM";  temp: "24°C" }
        ListElement { time: "8 PM";  temp: "23°C" } ListElement { time: "9 PM";  temp: "22°C" }
        ListElement { time: "10 PM"; temp: "21°C" } ListElement { time: "11 PM"; temp: "20°C" }
    }
    ListModel {
        id: dailyWeatherModel
        ListElement { day: "Today";     uvIndex: 2.1; maxTemp: "26°C"; minTemp: "15°C" }
        ListElement { day: "Tomorrow";  uvIndex: 2.5; maxTemp: "27°C"; minTemp: "17°C" }
        ListElement { day: "Tuesday";   uvIndex: 4.0; maxTemp: "28°C"; minTemp: "17°C" }
        ListElement { day: "Wednesday"; uvIndex: 4.6; maxTemp: "27°C"; minTemp: "17°C" }
        ListElement { day: "Thursday";  uvIndex: 5.9; maxTemp: "29°C"; minTemp: "18°C" }
        ListElement { day: "Friday";    uvIndex: 7.1; maxTemp: "32°C"; minTemp: "20°C" }
        ListElement { day: "Saturday";  uvIndex: 8.5; maxTemp: "33°C"; minTemp: "21°C" }
    }

    // Refresh button
    Rectangle {
        id: refreshBtn
        width: root.height * 0.065
        height: root.height * 0.065
        color: "#1a1a2e"
        anchors { left: parent.left; leftMargin: root.width * 0.045; top: titleBar.bottom; topMargin: root.height * 0.028 }
        radius: width / 2
        border.color: "#ffffff"; border.width: 1
        opacity: 0.8
        z: 5
        Behavior on scale   { NumberAnimation { duration: 120 } }
        Behavior on opacity { NumberAnimation { duration: 120 } }
        Text { anchors.centerIn: parent; text: "↻"; color: "#ffffff"; font.pointSize: root.height * 0.036 }
        MouseArea {
            anchors.fill: parent; hoverEnabled: true
            onEntered:  refreshBtn.opacity = 1.0
            onExited:   refreshBtn.opacity = 0.8
            onPressed:  refreshBtn.scale   = 0.88
            onReleased: { refreshBtn.scale = 1.0; weatherAPI.fetch(cityInput.text) }
        }
    }

    // Main Content
    Column {
        width: parent.width
        anchors { top: titleBar.bottom; topMargin: root.height * 0.028; horizontalCenter: parent.horizontalCenter }
        spacing: root.height * 0.028

        // Search field
        TextField {
            id: cityInput
            width: root.width * 0.3
            height: root.height * 0.055
            placeholderText: "🔍 Enter city name..."
            anchors.horizontalCenter: parent.horizontalCenter
            font { pointSize: root.height * 0.016; family: "Arial" }
            color: "white"; placeholderTextColor: "#aaaaaa"
            leftPadding: root.width * 0.012
            verticalAlignment: TextInput.AlignVCenter
            selectByMouse: true
            background: Rectangle {
                color: "#1a1a2e"; radius: root.height * 0.027
                border.color: cityInput.activeFocus ? "#4fc3f7" : "#444466"
                border.width: cityInput.activeFocus ? 2 : 1
            }
            Behavior on scale { NumberAnimation { duration: 120 } }
            onHoveredChanged: scale = hovered ? 1.05 : 1.0
            onActiveFocusChanged: {
                if (activeFocus && (text === "" || text.startsWith("⚠️"))) placeholderText = ""
                else if (!activeFocus && text === "") placeholderText = "🔍  Enter city name..."
            }
            Keys.onReturnPressed: weatherAPI.fetch(cityInput.text)
        }

        // Main info banner
        Rectangle {
            id: mainInfoContainer
            width: root.width * 0.8; height: root.height * 0.13
            color: "#12495f"; opacity: 0.8; radius: root.height * 0.025
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: "#ffffff"; border.width: 3
            Behavior on scale   { NumberAnimation { duration: 120 } }
            Behavior on opacity { NumberAnimation { duration: 120 } }
            MouseArea {
                anchors.fill: parent; hoverEnabled: true
                onEntered: { mainInfoContainer.scale = 1.01; mainInfoContainer.opacity = 1.0 }
                onExited:  { mainInfoContainer.scale = 1.0;  mainInfoContainer.opacity = 0.8 }
            }
            Row {
                anchors.centerIn: parent
                spacing: root.width * 0.015
                Text { id: weatherEmojiText; text: "🌤️"; font.pointSize: root.height * 0.065; anchors.verticalCenter: parent.verticalCenter }
                Rectangle { width: 1; height: root.height * 0.09; color: "#ffffff"; opacity: 0.3; anchors.verticalCenter: parent.verticalCenter }
                Column {
                    spacing: root.height * 0.005; anchors.verticalCenter: parent.verticalCenter
                    Text { id: weatherDescription; text: "Partly Cloudy"; color: "white"; font { pointSize: root.height * 0.020; family: "Arial" } }
                    Text { id: temperature;        text: "21°C";          color: "white"; font { pointSize: root.height * 0.040; family: "Arial"; bold: true } }
                }
                Item { width: root.width * 0.2; height: 1 }
                Column {
                    spacing: root.height * 0.014; anchors.verticalCenter: parent.verticalCenter
                    Text { id: cityName;   text: "Cairo, Egypt"; color: "white"; font { pointSize: root.height * 0.026; family: "Arial"; bold: true } }
                    Text { id: feelsLike;  text: "Feels like: 19°C"; color: "#ffffff"; font { pointSize: root.height * 0.02; family: "Arial" } }
                }
                Rectangle { width: 1; height: root.height * 0.09; color: "#ffffff"; opacity: 0.3; anchors.verticalCenter: parent.verticalCenter }
                Column {
                    spacing: root.height * 0.014; anchors.verticalCenter: parent.verticalCenter
                    Text { text: "Population"; color: "white"; font { pointSize: root.height * 0.02; family: "Arial"; bold: true } }
                    Text { id: populationValue; text: "137,844"; color: "#ffffff"; font { pointSize: root.height * 0.018; family: "Arial" } }
                }
            }
        }

        // Hourly forecast
        Rectangle {
            id: hourlyContainer
            width: root.width * 0.8; height: root.height * 0.18
            color: "#12495f"; opacity: 0.8; radius: root.height * 0.025
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true; border.color: "#ffffff"; border.width: 1
            Flickable {
                anchors { fill: parent; margins: root.height * 0.02 }
                contentWidth: hourlyRow.width
                flickableDirection: Flickable.HorizontalFlick
                clip: true
                Row {
                    id: hourlyRow
                    spacing: root.width * 0.02
                    height: parent.height
                    Repeater {
                        model: hourlyWeatherModel
                        delegate: Rectangle {
                            id: hourlyDelegate
                            required property string time
                            required property string temp
                            required property int    index
                            property bool isCurrent: index === root.currentHour
                            width: root.width * 0.08; height: hourlyRow.height
                            color: hourlyDelegate.isCurrent ? "#12495f" : "#ffffff"
                            radius: root.height * 0.01
                            opacity: hourlyDelegate.isCurrent ? 1.0 : 0.7
                            border.color: hourlyDelegate.isCurrent ? "#4fc3f7" : "#000000"; border.width: 1
                            Behavior on scale   { NumberAnimation { duration: 120 } }
                            Behavior on opacity { NumberAnimation { duration: 120 } }
                            Column {
                                anchors.horizontalCenter: parent.horizontalCenter
                                topPadding: parent.height * 0.1
                                spacing: root.height * 0.005
                                Text { 
                                    text: hourlyDelegate.time; color: hourlyDelegate.isCurrent ? "#ffffff" : "#001224"
                                    font { pointSize: root.height * 0.02; family: "Arial" }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Rectangle { width: parent.width * 0.8; height: 1; color: hourlyDelegate.isCurrent ? "#4fc3f7" : "#12495f"; radius: width / 2; anchors.horizontalCenter: parent.horizontalCenter }
                                Text { 
                                    text: hourlyDelegate.temp; 
                                    color: hourlyDelegate.isCurrent ? "#ffffff" : "#001224"; 
                                    font { 
                                        pointSize: root.height * 0.035; 
                                        bold: true; 
                                        family: "Arial" 
                                    } 
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea {
                                anchors.fill: parent; hoverEnabled: true
                                onEntered: { hourlyDelegate.scale = 1.01; hourlyDelegate.opacity = 1.0; hourlyDelegate.border.width = 2 }
                                onExited:  { hourlyDelegate.scale = 1.0;  hourlyDelegate.opacity = 0.8; hourlyDelegate.border.width = hourlyDelegate.isCurrent ? 1 : 0 }
                            }
                        }
                    }
                }
            }
        }

        // Weekly + Details row
        Row {
            spacing: root.width * 0.024
            anchors.horizontalCenter: parent.horizontalCenter

            // Weekly
            Rectangle {
                id: weeklyContainer
                width: root.width * 0.4; height: root.height * 0.43
                color: "#12495f"; opacity: 0.8; radius: root.height * 0.025
                Behavior on scale   { NumberAnimation { duration: 120 } }
                Behavior on opacity { NumberAnimation { duration: 120 } }
                MouseArea {
                    anchors.fill: parent; hoverEnabled: true
                    onEntered: { weeklyContainer.scale = 1.05; weeklyContainer.opacity = 1.0 }
                    onExited:  { weeklyContainer.scale = 1.0;  weeklyContainer.opacity = 0.8 }
                }
                Column {
                    anchors.centerIn: parent
                    spacing: root.height * 0.015
                    width: weeklyContainer.width - root.height * 0.04
                    Row {
                        width: parent.width
                        Text { text: "Day";      color: "#b9b9b9"; font { pointSize: root.height * 0.018; family: "Arial"; bold: true }
                            width: parent.width * 0.42 }
                        Text { text: "UV";       color: "#b9b9b9"; font { pointSize: root.height * 0.018; family: "Arial"; bold: true }
                            width: parent.width * 0.08; horizontalAlignment: Text.AlignHCenter }
                        Text { text: "Max / Min"; color: "#b9b9b9"; font { pointSize: root.height * 0.018; family: "Arial"; bold: true }
                            width: parent.width * 0.45; horizontalAlignment: Text.AlignRight }
                    }
                    Rectangle { width: parent.width; height: 1; color: "#ffffff"; opacity: 0.25 }
                    Repeater {
                        model: dailyWeatherModel
                        delegate: Row {
                            id: dailyRow
                            required property string day
                            required property string maxTemp
                            required property string minTemp
                            required property var    uvIndex
                            width: weeklyContainer.width - root.height * 0.04
                            Text { 
                                text: dailyRow.day; color: "white";
                                font { pointSize: root.height * 0.022; family: "Arial"; bold: true }
                                width: parent.width * 0.44 
                            }
                            Text {
                                text: { var uv = Math.round(dailyRow.uvIndex); return uv<=2?"🌤 "+dailyRow.uvIndex:uv<=5?"☀️ "+dailyRow.uvIndex:uv<=7?"🌞 "+dailyRow.uvIndex:uv<=10?"🔆 "+dailyRow.uvIndex:"🔥 "+dailyRow.uvIndex }
                                color: { var uv = Math.round(dailyRow.uvIndex); return uv<=2?"#a8d8a8":uv<=5?"#f9e07a":uv<=7?"#f4a445":uv<=10?"#e05a5a":"#c060c0" }
                                font { pointSize: root.height * 0.020; family: "Arial"; bold: true }
                                width: parent.width * 0.1
                            }
                            Text { text: dailyRow.maxTemp + " / " + dailyRow.minTemp; color: "white"; font { pointSize: root.height * 0.020; family: "Arial" }
                                horizontalAlignment: Text.AlignRight; width: parent.width * 0.45 
                            }
                        }
                    }
                }
            }

            Rectangle { width: 1; height: weeklyContainer.height; color: "#ffffff"; opacity: 0.4 }

            // Info grid
            Grid {
                columns: 2
                width: root.width * 0.35; height: root.height * 0.43
                rowSpacing: root.height * 0.02; columnSpacing: root.width * 0.02
                Repeater {
                    model: weatherInfoModel
                    delegate: Rectangle {
                        id: infoDelegate
                        required property var modelData
                        width: (root.width * 0.35 - root.width * 0.02) / 2
                        height: (root.height * 0.43 - root.height * 0.02) / 2
                        color: "#12495f"; opacity: 0.8; radius: root.height * 0.015
                        Behavior on scale   { NumberAnimation { duration: 120 } }
                        Behavior on opacity { NumberAnimation { duration: 120 } }
                        MouseArea {
                            anchors.fill: parent; hoverEnabled: true
                            onEntered: { infoDelegate.scale = 1.05; infoDelegate.opacity = 1.0 }
                            onExited:  { infoDelegate.scale = 1.0;  infoDelegate.opacity = 0.8 }
                        }
                        Column {
                            anchors.centerIn: parent; spacing: root.height * 0.009
                            Text { text: infoDelegate.modelData.emoji; font.pointSize: root.height * 0.035; anchors.horizontalCenter: parent.horizontalCenter }
                            Text { text: infoDelegate.modelData.label; color: "#ffffff"; font { pointSize: root.height * 0.02; family: "Arial" }
                                anchors.horizontalCenter: parent.horizontalCenter }
                            Text { text: infoDelegate.modelData.value; color: "#e0e0e0"; font { pointSize: root.height * 0.028; family: "Arial"; bold: true }
                                anchors.horizontalCenter: parent.horizontalCenter }
                        }
                    }
                }
            }
        }
    }

    // API
    WeatherAPI {
        id: weatherAPI
        onWeatherReceived: function(current, daily, hourly, location) {
            cityName.text         = location.name + ", " + location.country
            temperature.text      = Math.round(current.temperature_2m) + "°C"
            feelsLike.text        = "Feels like: " + Math.round(current.apparent_temperature) + "°C"
            weatherEmojiText.text = root.weatherEmoji(current.weather_code, current.is_day)
            populationValue.text  = location.population.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
            root.currentHour      = parseInt(current.time.split("T")[1].split(":")[0])

            var code = current.weather_code
            if      (code === 0)  weatherDescription.text = current.is_day ? "Clear Sky" : "Clear Night"
            else if (code <= 2)   weatherDescription.text = "Partly Cloudy"
            else if (code === 3)  weatherDescription.text = "Overcast"
            else if (code <= 48)  weatherDescription.text = "Foggy"
            else if (code <= 55)  weatherDescription.text = "Drizzle"
            else if (code <= 65)  weatherDescription.text = "Rainy"
            else if (code <= 75)  weatherDescription.text = "Snowy"
            else if (code <= 82)  weatherDescription.text = "Rain Showers"
            else if (code <= 99)  weatherDescription.text = "Thunderstorm"

            weatherInfoModel.setProperty(0, "value", Math.round(current.wind_speed_10m)   + " km/h")
            weatherInfoModel.setProperty(1, "value", current.relative_humidity_2m         + "%")
            weatherInfoModel.setProperty(2, "value", current.wind_direction_10m           + "°")
            weatherInfoModel.setProperty(3, "value", Math.round(current.surface_pressure) + " hPa")

            hourlyWeatherModel.clear()
            for (var i = 0; i < 24; i++) {
                var amPm = i < 12 ? "AM" : "PM"
                var hour = i % 12 === 0 ? "12" : (i % 12).toString()
                hourlyWeatherModel.append({ "time": hour + " " + amPm, "temp": Math.round(hourly.temperature_2m[i]) + "°C" })
            }
            var dayNames = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
            dailyWeatherModel.clear()
            for (var j = 0; j < daily.time.length; j++) {
                var date = new Date(daily.time[j])
                dailyWeatherModel.append({
                    "day":     j === 0 ? "Today" : j === 1 ? "Tomorrow" : dayNames[date.getDay()],
                    "maxTemp": Math.round(daily.temperature_2m_max[j]) + "°C",
                    "minTemp": Math.round(daily.temperature_2m_min[j]) + "°C",
                    "uvIndex": daily.uv_index_max[j]
                })
            }
        }
        onCityNotFound:  function(city)    { cityInput.text = "⚠️ City Not found!" }
        onNetworkError:  function(message) { cityInput.text = "⚠️ Network error"  }
    }

    // Auto-fetch when page loads or city changes
    onCityChanged: {
        if(city !== "" && weatherAPI) {
            weatherAPI.fetch(city)
            cityInput.text = city
        }
    }
    
    Component.onCompleted: {
        if(root.city !== "") {
            cityInput.text = root.city
            weatherAPI.fetch(root.city)
        }
    }
}
