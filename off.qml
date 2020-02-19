import QtQuick 2.12

Rectangle {
    anchors.fill: parent

    Component.onCompleted: {
        backend.setBrightness(3)
    }
    Component.onDestruction: {
        backend.setBrightness(7)
    }
}
