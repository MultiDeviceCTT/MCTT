#include "broadcastserver.h"

BroadcastServer::BroadcastServer(quint16 port, bool m_debug, QObject *parent)
    : QObject(parent),
      m_devicelist(),
      m_pWebSocketServer(new QWebSocketServer(QStringLiteral("Echo Server"), QWebSocketServer::NonSecureMode, this)),
      m_debug(m_debug)
{
    if (m_pWebSocketServer->listen(QHostAddress::Any, port)) {
        if (m_debug)
            qDebug() << "Server listening on port " << port;
        connect(m_pWebSocketServer, &QWebSocketServer::newConnection, this,&BroadcastServer::login);
        connect(m_pWebSocketServer, &QWebSocketServer::closed, this, &BroadcastServer::closed);
    }
}

BroadcastServer::~BroadcastServer()
{
    m_pWebSocketServer->close();
    qDeleteAll(m_devicelist.begin(), m_devicelist.end());
}

void BroadcastServer::login()
{
    QWebSocket *pSocket = m_pWebSocketServer->nextPendingConnection();

    connect(pSocket, &QWebSocket::textMessageReceived, this, &BroadcastServer::textMessageReceived);
    connect(pSocket, &QWebSocket::disconnected, this, &BroadcastServer::logout);

    m_devicelist << pSocket;
}

void BroadcastServer::logout()
{
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    if (m_debug) qDebug() << "socketDisconnected: " << pClient;
    if (pClient)
    {
        m_devicelist.removeAll(pClient);
        pClient->deleteLater();
    }
}

void BroadcastServer::textMessageReceived(QString text)
{
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    if(text == "lock")
    {
        lock(pClient);
    }
    else if(text == "unlock")
    {
        unlock(pClient);
    }
    else
    {
        broadcastTransition(pClient, text);
    }
}

void BroadcastServer::broadcastTransition(QWebSocket *client, QString transition)
{
    if (m_debug) qDebug() << "Message received:" << transition;
    if (client)
    {
        for(auto it = m_devicelist.begin(); it != m_devicelist.end(); it++)
        {
            if(*it != client)
            {
                (*it)->sendTextMessage(transition);
            }
        }
    }
}

void BroadcastServer::lock(QWebSocket *client)
{
    if(client)
    {
        if(m_lock.tryLock())
        {
            qDebug() << "granted lock to " << client->localAddress() << ":" << client->localPort();
            client->sendTextMessage("true");
        }
        else
        {
            qDebug() << "refused lock to " << client->localAddress() << ":" << client->localPort();
            client->sendTextMessage("false");
        }
    }
}

void BroadcastServer::unlock(QWebSocket *client)
{
    if(client)
    {
        qDebug() << "unlocked by " << client->localAddress() << ":" << client->localPort();
        m_lock.unlock();
    }
}

QList<QWebSocket *> BroadcastServer::deviceList() const
{
    return m_devicelist;
}
