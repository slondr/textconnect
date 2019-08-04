/* TextConnect
   Copyright (C) 2019  Eric S. Londres

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "process.h"

int main(int argc, char *argv[])
{
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  // Initialize QtQuick app with cmdline arguments
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;
  const QUrl url(QStringLiteral("qrc:/main.qml"));

  // Expose QProcess module to QML
  qmlRegisterType<Process>("Process", 1, 0, "Process");

  QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
		   &app, [url](QObject *obj, const QUrl &objUrl) {
			   if (!obj && url == objUrl)
			     QCoreApplication::exit(-1);
			 }, Qt::QueuedConnection);
  engine.load(url);

  // Run program
  return app.exec();
}
