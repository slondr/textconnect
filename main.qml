import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    // color: "#272822"
    title: qsTr("Hello World")

    Column {
        id: column
        anchors.fill: parent

        TextField {
            id: phoneNumberInput
            width: column.width
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
            flat: false
            onClicked: console.log(JSON.stringify({ number: phoneNumberInput.text, body: messageBodyInput.text }))
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: messageBodyInput.bottom
            anchors.topMargin: 5
        }
    }
}











/*##^## Designer {
    D{i:3;anchors_height:20;anchors_width:80}D{i:1;anchors_height:400;anchors_width:200}
}
 ##^##*/
