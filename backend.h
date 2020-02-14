#ifndef BACKEND_H
#define BACKEND_H

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
    Q_INVOKABLE void setBrightness(int value);
    Q_INVOKABLE void send(QString msg);
signals:
    void userNameChanged();
    void msgReceived();

private:
    QString m_userName;
    std::string logFileName;

    int nrButtonsPressed;
    static int nrButtons;
    QWebSocket *client;

    std::ofstream log;

private Q_SLOTS:
    void onConnected();
    void processMsg(QString msg);
};

#endif // BACKEND_H
