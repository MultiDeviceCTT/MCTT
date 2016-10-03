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
#include "proxy.h"
#include <QCoreApplication>

Proxy::Proxy(const QUrl &url, QObject *parent)
    : QObject(parent),
      m_url(url),
      m_lockMessageReceived(false),
      m_lock(false)
{

    connect(&m_nw, &NetworkWorker::lockAcquired, this, &Proxy::onLockAcquired);
    connect(&m_nw, &NetworkWorker::lockRefused, this, &Proxy::onLockRefused);
    connect(&m_nw, &NetworkWorker::messageReceived, this, &Proxy::onMessageReceived);
    connect(this, &Proxy::sendData, &m_nw, &NetworkWorker::onSendData);
    m_nw.connectToServer(m_url, &m_condition);
}

Proxy::~Proxy()
{

}

void Proxy::onLockAcquired()
{
    m_lockMessageReceived = true;
    m_lock = true;
    qDebug() << "lock acquired";
}

void Proxy::onLockRefused()
{
    m_lockMessageReceived = true;
    m_lock = false;
    qDebug() << "lock not acquired";
}

void Proxy::onMessageReceived(QString method, QString data)
{
    emit transitionOccured(method, data);
}

void Proxy::broadcastTransition(QString method, QString data)
{
    QString transmitData = method + ":" + data;
    emit sendData(transmitData);
}

void Proxy::acquire()
{
    emit sendData("lock");
}

void Proxy::release()
{
    m_lock = false;
    emit sendData("unlock");
}

bool Proxy::hasLock()
{
    m_lockMessageReceived = false;
    if(!m_lock)
    {
        acquire();
        // wait for answer
        while(!m_lockMessageReceived)
        {
            m_mutex.lock();
            // wait 10 ms
            m_condition.wait(&m_mutex, 20);
            // process potential retrieval events
            QCoreApplication::processEvents(QEventLoop::WaitForMoreEvents);
            m_mutex.unlock();
        }
    }
    return m_lock;
}
