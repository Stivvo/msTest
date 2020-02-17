import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5

Window {
    visible: true
    width: 800
    height: 600

    Loader {
        id: loader
        width: 800
        height: 600
        anchors.fill: parent
    }

    Connections {
        target: backend
        onMsgReceived: {
            loader.source = "End.qml"
        }
    }

    Connections {
        target: watcher
        onUsbWatcherAdded: {
            usbState.text = "usb added"
            backend.send("usb added")
            backend.writeLog("qml usb add")
        }
        onUsbWatcherChanged: {
            usbState.text = "usb changed"
            backend.send("usb changed")
            backend.writeLog("qml usb change")
        }
        onUsbWatcherRemoved: {
            usbState.text = "usb removed"
            backend.send("usb removed")
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Text {
            text: qsTr("state")
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: -20
            Layout.topMargin: 10
        }

        Text {
            id: usbState
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: -(parent.height / 3)

        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            spacing: 2
            Button {
                Layout.alignment: Qt.AlignTop
                text: "working"
                onClicked: {
                    loader.source = "End.qml"
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
                    loader.source = "End.qml"
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
