#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "mainviewmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    MainViewModel mainVm;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("mainVM", &mainVm);

    const QUrl url(u"qrc:/qt/qml/Merge_Large_Image/Resources/Main.qml"_qs);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
