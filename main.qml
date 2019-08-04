/* TextConnect
   Copyright (C) 2019  Eric S. Londres

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import Process 1.0

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("TextConnect")

    TextField {
        id: phoneNumberInput
        width: parent.width
        placeholderText: "Phone Number"
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
    }

    TextArea {
        id: messageBodyInput
        placeholderText: "Message body"
        font.pointSize: 12
        anchors.bottomMargin: 40
        anchors.top: phoneNumberInput.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
    }

    Button {
        id: sendButton
        text: qsTr("Send")

        Process {
            id: process
            onReadyRead: {
                console.log(readAll());
            }
        }

        onClicked: {
            const dst = phoneNumberInput.text;
            const msg = `'${messageBodyInput.text}'`;
            process.start("sh", [
                "-c", `kdeconnect-cli -d $(qdbus org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices) --send-sms ${msg} --destination ${dst}`
            ]);
        }

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: messageBodyInput.bottom
        anchors.topMargin: 5
    }
}











/*##^## Designer {
  D{i:3;anchors_height:20;anchors_width:80}D{i:1;anchors_height:400;anchors_width:200}
  }
  ##^##*/
