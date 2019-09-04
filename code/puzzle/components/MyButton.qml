import QtQuick 2.0
import QtQuick.Controls 2.0

Button {
    id: control
    text: qsTr("Button")

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "#FFFFFF" : "#e8e8e8"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        border.color: control.down ? "#396acc" : "#636363"
        color: control.down?"#333333":"#454545"
        border.width: 1
        radius: 2
    }
}
