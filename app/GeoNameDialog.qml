
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Symboid.Astro.Controls 1.0
import QtPositioning 5.12

Drawer {
    property string geoName: ""
    property double geoLatt: 0
    property double geoLont: 0

    opacity: 0.75

    Flickable {
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        Flow {
            id: searchGeoName
            anchors.left: parent.left
            anchors.right: parent.right
            Rectangle {
                width: parent.width
                height: 1
                color: "black"
            }
            Label {
                padding: 15
                width: parent.width
                font.italic: true
                font.bold: true
                text: qsTr("Geographic name lookup:")
            }
            Item {
                height: searchBox.height
                width: searchButton.width
                RoundButton {
                    id: searchButton
                    y: searchBox.height / 2
                    icon.source: "file:///home/robert/Munka/icons/black/png/br_down_icon&16.png"
                    enabled: searchBox.selectedItem !== null
                    onClicked: {
                        if (searchBox.selectedItem)
                        {
                            geoName = searchBox.selectedItem.geoName
                            geoLatt = searchBox.selectedItem.lattArcDegree
                            geoLont = searchBox.selectedItem.lontArcDegree
                            close()
                        }
                    }
                }
            }

            GeoNamesSearchBox {
                id: searchBox
                width: parent.width - searchButton.width - 15
                height: 500
            }
            Rectangle {
                width: parent.width
                height: 1
                color: "black"
            }
            Label {
                padding: 15
                width: parent.width
                font.italic: true
                font.bold: true
                text: qsTr("Current geographic location:")
            }
            Item {
                height: currLoc.height
                width: currButton.width
                RoundButton {
                    id: currButton
                    icon.source: "file:///home/robert/Munka/icons/black/png/br_down_icon&16.png"
                    onClicked: {
                        geoName = currLoc.geoName
                        geoLatt = currLoc.lattArcDegree
                        geoLont = currLoc.lontArcDegree
                        close()
                    }
                }
            }
            GeoNamesSearchItem {
                id: currLoc

                width: parent.width - currButton.width - 15
                PositionSource {
                    id: positionSrc
                    updateInterval: 1000
                    active: true
                    onPositionChanged: {
                        if (valid)
                        {
                            if (position.latitudeValid)
                            {
                                lattArcDegree = position.coordinate.latitude
                            }
                            if (position.longitudeValid)
                            {
                                lontArcDegree = position.coordinate.longitude
                            }
                        }
                    }
                    onSourceErrorChanged: {
                        if (sourceError !== PositionSource.NoError)
                        {
                            currButton.enabled = false
                        }
                    }
                }
            }
            Rectangle {
                width: parent.width
                height: 1
                color: "black"
            }
        }
    }
}
