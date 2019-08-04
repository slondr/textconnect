import QtQuick 2.13
import QtQuick.Window 2.13

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    color: "#272822"
    title: qsTr("Hello World")

    Column {
        id: column
        anchors.fill: parent

        TextInput {
            id: numberInput
            width: column.width
            height: 20
            color: "#ffffff"
            text: qsTr("Text Input")
            antialiasing: true
            anchors.horizontalCenter: parent.horizontalCenter
            selectionColor: "#800000"
            horizontalAlignment: Text.AlignLeft
            renderType: Text.QtRendering
            font.pixelSize: 12
        }

        TextInput {
            id: bodyInput
            width: column.width
            color: "#ffffff"
            text: qsTr("Text Input")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            anchors.top: numberInput.bottom
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }
    }
}

/*##^## Designer {
    D{i:3;anchors_height:20;anchors_width:80}D{i:1;anchors_height:400;anchors_width:200}
}
 ##^##*/
