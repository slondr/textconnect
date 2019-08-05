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
import QtQuick.Controls.Material 2.12
import Process 1.0 // Defined in "process.h"

ApplicationWindow {
    id: mainWindow
    visible: true
    Material.theme: Material.Dark
    Material.accent: Material.Purple
    width: 640  // width and height here are initial values,
    height: 480 // everything is set up to autoscale to smaller or larger values
    title: qsTr("TextConnect")

    /** phoneNumberInput
     * Component to get the destination phone number from the user.
     */
    TextField {
        id: phoneNumberInput
        width: parent.width
        placeholderText: "Phone Number"
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
    }

    /** messageBodyInput
     * Component to get the message to send from the user.
     */
    TextArea {
        id: messageBodyInput
        placeholderText: "Message body"
        font.pointSize: 12
        anchors.bottomMargin: 40 // To make room for the send button
        anchors.top: phoneNumberInput.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
    }

    /** sendButton
     * Contains all logic related to sending the message, and presents the user
     * with a single button to click to perform the sending action.
     */
    Button {
        id: sendButton
        text: qsTr("Send")

	/** process
	 * Implements the component defined in "process.h". Abstracts QProcess
	 * to allow for arbitrary command execution, and prints all output
	 * (stdout and stderr) to the program's stdout.
	 */
        Process {
            id: process
            onReadyRead: {
                console.log(readAll());
            }
        }

        onClicked: {
            const dst = phoneNumberInput.text; // destination phone number
	    
	    /* Adds single-quotes around message body to avoid parsing the string
	       and account for spaces.
	    */
            var msg = '';
            messageBodyInput.text.split('').forEach(function(val) {
                msg += "\\" + val;
            });

            console.log(msg);

	    
	    /* The arguments to process.start() are hardcoded right now because
	     * it's the easiest way to do it and also relatively stable.
	     * However, this method does introduce some issues when the message
	     * contains a single-quote or certain other characters that end up
	     * getting parsed by the shell. Also, is isn't particularly future-
	     * proof, and only functions correctly when only a single device
	     * is paired to the user's machine.
	     */
            process.start("sh", [
                "-c", `kdeconnect-cli -d $(qdbus org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices) --send-sms ${msg} --destination ${dst}`
            ]);
        }

	// layout
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
