#ifndef BACKEND_H
#define BACKEND_H

#include "usbwatcher.h"
#include <fstream>
#include <iostream>
#include <QDateTime>
#include <QtWebSockets/QtWebSockets>

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
    Q_INVOKABLE void setBrightness(int value);

    Q_INVOKABLE void send(QString msg);
    Q_INVOKABLE void passTest();
    Q_INVOKABLE void failTest();
    Q_INVOKABLE void skipTest();

    Q_INVOKABLE void writeLog(QString msg);
    Q_INVOKABLE QString advance();
    Q_INVOKABLE bool finished();

signals:
    void userNameChanged();
    void msgReceived();
    void testAdvanced();

private:
    QString m_userName;
    std::string logFileName;

    int nrButtonsPressed;
    static int nrButtons;
    int nrUsbTested;

    QWebSocket *client;

    std::ofstream log;

    USBwatcher *watcher;

    int current;
    static const std::vector<QString> phases;

private Q_SLOTS:
    void onConnected();
    void processMsg(QString msg);
};

#endif // BACKEND_H
