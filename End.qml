import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.5

Window {
    visible: true
    width: 800
    height: 600

    Connections {
        target: backend
        onMsgReceived: {
            backend.endTest()
            Qt.quit()
            // system("dd if=/dev/zero of=/dev/fb0")
        }
    }

    ColumnLayout {
        spacing: 2
        anchors.fill: parent

        Text {
            text: qsTr("the board is working")
            Layout.alignment: Qt.AlignCenter
        }

        Button {
            text: "end test"
            id: startButton
            onClicked: {
                backend.endTest()
                Qt.quit()
                //                system("dd if=/dev/zero of=/dev/fb0")
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
