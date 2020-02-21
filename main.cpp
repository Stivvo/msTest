#include "backend.h"
#include "usbwatcher.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    BackEnd backEnd(nullptr);
    backEnd.setIp(argv[1]);
    engine.rootContext()->setContextProperty("backend", &backEnd);

    USBwatcher watcher(nullptr);
    engine.rootContext()->setContextProperty("watcher", &watcher);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine,
                     &QQmlApplicationEngine::objectCreated,
                     &app,
                     [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     },
                     Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
