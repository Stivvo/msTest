#include "usbwatcher.h"

USBwatcher::USBwatcher(QObject *parent):QThread(parent)
{
    qDebug("tid=%#x %s", (quintptr)QThread::currentThreadId(), __PRETTY_FUNCTION__);
    start();
//        moveToThread(this); //Let bool event(QEvent *e) be in another thread
    watcher = new QDeviceWatcher;
//        watcher->moveToThread(this);
    watcher->appendEventReceiver(this);
    connect(watcher, &QDeviceWatcher::deviceAdded, this, [this](QString s){
        qDebug() << "\n\n\nadded" << s;
        emit(usbAdded());
    }, Qt::DirectConnection);
    connect(watcher, &QDeviceWatcher::deviceChanged, this, [this](QString s){
        qDebug() << "\n\n\nchanged" << s;
        emit(usbChanged());

    }, Qt::DirectConnection);
    connect(watcher, &QDeviceWatcher::deviceRemoved, this, [this](QString s){
        qDebug() << "\n\n\nremoved" << s;
        emit(usbRemoved());
    }, Qt::DirectConnection);
    watcher->start();
}

void USBwatcher::run() {
}
