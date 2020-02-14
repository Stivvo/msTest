import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 800
    height: 600

    Loader {
        id: loader
        width: 800
        height: 600
    }

    Connections {
        target: backend
        onMsgReceived: {
            loader.source = "Brightness.qml"
        }
    }

    ListModel {
        id: model
        ListElement {}
        ListElement {}
        ListElement {}
        ListElement {}
        ListElement {}
        ListElement {}
        ListElement {}
        ListElement {}
        ListElement {}
        ListElement {}
        ListElement {}
        ListElement {}
    }

    GridView {
        anchors.fill: parent
        model: model
        cellHeight: parent.height / 3
        cellWidth: parent.width / 4
        interactive: false
        id: grid

        delegate: ColumnLayout {
            height: grid.cellHeight
            width: grid.cellWidth
            Button {
                property bool wasPressed: false
                palette {
                    button: wasPressed ? "white" : "black"
                }
                onClicked: {
                    if (!wasPressed) {
                        if (backend.buttonPressed()) {
                            loader.source = "Brightness.qml"
                        }
                    }
                    wasPressed = true
                }
                text: "click"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: 5
                width: parent.width
                height: parent.height
            }
        }
    }
}
