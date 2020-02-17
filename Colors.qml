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
            switch (backend.changeColor()) {
            case 1:
                rect.color = "green"
                break;
            case 2:
                rect.color = "blue";
                break;
            case 3:
                rect.color = "black";
                break;
            case 4:
                rect.color = "white";
                break;
            case 5:
                loader.source = "End.qml"
                break;
            }
        }
    }

   Rectangle{
        id: rect
        color: "red"
        width: parent.width
        height: parent.height
        anchors.fill: parent
   }
}
