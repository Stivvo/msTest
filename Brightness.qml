import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.5

Window {
    id: main3
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
            backend.brightnessTest(true)
            loader.source = "End.qml"
            //                        main.visible = false
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Text {
            text: qsTr("brightness")
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: -20
            Layout.topMargin: 10
        }

        Slider {
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: -(parent.height / 3)
            from: 0
            value: 7
            to: 7
            onValueChanged: {
                backend.setBrightness(this.value)
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            spacing: 2
            Button {
                Layout.alignment: Qt.AlignTop
                text: "working"
                onClicked: {
                    backend.brightnessTest(true)
                    main.visible = false
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
                    backend.brightnessTest(false)
                    main.visible = false
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
