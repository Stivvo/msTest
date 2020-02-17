#include "backend.h"

int BackEnd::nrButtons = 12;

BackEnd::BackEnd(QObject *parent)
    : QObject(parent)
{
    nrButtonsPressed = 0;
    log.open("msTest.log");
}

void BackEnd::setIp(std::string ip)
{
    client = new QWebSocket();
    connect(client, &QWebSocket::connected, this, &BackEnd::onConnected);
    log << "set ip: " << ip << std::endl;
    //    connect(&m_webSocket, &QWebSocket::disconnected, this, &Client::closed);
    client->open(QUrl(QString::fromStdString("ws://" + ip + ":8080"), QUrl::ParsingMode::TolerantMode));
    log << "errorstring: " << client->errorString().toStdString() << std::endl;
}

void BackEnd::onConnected()
{
    connect(client, &QWebSocket::textMessageReceived, this, &BackEnd::processMsg);
    log << "connected" << std::endl;
    log << "errorstring: " << client->errorString().toStdString() << std::endl;
//    client->sendTextMessage(QStringLiteral("Hello, world!"));
}

void BackEnd::processMsg(QString msg)
{
    emit(msgReceived());
    std::ofstream fle;
    fle << "received: " << msg.toStdString() << std::endl;
}

void BackEnd::send(QString msg)
{
    client->sendTextMessage(msg);
}

void BackEnd::setBrightness(int value)
{
    std::ofstream backlightFile;
    backlightFile.open("/sys/devices/soc0/backlight/backlight/backlight/brightness");
    backlightFile << value;
    backlightFile.close();
}

bool BackEnd::buttonPressed()
{
    this->nrButtonsPressed++;
    return nrButtonsPressed >= BackEnd::nrButtons;
}

void BackEnd::writeLog(QString msg) {
    log << msg.toStdString() << std::endl;
    qDebug() << msg;
}

QString BackEnd::userName()
{
    return m_userName;
}

void BackEnd::setUserName(const QString &userName)
{
    if (userName == m_userName)
        return;

    m_userName = userName;
    emit userNameChanged();
}

BackEnd::~BackEnd()
{
    client->disconnect();
}
