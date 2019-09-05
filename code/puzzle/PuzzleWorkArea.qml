import QtQuick 2.4

PuzzleWorkAreaUI {
    property bool isStarted:false;
    property int whiteBlockIndex: model.whiteBlockIndex;
    property int blockMaxCount: blockCountInVertical*blockCountInHorizontal;

    id:root;
    blockCountInVertical:model.blockCountInVertical;
    blockCountInHorizontal: model.blockCountInHorizontal;
    blockBorder:model.blockBorderSize;
    Keys.enabled: true;
    Keys.onUpPressed : moveUp();
    Keys.onDownPressed : moveDown();
    Keys.onLeftPressed : moveLeft();
    Keys.onRightPressed : moveRight();
    focus: true;


    Binding{
        target: model
        property: "blockWidth"
        value:root.blockW
    }

    Binding{
        target: model
        property: "blockHeight"
        value:root.blockH
    }

    Connections{
        target: blocks;
        onBlockClicked:blockClickedProcess(placedIndex);

    }


    function startGame(){
        isStarted=true;
        hideWinInfo();
        renderPuzzle(true);

    }

    function renderPuzzle(notIgnoreRandom){
        var isNotIgnoreRandom = notIgnoreRandom || false;
        if(!isStarted || !model.initBlocks())
            return;
        if(isNotIgnoreRandom)randomBlockPlace();
        var blockCount = blocks.count;
        var imageUrl ="";
        for(var i=0;i<blockCount;i++){
            var blockItem = blocks.itemAt(i);
            var blockIndex = blockItem.blockIndex;
            if(blockIndex===whiteBlockIndex){
                imageUrl =""
            }else{
                imageUrl ="image://puzzle/"+model.stage+"/"+blockIndex;
            }
            blockItem.blockImageUrl = imageUrl;
        }
        root.focus=true;
    }

    function cleanPuzzle(){
        var blockCount = blocks.count;
        var imageUrl ="";
        for(var i=0;i<blockCount;i++){
            var blockItem = blocks.itemAt(i);
            blockItem.blockImageUrl = imageUrl;
        }
    }

    function showOrignalPuzzle(ignoreStared){
        var isIgnoreStared = ignoreStared || false;
        if(isIgnoreStared===false && !isStarted)
            return;
        orignalImage.source = "image://puzzle/"+model.stage+"/-1";
        orignalImage.visible = true;
        orignalImage.z = 99;
        for(var i=0;i<blocks.count;i++){
            var blockItem = blocks.itemAt(i);
            blockItem.blockImageVisible=false;
        }
    }

    function hideOrignalPuzzle(ignoreStared){
        var isIgnoreStared = ignoreStared || false;
        if(isIgnoreStared===false && !isStarted)
            return;
        orignalImage.visible = false;
        for(var i=0;i<blocks.count;i++){
            var blockItem = blocks.itemAt(i);
            blockItem.blockImageVisible=true;
        }
        root.focus=true;
    }

    function randomBlockPlace(){
        model.randomWhiteBlockIndex();
        var randomPlaces = model.getValidRandomBlockPlace();
        console.log(randomPlaces,model.whiteBlockIndex)
        for(var i in randomPlaces){
            var blockItem = blocks.itemAt(i);
            blockItem.blockPlacedIndex = randomPlaces[i];
        }
    }




    function getWhiteBlockItem(){
        for(var i=0;i<blocks.count;i++){
            var blockItem = blocks.itemAt(i);
            if(blockItem.blockIndex===whiteBlockIndex){
                return blockItem;
            }
        }
    }

    function getBlockItemByPlacedIndex(placedIndex){
        for(var i=0;i<blocks.count;i++){
            var blockItem = blocks.itemAt(i);
            if(blockItem.blockPlacedIndex===placedIndex)
                return blockItem;
        }
        return null;
    }

    function swapBlockItem(item1,item2){
        var tmpPlacedIndex = item1.blockPlacedIndex;
        item1.blockPlacedIndex = item2.blockPlacedIndex;
        item2.blockPlacedIndex = tmpPlacedIndex;
        model.stageSteps = model.stageSteps + 1;
        root.focus=true;
        if(item1.isCorrect && item2.isCorrect){
            checkCompleted();
        }
    }

    function moveUp(){
        if(!isStarted)return;
        var whiteBlockItem = getWhiteBlockItem();
        var needMoveItemPlacedIndex =  whiteBlockItem.blockPlacedIndex + blockCountInHorizontal;
        if(needMoveItemPlacedIndex > blockMaxCount -1)
            return;
        var needMoveBlockItem = getBlockItemByPlacedIndex(needMoveItemPlacedIndex);
        swapBlockItem(whiteBlockItem,needMoveBlockItem);
    }

    function moveDown(){
        if(!isStarted)return;
        var whiteBlockItem = getWhiteBlockItem();
        var needMoveItemPlacedIndex =  whiteBlockItem.blockPlacedIndex - blockCountInHorizontal;
        if(needMoveItemPlacedIndex <  0)
            return;
        var needMoveBlockItem = getBlockItemByPlacedIndex(needMoveItemPlacedIndex);
        swapBlockItem(whiteBlockItem,needMoveBlockItem);
    }

    function moveLeft(){
        if(!isStarted)return;
        var whiteBlockItem = getWhiteBlockItem();
        var needMoveItemPlacedIndex =  whiteBlockItem.blockPlacedIndex + 1;
        if(Math.floor(needMoveItemPlacedIndex / blockCountInHorizontal) != Math.floor(whiteBlockItem.blockPlacedIndex / blockCountInHorizontal))
            return;
        var needMoveBlockItem = getBlockItemByPlacedIndex(needMoveItemPlacedIndex);
        swapBlockItem(whiteBlockItem,needMoveBlockItem);
    }

    function moveRight(){
        if(!isStarted)return;
        var whiteBlockItem = getWhiteBlockItem();
        var needMoveItemPlacedIndex =  whiteBlockItem.blockPlacedIndex - 1;
        if(Math.floor(needMoveItemPlacedIndex / blockCountInHorizontal) != Math.floor(whiteBlockItem.blockPlacedIndex / blockCountInHorizontal))
            return;
        var needMoveBlockItem = getBlockItemByPlacedIndex(needMoveItemPlacedIndex);
        swapBlockItem(whiteBlockItem,needMoveBlockItem);
    }

    function blockClickedProcess(placedIndex){
        if(!isStarted)return;
        var whiteBlockItem = getWhiteBlockItem();
        var whiteBlockItemPlacedIndex = whiteBlockItem.blockPlacedIndex;
        if(whiteBlockItemPlacedIndex + 1 === placedIndex){
            moveLeft();
        }else if(whiteBlockItemPlacedIndex - 1 === placedIndex){
            moveRight();
        }else if(whiteBlockItemPlacedIndex + blockCountInHorizontal === placedIndex){
            moveUp();
        }else if(whiteBlockItemPlacedIndex - blockCountInHorizontal === placedIndex){
            moveDown();
        }
    }

    function showWinInfo(){
        winInfo.visible=true;
        winInfo.reStart();
    }

    function hideWinInfo(){
        winInfo.visible=false;
    }


    function checkCompleted(){
        var blockItem;
        for(var i=0;i<blocks.count;i++){
            blockItem = blocks.itemAt(i);
            if(!blockItem.isCorrect)
                return false;
        }
        showWinInfo();
        return true;
    }

    function cheat(){
        var blockItem;
        for(var i=0;i<blocks.count;i++){
            blockItem = blocks.itemAt(i);
            blockItem.blockPlacedIndex = blockItem.blockIndex;
        }
    }

    Component.onCompleted: {
        model.blockWidth = root.blockW;
        model.blockHeight = root.blockH;
    }

}
