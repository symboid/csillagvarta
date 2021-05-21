
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Dox 1.0

Document {
    id: mainDocument

    title: radixScreen.horaTitle
    onTitleChanged: {
        radixScreen.horaTitle = title
        title = Qt.binding(function(){return radixScreen.horaTitle})
    }
    onLoadStarted: radixScreen.autocalc = false
    onLoadFinished: radixScreen.autocalc = true
    onLoadFailed: radixScreen.autocalc = true

    DocumentNode {
        name: "radix"

        property alias title: radixScreen.horaTitle

        DocumentNode {
            name: "time"
            property alias year: radixScreen.horaYear
            property alias month: radixScreen.horaMonth
            property alias day: radixScreen.horaDay
            property alias hour: radixScreen.horaHour
            property alias minute: radixScreen.horaMinute
            property alias second: radixScreen.horaSecond
            property alias calendarType: radixScreen.horaCalendarType
        }
        DocumentNode {
            name: "geoLoc"
            property alias geoName: radixScreen.horaGeoName
            property alias latt: radixScreen.horaGeoLatt
            property alias lont: radixScreen.horaGeoLont
            property alias tzDiff: radixScreen.horaGeoTzDiff
        }
    }

    onLoadCurrent: {
        radixScreen.setCurrent()
    }
}
