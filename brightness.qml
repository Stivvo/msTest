import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5

ColumnLayout {
    Text {
        text: qsTr("brightness test")
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: 40
    }

    Slider {
        Layout.alignment: Qt.AlignHCenter
        from: 1
        value: 7
        to: 7
        onValueChanged: {
            backend.setBrightness(this.value)
        }
        Layout.bottomMargin: -40
    }
}
