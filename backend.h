#ifndef BACKEND_H
#define BACKEND_H

#include <fstream>
#include <iostream>
#include <QDateTime>
#include <QObject>
#include <QtWebSockets/QtWebSockets>
#include "usbwatcher.h"

class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)

public:
    explicit BackEnd(QObject *parent = nullptr);
    QString userName();
    void setUserName(const QString &userName);
    ~BackEnd();

    void setIp(std::string);
    Q_INVOKABLE bool buttonPressed();
    Q_INVOKABLE int changeColor();
    Q_INVOKABLE void setBrightness(int value);

    Q_INVOKABLE void send(QString msg);
    Q_INVOKABLE void passTest();
    Q_INVOKABLE void failTest();
    Q_INVOKABLE void skipTest();

    Q_INVOKABLE void writeLog(QString msg);

signals:
    void userNameChanged();
    void msgReceived();

private:
    QString m_userName;
    std::string logFileName;

    int nrButtonsPressed;
    static int nrButtons;
    int nrUsbTested;

    int color;

    QWebSocket *client;

    std::ofstream log;

    USBwatcher *watcher;

private Q_SLOTS:
    void onConnected();
    void processMsg(QString msg);
};

#endif // BACKEND_H

