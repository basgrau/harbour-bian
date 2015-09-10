/*
    harbour-bian
    Copyright (C) 2015  Sebastian Weiler

    See LICENSE.
 */
/*
Version:   0.1
Date:      18.08.2015
*/
import QtQuick 2.0
import Sailfish.Silica 1.0
import "DBModule.js" as DBModule
//TODO setting for max weight and min weight, max glucose level, min glocuse
Dialog {
    id: settingsPage
    SilicaFlickable {
        anchors.fill: parent
        Column {
            id: column
            width: settingsPage.width
            spacing: Theme.paddingSmall
            DialogHeader {
                acceptText: qsTr("save")
                cancelText: qsTr("cancel")
            }
            Label {
                text: "TODO: Set all limits, for glucose and weight, min, max etc."
                width: settingsPage.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }

            TextField {
                id: a1
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

            TextField {
                id:a2
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

            TextField {
                id: a3
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

            Button {
                text: "reset settings"
                onClicked: {
                    remorseResett.execute("Reseting Settings", console.log("Todo"))
                }
                RemorsePopup {
                    id: remorseResett
                }
                width: settingsPage.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }
            Button {
                text: "delete storage"
                onClicked: {
                    remorseDrop.execute("Reseting Settings", function(){
                        var typeW = DBModule.DBModule._getTypeWeight()
                        var typeG = DBModule.DBModule._getTypeGlucose()
                        DBModule.DBModule._dropTable(typeW)
                        DBModule.DBModule._dropTable(typeG)
                    })
                }
                RemorsePopup {
                    id: remorseDrop
                }
                width: settingsPage.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }
            Component.onCompleted: {

            }
        }
    }
    onDone: {

    }
}
