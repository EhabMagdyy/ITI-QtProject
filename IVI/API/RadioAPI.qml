import QtQuick

QtObject {
    id: radioAPI

    // Required references from Radio.qml
    required property var    stationsModel
    required property var    radioPlayer
    required property var    radioPage

    function fetchData(url, callback) {
        var xhr = new XMLHttpRequest()
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) callback(xhr.responseText)
                else callback(null)
            }
        }
        xhr.open("GET", url)
        xhr.send()
    }

    function buildURL() {
        var url = "https://de1.api.radio-browser.info/json/stations/search?"
        url += "hidebroken=true"
        url += "&limit=100"        // ← fetch 100 at once, no pagination needed
        url += "&order=votes&reverse=true"
        if (radioPage.searchQuery) url += "&name=" + encodeURIComponent(radioPage.searchQuery)
        if (radioPage.tagFilter)   url += "&tag="  + encodeURIComponent(radioPage.tagFilter)
        return url
    }

    function fetchStations() {
        stationsModel.clear()
        fetchData(buildURL(), function(response) {
            if (!response) return
            var data = JSON.parse(response)
            for (var i = 0; i < data.length; i++) {
                stationsModel.append({
                    stationuuid: data[i].stationuuid,
                    name:        data[i].name,
                    url:         data[i].url_resolved || data[i].url,
                    favicon:     data[i].favicon || "",
                    codec:       data[i].codec,
                    tags:        data[i].tags,
                    country:     data[i].country,
                    votes:       data[i].votes
                })
            }
        })
    }

    function playStation(station) {
        radioPage.currentStation = station
        radioPlayer.stop()
        radioPlayer.source = station.url
        fetchData("https://de1.api.radio-browser.info/json/url/" + station.stationuuid, function() {})
        radioPlayer.play()
    }

    function togglePlayPause() {
        radioPlayer.playbackState === MediaPlayer.PlayingState
            ? radioPlayer.pause()
            : radioPlayer.play()
    }
}