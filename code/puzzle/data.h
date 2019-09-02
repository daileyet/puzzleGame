#ifndef DATA_H
#define DATA_H
#include <QObject>
#include <QUrl>
#include <QImage>
#include <QList>
#include "define.h"
struct BlockImage
{
    QImage image;
    int index;
};


class Data : public QObject
{
    Q_OBJECT
    DECLARE_PROPERTY(QUrl,originalImageUrl,OriginalImageUrl)
    DECLARE_PROPERTY(int,blockCountInHorizontal,BlockCountInHorizontal)
    DECLARE_PROPERTY(int,blockCountInVertical,BlockCountInVertical)
    DECLARE_PROPERTY(int,blockBorderSize,BlockBorderSize)
    DECLARE_PROPERTY(int,blockWidth,BlockWidth)
    DECLARE_PROPERTY(int,blockHeight,BlockHeight)
    DECLARE_PROPERTY(int,whiteBlockIndex,WhiteBlockIndex)
    DECLARE_PROPERTY(int,stage,Stage)
    DECLARE_PROPERTY(int,stageSteps,StageSteps)
public:
    explicit Data(QObject *parent = nullptr);
    BlockImage getBlockImage(QString index);
    Q_INVOKABLE bool initBlocks();
    QImage getOrignalImage();

    Q_INVOKABLE QList<int> getRandomBlockPlace();

signals:
    void originalImageUrlChanged();
    void blockCountInHorizontalChanged();
    void blockCountInVerticalChanged();
    void blockBorderSizeChanged();
    void blockWidthChanged();
    void blockHeightChanged();
    void whiteBlockIndexChanged();
    void stageStepsChanged();
    void stageChanged();
public slots:
    void onOriginalImageUrlChanged();
    void onBlockWidthChanged();
    void onBlockHeightChanged();

private:



private:
    QImage m_originalImage;
    QVector<BlockImage> m_imageBlockList;
    BlockImage EMPTY_BLOCKIMAGE;
};

#endif // DATA_H
