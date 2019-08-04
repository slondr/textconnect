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

/** process.h
 * This file defines a Process class to be exposed to the QML, which providess
 * an interface to a QProcess object which allows spawning external processes.
 * This is the easiest way to start external processes from QML.
 */

#ifndef PROCESS_H
#define PROCESS_H

#include <QProcess>
#include <QVariant>

class Process : public QProcess {
  Q_OBJECT // Needed for all Qt classes

public:
  Process(QObject * parent = nullptr) : QProcess(parent) { }

  /** start
   * Takes a string representing a program and a list of strings representing
   * arguments for that program and runs the program using QProcess.
   */
  Q_INVOKABLE void start(const QString &program, const QVariantList &arguments) {
    QStringList args;
    // convert QVariantList from QML to QStringList for QProcess
    for(int i = 0; i < arguments.length(); ++i)
      args << arguments[i].toString();

    QProcess::start(program, args);
  }

  /** readAll
   * Defines readall() as invokable so that the QML object can call the function.
   */
  Q_INVOKABLE QByteArray readAll() {
    return QProcess::readAll();
  }
};

#endif // PROCESS_H
