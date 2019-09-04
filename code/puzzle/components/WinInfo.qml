import QtQuick 2.0

MouseArea {
    //property alias rotationAnimation: rotationAnimation
    id:root;
    implicitWidth: 400;
    implicitHeight: 200;

    Rectangle{
        anchors.fill: parent
        color: "#454545"
        opacity: 0.75
    }

    PropertyAnimation{
        id:rotationAnimation
        target: outer;
        property: "rotation"
        to:350;
        duration: 1000;
    }

    Rectangle{
        id: outer
        width: (Math.max(root.width,root.height) * 0.6)
        height: (Math.min(root.width,root.height) * 0.4)
        color: "#00000000"
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        rotation: 0

        border.color: "#f94f4f"
        border.width: 15


        Text {
            id: element
            color: "#f94f4f"
            text: qsTr("Done")
            anchors.fill: parent
            fontSizeMode: Text.Fit
            style: Text.Sunken
            font.weight: Font.ExtraBold
            font.capitalization: Font.AllUppercase
            font.pointSize: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

    }


    function reStart(){
        outer.rotation = 0;
        rotationAnimation.restart()
    }

}











