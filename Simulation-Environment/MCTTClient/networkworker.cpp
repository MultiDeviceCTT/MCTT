#include "networkworker.h"
#include "QCoreApplication"

NetworkWorker::NetworkWorker()
{

}

NetworkWorker::~NetworkWorker()
{

}

void NetworkWorker::connectToServer(const QUrl &url, QWaitCondition* condition)
{
    m_url = url;
    m_condition = condition;
    qDebug() << "Connecting to WebSocket server:" << m_url;
    connect(&m_websocket, &QWebSocket::connected, this, &NetworkWorker::onConnected);
    connect(&m_websocket, &QWebSocket::disconnected, this, &NetworkWorker::onClosed);
    m_websocket.open(QUrl(m_url));
}

void NetworkWorker::onConnected()
{
    qDebug() << "WebSocket connected";
    connect(&m_websocket, &QWebSocket::textMessageReceived, this, &NetworkWorker::onTextMessageReceived);
}

void NetworkWorker::onClosed()
{
    qDebug() << "WebSocket closed";
}

void NetworkWorker::onSendData(QString data)
{
    qDebug() << "sending data " + data;
    m_websocket.sendTextMessage(data);
}

void NetworkWorker::onTextMessageReceived(QString message)
{
    qDebug() << "Message received" << message;
    if(message == "true") // can only be a lock message
    {
        emit lockAcquired();
        qDebug() << "lockAcquired emitted";
        m_condition->wakeAll();
    }
    else if (message == "false") // can also only be a lock message
    {
        emit lockRefused();
        m_condition->wakeAll();
    }
    else
    {
        //separate message from data
        QStringList parts = message.split(":");
        emit messageReceived(parts.at(0), parts.at(1));
    }
}
