import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5

ColumnLayout {
    spacing: 2
    anchors.fill: parent

    Text {
        text: qsTr("MS Test v 0.1 - welcome")
        width: 400
        height: 200
        Layout.alignment: Qt.AlignCenter
    }

    Button {
        text: "start test"
        id: startButton
        onClicked: {
            loader.source = "Touch.qml"
            backend.passTest()
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
