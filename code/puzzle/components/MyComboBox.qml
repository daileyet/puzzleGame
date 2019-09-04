import QtQuick 2.12
import QtQuick.Controls 2.12
ComboBox {
    id: control
    model: ListModel{
        ListElement{display:"Normal";value:3}
        ListElement{display:"Hard";value:4}
    }

    delegate: ItemDelegate {
        width: control.width
        highlighted: control.highlightedIndex === index
        contentItem: Rectangle{
            anchors.fill: parent
            Text {
                anchors.centerIn: parent
                text: control.model.get(index).display

                color: highlighted?"#FFFFFF":"#e8e8e8"
                font: control.font

                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
            color:highlighted?"#333333":"#454545"
        }

    }

    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        Connections {
            target: control
            onPressedChanged: canvas.requestPaint()
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = control.pressed ? "#FFFFFF" : "#FFFFFF";
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: control.indicator.width + control.spacing
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font: control.font
        color: control.pressed ? "#FFFFFF" : "#e8e8e8"
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 40
        border.color: control.pressed ? "#396acc" : "#636363"
        color: control.pressed ?"#333333":"#454545"
        border.width: control.visualFocus ? 2 : 1
        radius: 2
    }
}
