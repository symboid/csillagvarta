
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
                onClicked: docPageDialog.open()
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
            pageTitle: qsTr("Current transit")
        }
        property int currentDocIndex: (currentPage instanceof RadixScreen) ? docPageIndex : currentPage.docIndex
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

    DocPageDialog {
        id: docPageDialog
        anchors.centerIn: parent
        width: Math.min(400, parent.width - 50)
        height: parent.height - 2 * 50

        docListModel: radixModel
        docPageCount: documentBrowser.docPageCount

        onLoadMethodPage: loadDocPage(methodPage)
        onSwitchDocPage: documentBrowser.switchDocPage(viewIndex)
        onOpened: selectedDocIndex = documentBrowser.currentDocIndex

        onMethodNewClicked: loadDocument("", "")
        onMethodSaveClicked: saveDocument()
        onMethodCloseClicked: documentBrowser.closeCurrentPage()
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
    function saveDocument()
    {
        var radixScreen = documentBrowser.get(documentBrowser.currentDocIndex)
        if (radixScreen !== undefined)
        {
            radixScreen.pageTitle = docPageDialog.selectedDocTitle
            if (radixScreen.mainDocument.save())
            {
               documentFolderScreen.refresh()
               infoPopup.show(qsTr("Document of '%1' saved.").arg(radixScreen.pageTitle))
            }
            else
            {
               errorPopup.show(qsTr("Failed to save document of '%1'!").arg(radixScreen.pageTitle))
            }
        }
    }

    function loadDocPage(docPageUrl)
    {
        return documentBrowser.newDocPage(docPageUrl)
    }
}
