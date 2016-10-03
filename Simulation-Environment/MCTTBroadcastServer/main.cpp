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
