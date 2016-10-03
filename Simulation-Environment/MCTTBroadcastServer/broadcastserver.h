/*******************************************************************************
 * Copyright (c) 2016 Andreas Wagner.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *     Andreas Wagner - Concept and implementation
 *     Christian Prehofer - Concept
 *******************************************************************************/
#ifndef BROADCASTSERVER_H
#define BROADCASTSERVER_H

#include <QList>
#include <QtWebSockets/QWebSocketServer>
#include <QtWebSockets/QWebSocket>
#include <QDebug>
#include <QMutex>

class BroadcastServer : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(QStringList devicelist READ devicelist NOTIFY deviceListChanged)
public:
    BroadcastServer(quint16 port, bool m_debug = false, QObject *parent = Q_NULLPTR);
    ~BroadcastServer();

public slots:
    //a device registers
    void login();

    //a device logs out
    void logout();

    //a device sent a message
    void textMessageReceived(QString text);

public:
    QList<QWebSocket *> deviceList() const;
    //a device sends a transition
    void broadcastTransition(QWebSocket* client, QString transition);
    //a device wants to send a transition
    void lock(QWebSocket* client);
    //a device finished a transition
    void unlock(QWebSocket* client);

signals:
    void closed();

private:
    QList<QWebSocket*> m_devicelist;
    QWebSocketServer*  m_pWebSocketServer;
    QMutex m_lock;
    bool m_debug;
};

#endif // BROADCASTSERVER_H
