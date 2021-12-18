import 'dart:async';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/task.dart';

class DatabaseHelper {
  final String table = 'tasks';
  final String columnId = 'task_id';
  final String columnTaskName = 'task_name';
  final String columnDueDate = 'due_date';
  final String columnTime = 'time';
  final String columnPriority = 'priority';
  final String columnAlarm = 'alarm';
  final String columnDone = 'done';
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'toDo.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.

        return db.execute(
          'CREATE TABLE $table($columnId INTEGER PRIMARY KEY autoincrement, $columnTaskName TEXT, $columnDueDate TEXT, $columnTime TEXT, $columnPriority TEXT, $columnAlarm INTEGER, $columnDone TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int?> insertTask(Tasks task) async {
    Database _db = await database();
    final insertedId = await _db.insert('$table', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    var Id = _db.rawQuery('SELECT max (task_id) FROM $table');
    print(insertedId);
    // var lastId = Id['task_id'] as int;

    return insertedId;
  }

  Future<List<Tasks>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Tasks(
        id: taskMap[index]['task_id'],
        taskName: taskMap[index]['task_name'],
        dueDate: taskMap[index]['due_date'],
        time: taskMap[index]['time'],
        priority: taskMap[index]['priority'],
        alarm: taskMap[index]['alarm'],
        done: taskMap[index]['done'],
      );
    });
  }

  Future<List<Tasks>> getCompletedTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap =
        await _db.query('tasks', where: 'done=?', whereArgs: ['yes']);
    return List.generate(taskMap.length, (index) {
      return Tasks(
        id: taskMap[index]['task_id'],
        taskName: taskMap[index]['task_name'],
        dueDate: taskMap[index]['due_date'],
        time: taskMap[index]['time'],
        priority: taskMap[index]['priority'],
        alarm: taskMap[index]['alarm'],
        done: taskMap[index]['done'],
      );
    });
  }

  Future<List<Tasks>> getNotCompletedTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap =
        await _db.query('tasks', where: 'done=?', whereArgs: ['no']);
    return List.generate(taskMap.length, (index) {
      return Tasks(
        id: taskMap[index]['task_id'],
        taskName: taskMap[index]['task_name'],
        dueDate: taskMap[index]['due_date'],
        time: taskMap[index]['time'],
        priority: taskMap[index]['priority'],
        alarm: taskMap[index]['alarm'],
        done: taskMap[index]['done'],
      );
    });
  }

//   static DateFormat dateTimeFormatter = DateFormat('dd-MMM-yyyy HH:mm');

//   static String datetime = dateTimeFormatter.format(DateTime.now());
//   static List parts = datetime.split(" ");
//   static String date = parts[0];
//   static String time = parts[1];
//   static String dt = date + time;
//   static DateTime dtformatted = DateTime.now();
//   Future<List<Tasks>> getOverdueTasks() async {
//     Database _db = await database();
//     List<Map<String, dynamic>> taskMap = await _db.rawQuery('''SELECT
//     $columnDueDate || ' ' || $columnTime as dt1,
//     DATETIME('now', 'localtime') as dt

// FROM
//     $table
// WHERE (dt1 < dt ''');
//     return List.generate(taskMap.length, (index) {
//       return Tasks(
//         id: taskMap[index]['task_id'],
//         taskName: taskMap[index]['task_name'],
//         dueDate: taskMap[index]['due_date'],
//         time: taskMap[index]['time'],
//         priority: taskMap[index]['priority'],
//         alarm: taskMap[index]['alarm'],
//         done: taskMap[index]['done'],
//       );
//     });
//   }

  Future<int> updateTask(Tasks task) async {
    Database _db = await database();
    return await _db.update('$table', task.toMap(),
        where: 'task_id=?', whereArgs: [task.id]);
  }

  Future<int> updateTaskDone(TaskDone task) async {
    Database _db = await database();
    return await _db.update('$table', task.toDoneMap(),
        where: 'task_id=?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    Database _db = await database();
    return await _db.delete('$table', where: 'task_id=?', whereArgs: [id]);
  }
}
