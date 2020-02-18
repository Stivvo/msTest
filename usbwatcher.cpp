#include "usbwatcher.h"

USBwatcher::USBwatcher(QObject *parent):QThread(parent)
{
    qDebug("tid=%#x %s", (quintptr)QThread::currentThreadId(), __PRETTY_FUNCTION__);
    start();
//        moveToThread(this); //Let bool event(QEvent *e) be in another thread
    watcher = new QDeviceWatcher;
//        watcher->moveToThread(this);
    watcher->appendEventReceiver(this);

    QRegExp pattern("[0-9]", Qt::CaseSensitivity::CaseInsensitive, QRegExp::PatternSyntax::RegExp);

    connect(watcher, &QDeviceWatcher::deviceAdded, this, [pattern, this](QString s){
        qDebug() << "\n\n\nadded" << s;
        if (!s.contains(pattern))
            emit(usbWatcherAdded(s));
    }, Qt::DirectConnection);
    connect(watcher, &QDeviceWatcher::deviceChanged, this, [pattern, this](QString s){
        qDebug() << "\n\n\nchanged" << s;
        if (!s.contains(pattern))
            emit(usbWatcherChanged(s));
    }, Qt::DirectConnection);
    connect(watcher, &QDeviceWatcher::deviceRemoved, this, [pattern, this](QString s){
        qDebug() << "\n\n\nremoved" << s;
        if (!s.contains(pattern))
            emit(usbWatcherRemoved(s));
    }, Qt::DirectConnection);
    watcher->start();
}

void USBwatcher::run() {
}
