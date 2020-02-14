import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

Window {
    id: main
    visible: true
    width: 800
    height: 600

    Loader {
        id: loader
        width: 800
        height: 600
    }

    Connections {
        target: backend
        onMsgReceived: {
            backend.writeLog()
            loader.source = "Touch.qml"
        }
    }

    ColumnLayout {
        spacing: 2
        anchors.fill: parent

        Text {
            text: qsTr("MS Test v 0.1 - welcome")
            width: 400
            height: 200
            Layout.alignment: Qt.AlignCenter
            id: textWelcome
        }

        Button {
            text: "start test"
            id: startButton
            onClicked: {
                console.log("button pressed")
                backend.writeLog()
                main.visible = false
                loader.source = "Touch.qml"
            }
            Layout.alignment: Qt.AlignCenter
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: this.down ? "#17a81a" : "#21be2b"
                border.width: 1
                radius: 2
            }
        }
    }
}
