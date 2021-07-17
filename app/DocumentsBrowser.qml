
import QtQuick 2.12
import QtQuick.Controls 2.5
import Symboid.Sdk.Controls 1.0

StackView {

    readonly property int docPageCount: depth + forwardStack.depth
    property int docPageIndex: 0

    property RadixScreen radixScreen: null

    initialItem: radixScreen
    pushEnter: null
    pushExit: null
    popEnter: null
    popExit: null

    StackObject {
        id: forwardStack
    }

    function backward()
    {
        forwardStack.push(pop())
        --docPageIndex
    }
    function forward()
    {
        push(forwardStack.pop())
        ++docPageIndex
    }
    function newDocPage(viewName)
    {
        var screenComponent = Qt.createComponent(viewName)
        var screen = screenComponent.createObject(this)
        forwardStack.cleanup()
        push(screen)
        docPageIndex++
    }
    function switchDocPage(pageIndex)
    {
        while (depth < pageIndex + 1)
        {
            push(forwardStack.pop())
        }
        while (depth > pageIndex + 1)
        {
            forwardStack.push(pop())
        }
        docPageIndex = pageIndex
    }

    Connections {
        target: currentItem
        function onCloseView()
        {
            if (depth > 1)
            {
                pop()
                docPageIndex--
            }
            else if (forwardStack.depth > 0)
            {
                replace(currentItem, forwardStack.pop())
            }
        }
    }

    function pageLoadDialogOpen()
    {
        pageLoadDialog.open()
    }
    PageLoadDialog {
        id: pageLoadDialog
        anchors.centerIn: parent
        width: Math.min(400, parent.width - 50)
        height: parent.height - 2 * 50

        docPageCount: parent.docPageCount

        onLoadDocView: newDocPage(viewName)
        onSwitchDocPage: parent.switchDocPage(viewIndex)
    }
}
