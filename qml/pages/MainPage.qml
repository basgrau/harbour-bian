/*
    harbour-bian
    Copyright (C) 2015  Sebastian Weiler

    See LICENSE.
 */
/*
Version:   0.1
Date:      17.08.2015
*/
import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    property int fontLargeSize: Theme.fontSizeLarge
    property int fontSmallSize: Theme.fontSizeSmall
    property string activeText: Theme.highlightColor

    SilicaFlickable {
        id: mainFlick
        anchors {
            fill: parent
            //margins: Theme.paddingLarge
        }

        contentHeight: column.height

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        VerticalScrollDecorator{
            flickable: mainFlick
        }

        Column {
            id: column
            width: parent.width
            //spacing: Theme.paddingLarge
            //anchors.margins: Theme.paddingLarge
            PageHeader {
                title: qsTr("Current Status")
            }
            Row {
                width: parent.width
                height: parent.width/2
                CanvasElement {
                    canvasType: 1
                    width: parent.width/2
                    height: parent.width
                }
                CanvasElement {
                    canvasType: 2
                    width:  (parent.width / 2)
                    height: parent.width
                }
            }
            Row {
                width: parent.width
                Label {
                    color: Theme.highlightColor
                    text: "Glucose"
                }
            }
            //Chart for glucose level
            Row {
                id: rowF
                width: parent.width
                height: parent.width
                anchors{
                    horizontalCenter: parent.horizontalCenter
                }
                ChartElement {
                    canvasType: 1
                }
            }
            Row {
                width: parent.width
                Label {
                    id: lbl
                    color: Theme.highlightColor
                    text: "Weight"
                }
            }
            //Chart for weight
            Row {
                width: parent.width
                height: parent.width
                anchors{
                    horizontalCenter: parent.horizontalCenter
                }
                ChartElement {
                    canvasType: 2
                }
            }
        }
    }
}
