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
    void usbAdded();
    void usbChanged();
    void usbRemoved();
//private:
};

#endif // USBWATCHER_H
