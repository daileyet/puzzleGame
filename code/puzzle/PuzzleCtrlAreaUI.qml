import QtQuick 2.4
import QtQuick.Controls 2.5
import Qt.labs.platform 1.1

Item {
    id: topArea
    height: 47
    property alias comboBoxLevel: comboBoxLevel
    property alias btnPreview: btnPreview
    property alias txtStepText: txtStep.text
    property alias btnStart: btnStart
    property alias btnLoad: btnLoad
    property alias puzzlePictureFileDialog: puzzlePictureFileDialog
    width: 640
    anchors.top: parent.top
    anchors.topMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0
    anchors.left: parent.left
    anchors.leftMargin: 0

    Button {
        id: btnLoad
        width: 60
        height: 25
        text: qsTr("Load")
        visible: true
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        id: btnPreview
        width: 70
        height: 25
        text: qsTr("Preview")
        visible: true
        anchors.left: btnLoad.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        id: btnStart
        width: 60
        height: 25
        text: qsTr("Start")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: btnPreview.right
        anchors.leftMargin: 5
    }

    ComboBox {
        id: comboBoxLevel
        y: 14
        width: 100
        height: 25
        font.pointSize: 13
        wheelEnabled: false
        flat: false
        anchors.left: btnStart.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: txtStep
        width: 15
        height: 20
        color: "#ffffff"
        anchors.verticalCenter: parent.verticalCenter
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.pixelSize: 12
    }

    FileDialog{
        id:puzzlePictureFileDialog
        nameFilters: ["Image files (*.png *.jpg *.bmp *.gif)"]
    }


}

























/*##^## Designer {
    D{i:4;anchors_x:227}
}
 ##^##*/
