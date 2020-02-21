import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.VirtualKeyboard 2.1
import QtQuick.Window 2.11

ColumnLayout {
    width: Screen.width
    height: Screen.height

    Rectangle {
        width: parent.width
        height: parent.height
        color: "#F6F6F6"

        Flickable {
            id: flickable
            anchors.fill: parent
            contentWidth: content.width
            contentHeight: content.height
            interactive: contentHeight > height
            flickableDirection: Flickable.VerticalFlick

            TextField {
                width: parent.width
                placeholderText: "One line field"
                onAccepted: {
                    backend.passTest()
                    loader.source = backend.advance()
                }
            }
        }
    }
    InputPanel {
        id: inputPanel
        z: 89
        y: appContainer.height
        Layout.fillHeight: parent.height
        Layout.fillWidth: parent.width
        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: appContainer.height - inputPanel.height
            }
        }
        transitions: Transition {
            id: inputPanelTransition
            from: ""
            to: "visible"
            reversible: true
            enabled: !VirtualKeyboardSettings.fullScreenMode
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
        Binding {
            target: InputContext
            property: "animating"
            value: inputPanelTransition.running

        }
    }

    Binding {
        target: VirtualKeyboardSettings
        value: appContainer.height > 0 && (appContainer.width / appContainer.height) > (16.0 / 9.0)
    }
}
