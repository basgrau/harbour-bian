/*
Version:   0.1
Date:      17.08.2015
*/
import QtQuick 2.0
import Sailfish.Silica 1.0
import "CanvasModule.js" as CanvasModule
import QtQuick.LocalStorage 2.0
import "DBModule.js" as DBModule
Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingSmall
            PageHeader {
                title: qsTr("Lastest:")
            }
            Label {
                anchors {
                           left: parent.left
                           right: parent.right
                           margins: Theme.paddingLarge
                       }
                text: "latest BloodSugar-Level in mg/dl"
            }
            Canvas {
                anchors {
                           left: parent.left
                           right: parent.right
                           margins: Theme.paddingLarge
                       }
                id: glucoseCanvas
                width: parent.width
                height: 320
                onPaint: {
                    var gL = DBModule.DBModule.getLastGlucose()
                    var gB = DBModule.DBModule.getValueBeforeGlucose()
                    var gA = DBModule.DBModule.getAverageGlucose()
                    CanvasModule.CanvasModule.draw(gL,gB,gA,getContext("2d"),0);
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("BloodSugarPage.qml"))
                    }
                }
            }
            Label {
                anchors {
                           left: parent.left
                           right: parent.right
                           margins: Theme.paddingLarge
                       }
                text: "latest weight in kg"
            }
            Canvas {
                anchors {
                           left: parent.left
                           right: parent.right
                           margins: Theme.paddingLarge
                       }
                id: weightCanvas
                width: parent.width
                height: 320
                onPaint: {
                    var wL = DBModule.DBModule.getLastWeight()
                    var wB = DBModule.DBModule.getValueBeforeWeight()
                   CanvasModule.CanvasModule.draw(wL,wB,0,getContext("2d"),1)

                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("WeightPage.qml"))
                    }
                }
            }
        }
        onVisibleChanged: {

            if(visible){
                console.log("vis")
                if(weightCanvas.available){
                    var wL = DBModule.DBModule.getLastWeight()
                    var wB = DBModule.DBModule.getValueBeforeWeight()
                     var context = weightCanvas.getContext("2d")
                    if(context === null){
                        return
                    }
                    context.reset()
                    context = weightCanvas.getContext("2d")
                    weightCanvas.width = parent.width
                    weightCanvas.height = 320
                    weightCanvas.update()
                    CanvasModule.CanvasModule.draw(wL,wB,0,context,1)
                }
                 if(glucoseCanvas.available){

                var gL = DBModule.DBModule.getLastGlucose()
                var gB = DBModule.DBModule.getValueBeforeGlucose()
                var gA = DBModule.DBModule.getAverageGlucose()

                var contextG = glucoseCanvas.getContext("2d")

                if(contextG === null){
                    return
                }


                contextG.reset()

                contextG = glucoseCanvas.getContext("2d")
                glucoseCanvas.width = parent.width
                glucoseCanvas.height = 320
                glucoseCanvas.update()


                CanvasModule.CanvasModule.draw(gL,gB,gA,contextG,0)
                }
            }
        }
    }
}
