import QtQuick 2.12

Rectangle {
    anchors.fill: parent

    Component.onCompleted: {
        backend.setBrightness(0)
    }
    Component.onDestruction: {
        backend.setBrightness(7)
    }
}
