import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.11

Rectangle {
    width: Screen.width
    height: Screen.height

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
        anchors.centerIn: parent
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
                        backend.send("button pressed");
                        if (backend.buttonPressed()) {
                            loader.source = "brightness.qml"
                        }
                    }
                    wasPressed = true
                }
                text: "tap"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: 15
                width: parent.width
                height: parent.height
            }
        }
    }
}
