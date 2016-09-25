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
