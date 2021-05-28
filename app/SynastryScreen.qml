
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Astro.Db 1.0
import Symboid.Astro.Hora 1.0
import QtQuick.Layouts 1.12

DocViewScreen {

    property Hora radixHora: null

    property alias horaTitle: horaName.text
    property alias horaButton: horaName.button
    property alias showCurrent: dateTimeParams.showCurrentTimer
    property alias showDetails: details.checked
    property alias autocalc: horaPanel.autocalc

    property alias horaYear: dateTimeParams.year
    property alias horaMonth: dateTimeParams.month
    property alias horaDay: dateTimeParams.day
    property alias horaHour: dateTimeParams.hour
    property alias horaMinute: dateTimeParams.minute
    property alias horaSecond: dateTimeParams.second
    property alias horaCalendarType: calendarType.currentIndex

    property alias horaGeoName: locationParams.geoName
    property alias horaGeoLatt: locationParams.geoLatt
    property alias horaGeoLont: locationParams.geoLont
    property alias horaGeoTzDiff: locationParams.geoTzDiff

    function setCurrent()
    {
        dateTimeParams.setCurrent()
    }

    MainScreenParamBox {
        title: qsTr("Horoscope name")
        MainScreenTextField {
            id: horaName
            placeholderText: qsTr("Enter a name!")
        }
    }

    MainScreenDateTimeBox {
        id: dateTimeParams
        showSeconds: details.checked
        popupParent: parent
    }

    MainScreenComboBox {
        id: calendarType
        title: qsTr("Calendar")
        visible: details.checked
        model: [ qsTr("Gregorian"), qsTr("Julian") ]
    }

    Item {
        id: bottomPaneHelper
        width: 1; height: 1
    }

    property Hora hora1: Hora {
        coords: HoraCoords {
            year: dateTimeParams.year
            month: dateTimeParams.month
            day: dateTimeParams.day
            hour: dateTimeParams.hour
            minute: dateTimeParams.minute
            second: dateTimeParams.second

            geoLatt: locationParams.geoLatt
            geoLont: locationParams.geoLont
            tzDiff: locationParams.geoTzDiff

            withJulianCalendar: calendarType.currentIndex !== 0
        }
    }

    MultiDataView {
        vertical: metrics.isLandscape
        width: metrics.isTransLandscape ? horzMandalaSpace : mandalaSize
        height: mandalaSize
        Page {
            HoraPanel {
                id: horaPanel
                anchors.fill: parent
                isLandscape: metrics.isLandscape
                withSeparator: true

                hora: hora1

//                housesType: radixHora.housesType
            }
        }
    }

    MainScreenLocationBox {
        id: locationParams
        showDetails: details.checked
    }

    MainScreenDetailsSwitch {
        id: details
        referenceItem: checked ? housesType : locationParams
    }
}
