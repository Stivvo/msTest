import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls 2.5

Window {
    visible: true
    width: 800
    height: 600

    Component.onCompleted: {
        backend.setBrightness(0);
    }

    Loader {
        id: loader
        width: 800
        height: 600
    }

    Connections {
        target: backend
        onMsgReceived: {
            loader.source = "usb.qml"
            backend.setBrightness(7);
        }
    }
}
