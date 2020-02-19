import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    property var qmlFiles: [
        "start", "touch", "brightness", "off", "usb", "red", "green", "blue", "black", "white", "end"]
    property int current: 0
    visible: true
    width: 800
    height: 600

    Component.onCompleted: {
        backend.setBrightness(7)
    }

    Loader {
        id: loader
        source: (qmlFiles[current] + ".qml")
        anchors.fill: parent
        width: 800
        height: 600
    }

    Connections {
        target: backend
        onMsgReceived: {
            current++
            if (current >= qmlFiles.length)
                Qt.quit()
        }
    }
}
