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
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QStateMachine>
#include <QQmlContext>
#include <QCommandLineParser>
#include "proxy.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCommandLineParser parser;
    parser.setApplicationDescription("QML State Machine Simulator");
    parser.addOptions({
        {"server", "Adress of the server", "server", "localhost"},
        {"port", "Server port", "port", "9000"},
        {"model", "The path to the QML model to display as GUI", "model"},
        {"proxies", "Proxy names to be used in QML proxies (comma-separated)", "proxies"},
    });

    //process cmd-arguments
    parser.process(app);
    const QStringList proxies = parser.value("proxies").split(",");
    const QString server = parser.value("server");
    const QString port = parser.value("port");

    //Proxy object for local machine
    //used as both proxy for broadcasting and receiving transitions
    Proxy local(QUrl("ws://" + server + ":" + port), &app);

    QQmlApplicationEngine engine;
    //load local proxy into QML engine
    engine.rootContext()->setContextProperty("local", &local);
    //load remote proxies into QML engine
    for (auto str = proxies.begin(); str != proxies.end(); str++)
    {
        engine.rootContext()->setContextProperty(*str, &local);
    }
    //engine.load(QUrl(QStringLiteral("../../../qml/MDModel.qml")));
    QString model = parser.value("model");
    engine.load(QUrl(model));

    return app.exec();
}
