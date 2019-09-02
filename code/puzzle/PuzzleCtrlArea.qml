import QtQuick 2.4
import Qt.labs.platform 1.1

PuzzleCtrlAreaUI {
    signal startPuzzle();
    signal puzzleReloaded();
    signal puzzleModelChanged(int puzzleMode);
    implicitHeight: 50;
    implicitWidth: 400;

    txtStepText: model.stageSteps;
    comboBoxLevel.model: ListModel{
        ListElement{display:"Normal";value:3}
        ListElement{display:"Hard";value:4}
    }
    comboBoxLevel.textRole: "display";

    Connections{
        target: btnLoad
        onClicked:{
            puzzlePictureFileDialog.open();
        }
    }

    Connections{
        target: btnPreview
        onPressed:{
            puzzleModelChanged(1);
        }
        onReleased:{
            puzzleModelChanged(0);
        }

    }

    Connections{
        target: btnStart
        onClicked:{
            model.stageSteps = 0;
            startPuzzle();
        }
    }

    Connections{
        target: comboBoxLevel
    }

    Connections{
        target: puzzlePictureFileDialog
        onAccepted:{
            model.originalImageUrl = puzzlePictureFileDialog.file;
            model.stageSteps = 0;
            model.stage = model.stage + 1;
            puzzleReloaded();
        }
    }
}
