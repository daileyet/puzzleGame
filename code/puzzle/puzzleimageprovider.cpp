#include "puzzleimageprovider.h"

PuzzleImageProvider::PuzzleImageProvider(Data* data) : QQuickImageProvider(QQuickImageProvider::Image)
{
    this->m_data = data;
}


QImage PuzzleImageProvider::requestImage(const QString& id, QSize *size, const QSize &requestedSize)
{
    QStringList qslist = id.split("/");
    QString blockImageIndex = qslist.last();
    if(blockImageIndex=="-1"){
        return m_data->getOrignalImage();
    }
    BlockImage blockImg = m_data->getBlockImage(blockImageIndex);
    return blockImg.image;
}
