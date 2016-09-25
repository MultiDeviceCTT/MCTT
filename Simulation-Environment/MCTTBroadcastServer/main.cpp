#include <QCoreApplication>
#include <QCommandLineParser>
#include <QCommandLineOption>
#include "broadcastserver.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    QCommandLineParser parser;
    parser.setApplicationDescription("QML State Machine Simulator Server");
    parser.addOption({"port", "Port", "port", "9000"});

    parser.process(a);
    const QString port = parser.value("port");

    BroadcastServer *server = new BroadcastServer(port.toInt(), true);
    QObject::connect(server, &BroadcastServer::closed, &a, &QCoreApplication::quit);

    return a.exec();
}
