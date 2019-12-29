
import QtQuick 2.6
import QtQuick.Controls 2.0
import Symboid.Sdk.App 1.0
import Symboid.Sdk.App 1.0
import Symboid.Sdk.Dox 1.0
import Symboid.Astro.Calculo 1.0

Rectangle {

    property alias processStepCount: processView.count
    property alias processStepIndex: processView.currentIndex

    function processSetPageIndex(pageIndex)
    {
        processView.currentPage = processView.itemAt(pageIndex)
    }
    function processBack()
    {
        processView.currentPage = processView.itemAt(processView.currentIndex - 1)
    }
    function processFwd()
    {
        processView.currentPage = processView.itemAt(processView.currentIndex + 1)
    }
    function processSetPage(nextPage)
    {
        processView.currentPage = nextPage
    }

    ProcessView {
        id: processView
        anchors.fill: parent

        CatalogPage {
            id: catalogPage
            onLoadClicked: {
                docPage.docPath = listModel.filePath(index)
                processSetPage(docPage)
            }
        }

        StartPage {
            id: startPage

            onLoadClicked: {
                switch (index)
                {
                case StartModel.DOC_CREATE:
                    docCreateDialog.docTitle = ""
                    docCreateDialog.open()
                    break
                case StartModel.DOC_OPEN:  processSetPage(catalogPage); break
                case StartModel.DOC_CURRENT:  processSetPage(horaPage); break
                default:
                    docPage.docPath = listModel.filePath(index)
                    processSetPage(docPage);
                    break
                }
            }

            DocTitleDialog {
                id: docCreateDialog
                acceptButtonText: qsTr("Create")
                onAccepted: {
                    inputPage.currentView = docPage.mainDoc.createNew(docTitle)
                    catalogPage.listModel.refresh()
                    processSetPage(inputPage)
                }
            }
        }

        DocPage {
            id: docPage
            onLoadClicked: processSetPage(inputPage)
        }

        InputPage {
            id: inputPage

            DocViews {
                id: docViews
                mainDoc: docPage.mainDoc
                viewIndex: docPage.clickedItemIndex
            }

            property var currentView: docPage.mainDoc.viewData(docPage.clickedItemIndex)

            inputName: currentView.name !== undefined ? currentView.name : ""

            inputComponent: docViews.docViewComponent(docPage.docViewType)

            onPageLeaved: inputView.save(inputName)

            onCalcClicked: processSetPage(horaPage)
        }

        HoraPage {
            id: horaPage

            parameters: inputPage.inputView.parameters

            onPageEntered: view.recalc()
        }
    }

    Item {
        id: processItem
        Component.onCompleted: processSetPage(startPage)
    }

}
