import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.5

ColumnLayout {
    anchors.fill: parent

    Connections {
        target: watcher
        onUsbWatcherAdded: {
            usbState.text = "usb added"
            backend.send("usb added")
        }
        onUsbWatcherChanged: {
            usbState.text = "usb changed"
            backend.send("usb changed")
        }
        onUsbWatcherRemoved: {
            usbState.text = "usb removed"
            backend.send("usb removed")
        }
    }

    Text {
        text: qsTr("usb test")
        Layout.alignment: Qt.AlignCenter
        Layout.bottomMargin: -20
        Layout.topMargin: 10
    }

    Text {
        id: usbState
        Layout.alignment: Qt.AlignCenter
        Layout.bottomMargin: -(parent.height / 3)

    }
}
