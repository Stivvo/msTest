#ifndef USBWATCHER_H
#define USBWATCHER_H

#include <QThread>
#include <QDebug>
#include <QString>

#include <qdevicewatcher/src/qdevicewatcher.h>

class USBwatcher : public QThread
{
    Q_OBJECT
public:
    USBwatcher(QObject *parent = 0);
    void run() override;
    QDeviceWatcher *watcher;
signals:
    void usbWatcherAdded(QString);
    void usbWatcherChanged(QString);
    void usbWatcherRemoved(QString);
//private:
};

#endif // USBWATCHER_H
