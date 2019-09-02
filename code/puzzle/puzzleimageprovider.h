#ifndef PUZZLEIMAGEPROVIDER_H
#define PUZZLEIMAGEPROVIDER_H
#include <QQuickImageProvider>
#include "data.h"
class PuzzleImageProvider : public QQuickImageProvider
{
public:
    explicit PuzzleImageProvider(Data* data);
    QImage requestImage(const QString& id, QSize *size, const QSize &requestedSize);
signals:

public slots:

private:
    Data* m_data;
};

#endif // PUZZLEIMAGEPROVIDER_H
