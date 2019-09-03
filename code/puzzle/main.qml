import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id:root;
    visible: true
    width: 640
    height: 480

    color: "#535353";

    PuzzleCtrlArea{
        id:puzzleCrtlArea;
        height: 47
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }

    PuzzleWorkArea{
        id:puzzleWorkArea
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: puzzleCrtlArea.bottom
        anchors.topMargin: 0
    }


    Connections{
        target: puzzleCrtlArea
        onStartPuzzle:{
            puzzleWorkArea.hideOrignalPuzzle(true);
            puzzleWorkArea.startGame();
        }
        onPuzzleReloaded:{
            puzzleWorkArea.isStarted=false;
            puzzleWorkArea.cleanPuzzle();
            puzzleWorkArea.showOrignalPuzzle(true);
        }
        onPuzzleModelChanged:{
            if(puzzleMode==1)
                puzzleWorkArea.showOrignalPuzzle();
            else
                puzzleWorkArea.hideOrignalPuzzle();
        }
        onPuzzleLevelChanged:{
            puzzleWorkArea.hideOrignalPuzzle(true);
            puzzleWorkArea.startGame();
        }
    }


    onWidthChanged: {
        puzzleWorkArea.renderPuzzle();
    }

    onHeightChanged: {
        puzzleWorkArea.renderPuzzle();
    }

    onWindowStateChanged: {
        puzzleWorkArea.renderPuzzle();
    }


}





































/*##^## Designer {
    D{i:1;anchors_width:200}D{i:2;anchors_width:630}
}
 ##^##*/
