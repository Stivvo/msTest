import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Window 2.11

ApplicationWindow {
    visible: true
    width: Screen.width
    height: Screen.height

    Component.onCompleted: {
        backend.setBrightness(7)
    }

    ColumnLayout {
        anchors.fill: parent

        Loader {
            id: loader
            Layout.alignment: Qt.AlignCenter
            source: backend.advance()
        }

        Connections {
            target: backend
            onMsgReceived: {
                loader.source = backend.advance()
                if (backend.finished())
                    Qt.quit()
            }
        }

        RowLayout {
            Layout.bottomMargin: 30
            Layout.alignment: Qt.AlignCenter
            spacing: 2
            Button {
                Layout.alignment: Qt.AlignTop
                text: "working"
                onClicked: {
                    backend.passTest()
                    loader.source = backend.advance()
                    if (backend.finished())
                        Qt.quit()
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
                    backend.failTest()
                    loader.source = backend.advance()
                    if (backend.finished())
                        Qt.quit()
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
}
