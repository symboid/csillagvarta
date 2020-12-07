
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Controls 1.0 as Sdk
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Controls 1.0
import Symboid.Astro.Db 1.0
import Symboid.Astro.Hora 1.0
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Sdk.MainScreen {

    function setCurrent()
    {
        dateTimeParams.setCurrent()
    }

    signal documentSaved

    Drawer {
        id: messageDialog
        edge: Qt.TopEdge
        dragMargin: 0
        width: parent.width
        topPadding: 20
        bottomPadding: 20
//        closePolicy: showBusy ? Popup.NoAutoClose : Popup.CloseOnEscape | Popup.CloseOnPressOutside
        contentItem: Column {
            DialogButtonBox {
                id: buttonBox
                alignment: Qt.AlignHCenter
                anchors.left: parent.left
                anchors.right: parent.right
                standardButtons: DialogButtonBox.Yes | DialogButtonBox.No
            }
        }
    }

    MainScreenParamBox {
        title: qsTr("Horoscope name")
        MainScreenTextField {
            id: horaName
            button: RoundButton {
                radius: 5
                enabled: horaName.text !== ""
                display: RoundButton.IconOnly
                icon.source: "/icons/save_icon&32.png"
                icon.color: "#C94848"
                onClicked: {
                    if (horaDocument.save())
                    {
                        documentSaved()
//                        infoPopup.show(qsTr("Horoscope of '%1' saved.").arg(horaName.text))
                        messageDialog.open()
                    }
                    else
                    {
                        errorPopup.show(qsTr("Failed to save horoscope of '%1'!").arg(horaName.text))
                    }
                }
            }
        }
    }

    MainScreenDateTimeBox {
        id: dateTimeParams
        showCurrentTimer: details.checked
    }

    MainScreenParamBox {
        id: calendarParam
        title: qsTr("Calendar")
        visible: details.checked
        MainScreenComboBox {
            id: calendarType
            model: [ "Gregorian", "Julian" ]
        }
    }

    MainScreenViewSelector {
        id: viewSelector
        viewNames: [ qsTr("Chart"), qsTr("Planet positions"), qsTr("House cusps") ]
        referenceItem: details.checked ? calendarParam : dateTimeParams
    }

    StackLayout {
        width: metrics.mandalaSize
        height: metrics.mandalaSize
        currentIndex: viewSelector.currentIndex
        HoraPanel {
            id: horaPanel
            isLandscape: metrics.isLandscape
            minHoraSize: metrics.mandalaSize
            horaSize: metrics.mandalaSize

            year: dateTimeParams.year
            month: dateTimeParams.month
            day: dateTimeParams.day
            hour: dateTimeParams.hour
            minute: dateTimeParams.minute
            second: dateTimeParams.second

            geoLatt: locationParams.geoLatt
            geoLont: locationParams.geoLont
            tzDiff: locationParams.geoTzDiff

            housesType: housesType.currentToken()
            withJulianCalendar: calendarType.currentIndex !== 0
        }
        Item {
            PlanetsTableView {
                id: planetTableView
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: showPlanetSeconds.top

                tableModel: horaPanel.planetsModel
                showSeconds: showPlanetSeconds.checked
            }
            CheckBox {
                id: showPlanetSeconds
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 20
                }
                text: qsTr("Show seconds")
                onCheckedChanged: {
                    planetTableView.tableModel.update()
                }
            }
        }
        Item {
            HousesTableView {
                id: houseTableView
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: showHousesSeconds.top

                tableModel: horaPanel.housesModel
                showSeconds: showHousesSeconds.checked
            }
            CheckBox {
                id: showHousesSeconds
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 20
                }
                text: qsTr("Show seconds")
                onCheckedChanged: {
                    houseTableView.tableModel.update()
                }
            }
        }
    }

    MainScreenLocationBox {
        id: locationParams
        showDetails: details.checked
    }

    MainScreenParamBox {
        id: houseSystemParams
        title: qsTr("House system")
        visible: details.checked

        MainScreenComboBox {
            id: housesType
            textRole: "name"
            model: ListModel {
                ListElement {
                    name: qsTr("Placidus")
                    token: "placidus"
                }
                ListElement {
                    name: qsTr("Koch")
                    token: "koch"
                }
                ListElement {
                    name: qsTr("Regiomontanus")
                    token: "regiomontanus"
                }
                ListElement {
                    name: qsTr("Campanus")
                    token: "campanus"
                }
                ListElement {
                    name: qsTr("Equal")
                    token: "equal"
                }
            }
            function currentToken()
            {
                return model.data(model.index(currentIndex, 0))
            }
        }
    }

    MainScreenDetailsSwitch {
        id: details
        referenceItem: checked ? houseSystemParams : locationParams
    }

    property Document horaDocument: Document {
        title: horaName.text
        onTitleChanged: {
            horaName.text = title
            title = Qt.binding(function(){return horaName.text})
        }
        onLoadStarted: horaPanel.interactive = false
        onLoadFinished: horaPanel.interactive = true
        onLoadFailed: horaPanel.interactive = true

        DocumentNode {
            name: "radix"

            property alias title: horaName.text

            DocumentNode {
                name: "time"
                property alias year: dateTimeParams.year
                property alias month: dateTimeParams.month
                property alias day: dateTimeParams.day
                property alias hour: dateTimeParams.hour
                property alias minute: dateTimeParams.minute
                property alias second: dateTimeParams.second
                property alias calendarType: calendarType.currentIndex
            }
            DocumentNode {
                name: "geoLoc"
                property alias geoName: locationParams.geoName
                property alias latt: locationParams.geoLatt
                property alias lont: locationParams.geoLont
                property alias tzDiff: locationParams.geoTzDiff
            }
        }

        onLoadCurrent: {
            setCurrent()
        }
        Component.onDestruction: {
        }
    }

    Component.onCompleted: {
        dateTimeParams.setCurrent()
        horaPanel.interactive = true
    }
}
