import QtQuick 2.4
import "components"
Item {
    id: root
    width: 500
    height: 600
    property alias orignalImage: orignalImage
    property alias blocks: blocks
    property alias winInfo:winInfo
    implicitWidth: 500
    implicitHeight: 600
    property int blockCountInHorizontal: 3
    property int blockCountInVertical: 3
    property double blockW: root.width / blockCountInHorizontal
    property double blockH: root.height / blockCountInVertical
    property int blockBorder: 2

    Image {
        id: orignalImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        visible: false

    }
    Rectangle{
        color: "#00000000"
        anchors.rightMargin: (-1*blockBorder)
        anchors.leftMargin: (-1*blockBorder)
        anchors.bottomMargin: (-1*blockBorder)
        anchors.topMargin: (-1*blockBorder)
        anchors.fill: parent
        border.width: blockBorder;
        border.color: "#FFFFFF"
    }    

    Repeater {
        id: blocks
        signal blockClicked(int placedIndex);
        model: blockCountInHorizontal * blockCountInVertical
        Rectangle {
            property url blockImageUrl:"";
            property int blockIndex: index;
            property int blockPlacedIndex: index;
            property bool blockImageVisible: true;
            property bool isCorrect: (blockIndex == blockPlacedIndex);
            color: "#00000000"
            width: blockW
            height: blockH
            x: (blockPlacedIndex % blockCountInVertical) * blockW
            y: Math.floor((blockPlacedIndex / blockCountInHorizontal)) * blockH
            z:orignalImage.z+1;
            border.color: "#FFFFFF"
            border.width: blockBorder
            Image {
                anchors.rightMargin: blockBorder
                anchors.leftMargin: blockBorder
                anchors.bottomMargin: blockBorder
                anchors.topMargin: blockBorder
                anchors.fill: parent
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                fillMode: Image.Stretch
                source: blockImageUrl
                visible: blockImageVisible
            }
            MouseArea{
                id:blockMouseArea;
                anchors.fill: parent;
                enabled: true;
                onClicked: blocks.blockClicked(blockPlacedIndex);
            }

        }
    }

    WinInfo{
        id:winInfo
//        width: Math.max(root.height,root.width) * 0.75
//        height: Math.min(root.height,root.width) * 0.5
//        anchors.centerIn: parent
        anchors.fill: parent
        z:orignalImage.z+2;
        visible: false;
    }

}


