/*
    harbour-bian
    Copyright (C) 2015  Sebastian Weiler

    See LICENSE.
 */
/*
Version:   0.1
Date:      23.08.2015
*/
import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "DBModule.js" as DBModule
import "CanvasModule.js" as CanvasModule
import "SharedInfo.js" as Shared
Dialog {
    id: addDialog

    //properties to define behavior
    property int dialogType: 0
    property string placeholderLong: ""
    property string placeholderShort: ""

    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: column
            width: addDialog.width
            spacing: Theme.paddingSmall

            DialogHeader {
                acceptText: qsTr("save")
                cancelText: qsTr("cancel")
            }

            TextField {
                id: valueId
                width: addDialog.width
                focus: true
                anchors {
                           left: parent.left
                           right: parent.right
                           margins: Theme.paddingLarge
                       }
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                placeholderText: placeholderLong
                label: placeholderShort
            }
        }
    }

    onDone: {
        if (result === DialogResult.Accepted) {
            Shared.isStartUp = true;
            var canvasModule = CanvasModule.CanvasModule;
            if(dialogType === canvasModule.getTypeWeight()){
                DBModule.DBModule.saveWeight(new Date(),valueId.text)
            }
            else if(dialogType === canvasModule.getTypeGlucose()){
                DBModule.DBModule.saveGlucose(new Date(),valueId.text)
            }else{
                console.error("dialogType " + dialogType + " not found!")
            }
        }

    }
}
