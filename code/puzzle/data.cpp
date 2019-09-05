#include "data.h"
#include <QDebug>
#include <QtMath>
Data::Data(QObject *parent) : QObject(parent)
{
    m_level = 2;
    m_blockCountInVertical= m_level;
    m_blockCountInHorizontal = m_level;
    m_blockBorderSize = 1;
    m_stage = 0;
    m_stageSteps = 0;
    m_whiteBlockIndex = m_blockCountInVertical*m_blockCountInHorizontal -1 ;
    this->connect(this,SIGNAL(originalImageUrlChanged()),SLOT(onOriginalImageUrlChanged()));
    this->connect(this,SIGNAL(blockWidthChanged()),SLOT(onBlockWidthChanged()));
    this->connect(this,SIGNAL(blockHeightChanged()),SLOT(onBlockHeightChanged()));
    this->connect(this,SIGNAL(levelChanged()),SLOT(onLevelChanged()));
}

void Data::onOriginalImageUrlChanged()
{
    m_originalImage = QImage(originalImageUrl().toLocalFile());
    int imagePaintW = blockWidth()* blockCountInHorizontal();
    int imagePaintH = blockHeight() * blockCountInVertical();
    m_originalImage = m_originalImage.scaled(QSize(imagePaintW,imagePaintH),Qt::KeepAspectRatioByExpanding);
}

void Data::onLevelChanged()
{
    setBlockCountInVertical(m_level);
    setBlockCountInHorizontal(m_level);
    setWhiteBlockIndex(m_blockCountInVertical*m_blockCountInHorizontal -1 );
}


void Data::onBlockWidthChanged()
{

}

void Data::onBlockHeightChanged()
{

}

bool Data::initBlocks()
{

    if(m_originalImageUrl.isEmpty() || m_originalImage.isNull())
        return false;
    m_imageBlockList.clear();
    int index = 0;
    for (int row=0;row<blockCountInVertical();row++) {
        for (int col=0;col<blockCountInHorizontal();col++) {
            BlockImage blockImg;
            blockImg.index = index;
            int x =col*blockWidth(),y=row*blockHeight();
            blockImg.image = m_originalImage.copy(x,y,blockWidth(),blockHeight());
            m_imageBlockList.append(blockImg);
            index++;
        }

    }
    return true;
}

BlockImage Data::getBlockImage(QString index)
{
    int blockImageIndex = index.toInt();
    if(blockImageIndex<0 || blockImageIndex >= m_imageBlockList.size())
        return EMPTY_BLOCKIMAGE;
    return m_imageBlockList.at(blockImageIndex);
}


QImage Data::getOrignalImage()
{
    return m_originalImage;
}

void Data::randomWhiteBlockIndex()
{
    //setWhiteBlockIndex(rand() % (m_blockCountInVertical * m_blockCountInHorizontal));
}

QList<int> Data::getRandomBlockPlace()
{
    int max = m_blockCountInVertical * m_blockCountInHorizontal;
    QList<int> q;
    while(q.count()<max)
    {
        int randPlaceIndex = rand() % max;
        if(q.contains(randPlaceIndex)){
            continue;
        }
        q.append(randPlaceIndex);
    }
    return q;
}

void Data::swapBlockListValue(QList<int> &blockNums,const int emptyRandomIndex)
{
    int blockSize = blockNums.size();
    if(emptyRandomIndex+2>=blockSize)
    {
        blockNums.swapItemsAt(emptyRandomIndex-1,emptyRandomIndex-2);
    }
    else
    {
        blockNums.swapItemsAt(emptyRandomIndex+1,emptyRandomIndex+2);
    }
}

QList<int> Data::getValidRandomBlockPlace()
{
    QList<int> randNums = getRandomBlockPlace();
    const int blockSize = randNums.size();
    int emptyValue = m_whiteBlockIndex;
    int emptyRandomIndex = -1;
    for (int i=0,j=blockSize;i<j;i++)
    {
        if(emptyValue == randNums.at(i))
        {
            emptyRandomIndex = i;
            break;
        }
    }

    int emptyReverseRow = m_blockCountInVertical -  qFloor(emptyRandomIndex / m_blockCountInHorizontal);

    int reverseSize = 0;
    for (int i=0,j=blockSize;i<j-1;i++) {
        if(i==emptyRandomIndex)
            continue;
        int checkNum = randNums.at(i);

        for(int k=i+1;k<j;k++){
            if(k==emptyRandomIndex)
                continue;
            int nextCheckNum = randNums.at(k);

            if(checkNum>nextCheckNum)
            {
                reverseSize++;
            }
        }
    }

    if(blockSize % 2 != 0)//
    {
        if(reverseSize % 2 == 0)
        {
            //            return randNums;
        }
        else
        {
            swapBlockListValue(randNums,emptyRandomIndex);
        }
        return randNums;
    }

    if(emptyReverseRow % 2 == 0)
    {
        if(reverseSize % 2 == 0)
        {
            swapBlockListValue(randNums,emptyRandomIndex);
        }
        else{}
    }
    else
    {
        if(reverseSize % 2 == 0){}
        else
        {
            swapBlockListValue(randNums,emptyRandomIndex);
        }
    }

    return randNums;
}

//QList<int> Data::getValidRandomBlockPlace()
//{
//    QList<int> randNums;
//    while(true)
//    {
//        randNums = getRandomBlockPlace();
//        int emptyIndex = m_whiteBlockIndex;

//        int reverseSize = 0, emptyRandomIndex = -1;
//        for (int i=0,j=randNums.size();i<j;i++)
//        {
//            if(emptyIndex == randNums.at(i))
//            {
//                emptyRandomIndex = i;
//                break;
//            }
//        }
//        //calculate inreverse order number
//        for (int i=0,j=randNums.size();i<j-1;i++) {
//            if(i==emptyRandomIndex)
//                continue;
//            int checkNum = randNums.at(i);

//            for(int k=i+1;k<j;k++){
//                if(k==emptyRandomIndex)
//                    continue;
//                int nextCheckNum = randNums.at(k);

//                if(checkNum>nextCheckNum)
//                {
//                    reverseSize++;
//                }
//            }
//        }

//        int checkRandrp =  reverseSize + (qFloor(emptyRandomIndex / m_blockCountInHorizontal)+ (emptyRandomIndex % m_blockCountInHorizontal));
//        int targetrp = (qFloor(emptyIndex / m_blockCountInHorizontal) + (emptyIndex % m_blockCountInHorizontal));
//        if(checkRandrp % 2 == 0 && targetrp % 2 ==0)
//        {
//            break;
//        }
//        if(checkRandrp % 2 != 0 && targetrp % 2 !=0){
//            break;
//        }

//    }
//    return randNums;
//}
