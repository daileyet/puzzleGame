#include "data.h"
#include <QDebug>
Data::Data(QObject *parent) : QObject(parent)
{
    m_blockCountInVertical= 3;
    m_blockCountInHorizontal = 3;
    m_blockBorderSize = 1;
    m_stage = 0;
    m_stageSteps = 0;
    m_whiteBlockIndex = m_blockCountInVertical * m_blockCountInHorizontal -1;
    this->connect(this,SIGNAL(originalImageUrlChanged()),SLOT(onOriginalImageUrlChanged()));
    this->connect(this,SIGNAL(blockWidthChanged()),SLOT(onBlockWidthChanged()));
    this->connect(this,SIGNAL(blockHeightChanged()),SLOT(onBlockHeightChanged()));

}

void Data::onOriginalImageUrlChanged()
{
    m_originalImage = QImage(originalImageUrl().toLocalFile());
    int imagePaintW = blockWidth()* blockCountInHorizontal();
    int imagePaintH = blockHeight() * blockCountInVertical();
    m_originalImage = m_originalImage.scaled(QSize(imagePaintW,imagePaintH),Qt::KeepAspectRatioByExpanding);
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
