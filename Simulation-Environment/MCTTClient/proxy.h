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
#ifndef PROXY_H
#define PROXY_H

#include <QObject>
#include <QWebSocket>
#include <QWaitCondition>
#include <QMutex>
#include "networkworker.h"

class Proxy : public QObject
{
    Q_OBJECT

public:
    Proxy(const QUrl &url, QObject *parent);
    ~Proxy();

public:
    //low-level methods, not invokable by the QML object
    void acquire();

    //invokable high-level methods
    Q_INVOKABLE void broadcastTransition(QString method, QString data);
    Q_INVOKABLE bool hasLock();
    Q_INVOKABLE void release();
signals:
    void transitionOccured(QString method, QString data);
    void sendData(QString data);

public slots:
    void onLockAcquired();
    void onLockRefused();
    void onMessageReceived(QString method, QString data);

private:
    QUrl           m_url;
    QWebSocket     m_websocket;
    QMutex         m_mutex;
    bool           m_lockMessageReceived;
    bool           m_lock;
    QWaitCondition m_condition;
    NetworkWorker  m_nw;
};

#endif // PROXY_H
