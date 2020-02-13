#ifndef CLIENT_H
#define CLIENT_H

#include <QDebug>
#include <QObject>
#include <QString>
#include <QUrl>
#include <QtWebSockets/QtWebSockets>

class Client : public QObject
{
public:
    Client(std::string ip);
    ~Client();

private:
private Q_SLOTS:
    void onConnected();
};

#endif // CLIENT_H
