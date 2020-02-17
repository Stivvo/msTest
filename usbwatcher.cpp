#include "usbwatcher.h"

USBwatcher::USBwatcher(QObject *parent):QThread(parent)
{
    qDebug("tid=%#x %s", (quintptr)QThread::currentThreadId(), __PRETTY_FUNCTION__);
    start();
}

void USBwatcher::run() {
    //    moveToThread(this); //Let bool event(QEvent *e) be in another thread
    watcher = new QDeviceWatcher;
    //    watcher->moveToThread(this);
    watcher->appendEventReceiver(this);
    connect(watcher, &QDeviceWatcher::deviceAdded, this, [](QString s){
        qDebug() << "\n\n\nadded" << s;}, Qt::DirectConnection);
    connect(watcher, &QDeviceWatcher::deviceChanged, this, [](QString s){
        qDebug() << "\n\n\nchanged" << s;}, Qt::DirectConnection);
    connect(watcher, &QDeviceWatcher::deviceRemoved, this, [](QString s){
        qDebug() << "\n\n\nremoved" << s;}, Qt::DirectConnection);
    watcher->start();
}
