#include "backend.h"

int BackEnd::nrButtons = 12;

BackEnd::BackEnd(QObject *parent)
    : QObject(parent)
{
    nrButtonsPressed = 0;
}

void BackEnd::setIp(std::string ip)
{
    client = new QWebSocket();
    connect(client, &QWebSocket::connected, this, &BackEnd::onConnected);
    //    connect(&m_webSocket, &QWebSocket::disconnected, this, &Client::closed);
    client->open(QUrl(QString::fromStdString(ip), QUrl::ParsingMode::TolerantMode));
}

void BackEnd::onConnected()
{
    connect(client, &QWebSocket::textMessageReceived, this, &BackEnd::processMsg);
//    client->sendTextMessage(QStringLiteral("Hello, world!"));
}

void BackEnd::processMsg(QString msg)
{
    qDebug() << "received: " << msg;
    emit(msgReceived());
}

void BackEnd::send(QString msg)
{
    client->sendTextMessage(msg);
}

QString BackEnd::userName()
{
    return m_userName;
}

bool BackEnd::buttonPressed()
{
    this->nrButtonsPressed++;
    return nrButtonsPressed >= BackEnd::nrButtons;
}

void BackEnd::setUserName(const QString &userName)
{
    if (userName == m_userName)
        return;

    m_userName = userName;
    emit userNameChanged();
}

//void BackEnd::touchTest()
//{
//    file << "touch test " << (nrButtonsPressed == BackEnd::nrButtons ? "passed" : "failed") << ": ";
//    file << nrButtonsPressed << " buttons pressed out of " << BackEnd::nrButtons << "\n";
//}

BackEnd::~BackEnd()
{
    client->disconnect();
}


void BackEnd::setBrightness(int value)
{
    std::ofstream backlightFile;
    backlightFile.open("/sys/devices/soc0/backlight/backlight/backlight/brightness");
    backlightFile << value;
    backlightFile.close();
}
