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

#ifndef PROCESS_H
#define PROCESS_H

#include <QProcess>
#include <QVariant>

class Process : public QProcess {
  Q_OBJECT

public:
  Process(QObject * parent = nullptr) : QProcess(parent) { }

  Q_INVOKABLE void start(const QString &program, const QVariantList &arguments) {
    QStringList args;
    // convert QVariantList from QML to QStringList for QProcess
    for(int i = 0; i < arguments.length(); ++i) {
      args << arguments[i].toString();
    }

    QProcess::start(program, args);
  }

  Q_INVOKABLE QByteArray readAll() {
    return QProcess::readAll();
  }
};

#endif // PROCESS_H
