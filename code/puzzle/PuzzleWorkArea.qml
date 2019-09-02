import QtQuick 2.4

PuzzleWorkAreaUI {
    property bool isStarted:false;
    property int whiteBlockIndex: whiteBlockIndex;
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
        randomBlockPlace();
        renderPuzzle();
        root.focus=true;
    }

    function renderPuzzle(){
        if(!isStarted || !model.initBlocks())
            return;
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
    }

    function cleanPuzzle(){
        var blockCount = blocks.count;
        var imageUrl ="";
        for(var i=0;i<blockCount;i++){
            var blockItem = blocks.itemAt(i);
            blockItem.blockImageUrl = imageUrl;
        }
    }

    function showOrignalPuzzle(){

        orignalImage.source = "image://puzzle/"+model.stage+"/-1";
        orignalImage.visible = true;
        orignalImage.z = 99;
    }

    function hideOrignalPuzzle(){

        orignalImage.visible = false;
    }

    function randomBlockPlace(){
        var randomPlaces = model.getRandomBlockPlace();
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


    Component.onCompleted: {
        model.blockWidth = root.blockW;
        model.blockHeight = root.blockH;
    }
}
