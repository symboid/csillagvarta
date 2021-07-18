
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Hora 1.0

Page {

    property Component buttonRow: Component {
        Row {
            ToolButton {
                icon.source: "/icons/br_prev_icon&32.png"
                width: 80
                enabled: documentBrowser.docPageIndex > 0
                onClicked: documentBrowser.backward()
            }
            ToolButton {
                icon.source: "/icons/home_icon&32.png"
                width: 80
                highlighted: true
                onClicked: documentBrowser.docPageDialogOpen()
            }
            ToolButton {
                icon.source: "/icons/br_next_icon&32.png"
                width: 80
                enabled: documentBrowser.docPageIndex < documentBrowser.docPageCount - 1
                onClicked: documentBrowser.forward()
            }
        }
    }

    property var radixModel: [
        {
            radixTitle: radixScreen.pageTitle,
            radixHora: radixScreen.hora
        }
    ]

    DocumentBrowser {
        id: documentBrowser
        anchors.fill: parent
        initialPage: RadixScreen {
            id: radixScreen
            horaTitle: qsTr("Current transit")
        }
        docListModel: radixModel
        currentDocIndex: (currentPage instanceof RadixScreen) ? docPageIndex : currentPage.docIndex
        fileMenuModel: ListModel {
            ListElement {
                itemTitle: qsTr("New (Radix)")
                itemIcon: "/icons/doc_new_icon&32.png"
                itemClicked: function() { loadDocument("", "") }
            }
            ListElement {
                itemTitle: qsTr("Save")
                itemIcon: "/icons/save_icon&32.png"
                itemClicked: function() { }
            }
            ListElement {
                itemTitle: qsTr("Print")
                itemIcon: "/icons/print_icon&32.png"
                itemClicked: function() { }
            }
            ListElement {
                itemTitle: qsTr("Save to image")
                itemIcon: "/icons/shapes_icon&32.png"
                itemClicked: function() { }
            }
            ListElement {
                itemTitle: qsTr("Close")
                itemIcon: "/icons/delete_icon&32.png"
                itemClicked: function() { documentBrowser.closeCurrentPage() }
            }
        }
        docMethodModel: ListModel {
            ListElement {
                methodTitle: qsTr("Forecast tabulars")
                methodLoadClicked: function() { loadDocPage("qrc:/ForecastScreen.qml") }
            }
            ListElement {
                methodTitle: qsTr("Revolution")
                methodLoadClicked: function() { loadDocPage("qrc:/RevolutionScreen.qml") }
            }
            ListElement {
                methodTitle: qsTr("Synastry")
                methodLoadClicked: function() { loadDocPage("qrc:/SynastryScreen.qml") }
            }
        }
        createDocPage: function(viewName)
        {
            var screenComponent = Qt.createComponent(viewName)
            return screenComponent.createObject(this)
        }
        closeDocPage: function(docPage)
        {
            if (docPage instanceof RadixScreen)
            {
                var radixIndex = -1
                for (var r = 0; radixIndex === -1 && r < radixModel.length; ++r)
                {
                    if (radixModel[r].radixHora === docPage.hora)
                    {
                        radixIndex = r
                    }
                }
                if (radixIndex !== -1)
                {
                    radixModel.splice(radixIndex, 1)
                    radixModelChanged()
                }
            }
        }
    }

    property Popup loadingPopup: Popup {
        anchors.centerIn: parent
        height: pageTitle.height * 2
        width: Math.min(pageTitle.width * 3, parent.width - 50)
        onOpened: loadingTimer.start()
        Timer {
            id: loadingTimer
            interval: 700
            onTriggered: loadingPopup.close()
        }
        Label {
            id: pageTitle
            anchors.centerIn: parent
            font.italic: true
        }
        function show(title)
        {
            pageTitle.text = title
            open()
        }
    }

    function loadDocument(documentPath, documentTitle)
    {
        var radixScreen = documentBrowser.newDocPage("qrc:/RadixScreen.qml")
        var document = radixScreen.mainDocument
        document.title = documentTitle
        if (documentPath !== undefined && documentPath !== "")
        {
            document.filePath = documentPath
            document.load()
        }
        else
        {
            document.loadCurrent()
        }
        radixModel.push({ radixTitle: document.title, radixHora: radixScreen.hora })
        radixModelChanged()
        return document
    }
    function loadDocPage(docPageUrl)
    {
        return documentBrowser.newDocPage(docPageUrl)
    }
}
