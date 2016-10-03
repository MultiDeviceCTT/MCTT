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
#ifndef NETWORKTHREAD_H
#define NETWORKTHREAD_H
#include <QThread>
#include <QWaitCondition>
#include <QWebSocket>

class NetworkWorker : public QObject
{
    Q_OBJECT

public:
    NetworkWorker();
    ~NetworkWorker();

    void connectToServer(const QUrl &url, QWaitCondition* condition);

public slots:
    void onTextMessageReceived(QString message);
    void onSendData(QString data);
    void onConnected();
    void onClosed();

signals:
    void lockAcquired();
    void lockRefused();
    void messageReceived(QString message, QString data);

private:
    QWaitCondition* m_condition;
    QWebSocket      m_websocket;
    QUrl            m_url;
};

#endif // NETWORKTHREAD_H
