import QtQuick

QtObject {
    id: radioAPI

    required property var    stationsModel
    required property var    radioPlayer
    required property var    radioPage

    signal loadingStarted()
    signal loadingFinished()

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
        url += "&limit=100"
        url += "&order=votes&reverse=true"
        if (radioPage.searchQuery) url += "&name=" + encodeURIComponent(radioPage.searchQuery)
        if (radioPage.tagFilter)   url += "&tag="  + encodeURIComponent(radioPage.tagFilter)
        return url
    }

    function fetchStations() {
        loadingStarted()
        stationsModel.clear()
        fetchData(buildURL(), function(response) {
            loadingFinished()
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

    function playNext() {
        if (!radioPage.currentStation || stationsModel.count === 0) return
        var currentIndex = -1
        for (var i = 0; i < stationsModel.count; i++) {
            if (stationsModel.get(i).stationuuid === radioPage.currentStation.stationuuid) {
                currentIndex = i
                break
            }
        }
        var nextIndex = currentIndex + 1
        if (nextIndex >= stationsModel.count) nextIndex = 0
        var nextStation = stationsModel.get(nextIndex)
        playStation({
            stationuuid: nextStation.stationuuid,
            name:        nextStation.name,
            url:         nextStation.url,
            favicon:     nextStation.favicon,
            codec:       nextStation.codec,
            tags:        nextStation.tags,
            country:     nextStation.country
        })
    }

    function playPrevious() {
        if (!radioPage.currentStation || stationsModel.count === 0) return
        var currentIndex = -1
        for (var i = 0; i < stationsModel.count; i++) {
            if (stationsModel.get(i).stationuuid === radioPage.currentStation.stationuuid) {
                currentIndex = i
                break
            }
        }
        var prevIndex = currentIndex - 1
        if (prevIndex < 0) prevIndex = stationsModel.count - 1
        var prevStation = stationsModel.get(prevIndex)
        playStation({
            stationuuid: prevStation.stationuuid,
            name:        prevStation.name,
            url:         prevStation.url,
            favicon:     prevStation.favicon,
            codec:       prevStation.codec,
            tags:        prevStation.tags,
            country:     prevStation.country
        })
    }
}