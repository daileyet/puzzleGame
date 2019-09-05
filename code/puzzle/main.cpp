#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QTranslator>
#include "data.h"
#include "puzzleimageprovider.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QTranslator *translator = new QTranslator;
    translator->load(":/app_zh_CN");
    app.installTranslator(translator);

    qmlRegisterUncreatableType<Data>("com.openthinks.puzzle.data",1,0,"Data","Access DataModel");

    Data* model = new Data;
    PuzzleImageProvider* myImageProvider = new PuzzleImageProvider(model);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("model",model);
    engine.addImageProvider(QLatin1String("puzzle"),myImageProvider);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
