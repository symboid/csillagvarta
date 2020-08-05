
import QtQuick 2.12
import Symboid.Sdk.Controls 1.0
import Symboid.Sdk.Dox 1.0

DocumentDialog {
    id: documentDialog
    width: Math.min(400, parent.width)
    height: parent.height
    edge: Qt.LeftEdge

    operations: [
        SavedDoxOperation {
            id: savedDox
            title: qsTr("Saved horoscopes")
            currentDocument: documentDialog.currentDocument
            onFinishExec: {
                recentDox.add(currentDocument.title, currentDocument.filePath)
                close()
            }
            onDocumentSaved: {
                recentDox.add(currentDocument.title, currentDocument.filePath)
                close()
            }
            onDocumentDeleted: recentDox.remove(documentPath)
        },
        InputOperation {
            title: qsTr("Current transit")
            canExec: true
            onExec: currentDocument.loadCurrent()
            onFinishExec: close()
        },
        RecentDoxOperation {
            id: recentDox
            title: qsTr("Recent horoscopes")
            currentDocument: documentDialog.currentDocument
            onFinishExec: {
                add(currentDocument.title, currentDocument.filePath)
                close()
            }
        }
    ]

    onOpened: {
        savedDox.init(currentDocument.title)
    }
}
