#ifndef BACKEND_H
#define BACKEND_H

#include "client.h"
#include <fstream>
#include <iostream>
#include <QDateTime>
#include <QObject>
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

    Q_INVOKABLE void setIp(std::string);
    Q_INVOKABLE bool buttonPressed();
    Q_INVOKABLE void writeLog();
    Q_INVOKABLE void setBrightness(int value);

    Q_INVOKABLE void brightnessTest(bool passed);
    Q_INVOKABLE void touchTest();
    Q_INVOKABLE void endTest();
    Q_INVOKABLE void send(QString msg);
signals:
    void userNameChanged();
    void msgReceived();

private:
    QString m_userName;
    std::string logFileName;
    std::ofstream file;

    int nrButtonsPressed;
    static int nrButtons;
    QWebSocket *client;

private Q_SLOTS:
    void onConnected();
    void processMsg(QString msg);
};

#endif // BACKEND_H
