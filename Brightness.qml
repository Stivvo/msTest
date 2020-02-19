import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls 2.5

ColumnLayout {
    anchors.fill: parent

    Text {
        text: qsTr("brightness test")
        Layout.alignment: Qt.AlignCenter
        Layout.bottomMargin: -20
        Layout.topMargin: 10
    }

    Slider {
        Layout.alignment: Qt.AlignCenter
        Layout.bottomMargin: -(parent.height / 3)
        from: 1
        value: 7
        to: 7
        onValueChanged: {
            backend.setBrightness(this.value)
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignCenter
        spacing: 2
        Button {
            Layout.alignment: Qt.AlignTop
            text: "working"
            onClicked: {
                loader.source = "off.qml"
                backend.passTest()
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: this.down ? "#17a81a" : "#21be2b"
                border.width: 1
                radius: 2
            }
        }

        Button {
            Layout.alignment: Qt.AlignTop
            text: "NOT working"
            onClicked: {
                loader.source = "off.qml"
                backend.failTest()
            }
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
