/*
 The MIT License (MIT)

 Copyright (c) 2015 Sebastian Weiler

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
/*
Version:   0.1
Date:      18.08.2015
*/
import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "DBModule.js" as DBModule

Dialog {
    id: weightPage
    SilicaFlickable {
        anchors.fill: parent
        Column {
            id: column
            width: weightPage.width
            spacing: Theme.paddingSmall
            DialogHeader {
                acceptText: qsTr("save")
                cancelText: qsTr("cancel")
            }
            TextField {
                placeholderText: "Please enter your weight"
                label: "weight"
                id: weight
                width: weightPage.width
                focus: true
                anchors {
                           left: parent.left
                           right: parent.right
                           margins: Theme.paddingLarge
                       }
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }
        }
    }
    onDone: {
        if (result === DialogResult.Accepted) {
            DBModule.DBModule.saveWeight(new Date(),weight.text)
            console.log("saved")
        }
    }
}
