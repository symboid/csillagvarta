
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Controls 1.0 as Sdk
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Astro.Db 1.0
import Symboid.Astro.Hora 1.0
import QtQuick.Layouts 1.12

HoraViewScreen {

    id: radixScreen

    showCurrent: showDetails

    property Document horaDocument: Document {
        title: horaTitle
        onTitleChanged: {
            horaTitle = title
            title = Qt.binding(function(){return horaTitle})
        }
        onLoadStarted: autocalc = false
        onLoadFinished: autocalc = true
        onLoadFailed: autocalc = true

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
            setCurrent()
        }
    }

    signal documentSaved

    horaTitleButton: RoundButton {
        radius: 5
        enabled: horaTitle !== ""
        display: RoundButton.IconOnly
        icon.source: "/icons/save_icon&32.png"
        icon.color: "#C94848"
        onClicked: {
            if (horaDocument.save())
            {
                documentSaved()
                infoPopup.show(qsTr("Horoscope of '%1' saved.").arg(horaTitle))
            }
            else
            {
                errorPopup.show(qsTr("Failed to save horoscope of '%1'!").arg(horaTitle))
            }
        }
    }

    Component.onCompleted: {
        setCurrent()
        autocalc = true
    }
}
