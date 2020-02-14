#ifndef USBWATCHER_H
#define USBWATCHER_H

#include <QThread>
#include <QDebug>
#include <QString>

#include <qdevicewatcher.h>

class USBwatcher : public QThread
{
public:
    USBwatcher(QObject *parent = 0);
private:
    QDeviceWatcher *watcher;
};

#endif // USBWATCHER_H
