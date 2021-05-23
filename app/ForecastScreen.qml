
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Astro.Hora 1.0

DocViewScreen {

    property Hora radixHora: null
    property HoraCoords radixCoords: radixHora.coords

    MainScreenComboBox {
        title: qsTr("Forecast type")
        model: [
            qsTr("Primary direction"),
            qsTr("Secondary direction"),
            qsTr("Transit")
        ]
    }

    DirexModel {
        id: direxModel
    }

    TransitModel {
        id: transitModel
    }

    MainScreenParamBox {
        id: periodParam
        title: qsTr("Period")
        DateCoordBox {
            id: periodBeginDate
            editable: true
        }
        DateCoordBox {
            id: periodEndDate
            editable: true
        }
    }

    MultiDataView {
        width: metrics.isTransLandscape ? horzMandalaSpace : mandalaSize
        height: mandalaSize
        Page {
            ForecastTablePane {
                anchors.fill: parent
                hora: radixHora
                periodBegin: HoraCoords {
                    year: periodBeginDate.year
                    month: periodBeginDate.month
                    day: periodBeginDate.day
                }
                periodEnd: HoraCoords {
                    year: periodEndDate.year
                    month: periodEndDate.month
                    day: periodEndDate.day
                }
                forecastModel: TransitModel {
                }
            }
        }
    }

    MainScreenDateTimeBox {
        id: radixDateTimeParams
        title: qsTr("Radix date and time")
        showSeconds: false
        editable: false
        year: radixCoords.year
        month: radixCoords.month
        day: radixCoords.day
        hour: radixCoords.hour
        minute: radixCoords.minute
    }

    MainScreenParamBox {
        title: qsTr("Radix positioning")
        Repeater {
            model: ListModel {
                ListElement {
                    titleText: qsTr("Minutes")
                }
                ListElement {
                    titleText: qsTr("Hours")
                }
                ListElement {
                    titleText: qsTr("Days")
                }
            }

            delegate: Pane {
                Row {
                    RoundButton {
                        radius: 0
                        icon.source: "file:/home/robert/Munka/icons/black/png/playback_prev_icon&24.png"
                    }
                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: titleText
                        width: 100
                        horizontalAlignment: Label.AlignHCenter
                    }
                    RoundButton {
                        radius: 0
                        icon.source: "file:/home/robert/Munka/icons/black/png/playback_next_icon&24.png"
                    }
                }
            }
        }
    }

}
