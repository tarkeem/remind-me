import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static String _tableName = 'task';
  static Database? _mydb;
  static int _ver = 1;

  Future initDataBase() async {
    debugPrint('in database helper');
    if (_mydb != null) {
      debugPrint('database is alrady initialized');
    } else {

      try {
        String _path = await getDatabasesPath();
        _path = _path + 'task.db';
        _mydb = await openDatabase(// to create or open database
          _path,
          version: _ver,
          onCreate: (db, version) {//it will execute only if no database file in _path
            db.execute('CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING,note TEXT,color INT,startTime STRING,endTime STRING,repeat STRING,remind INT,isCompleted INT,date STRING)'
            );

          },
        );
        debugPrint('database  initialized');

      } catch (err) {
        debugPrint('error in database:$err');
      }
    }
  }

  Future<int?> insert(Task task)async {
    debugPrint('insert fun has called');
    try {
      debugPrint('element has been added');
      return await _mydb?.insert(_tableName, task.toJson());
      debugPrint('element has been added');
    }
    catch(e)
    {
      debugPrint('problem with added $e');
      return -1;
    }
  }

  delet(int taskId) {
    return _mydb!.delete(_tableName, where: 'id=$taskId');
  }

  update(int id) {
    return _mydb!.rawUpdate(
        '''UPDATE $_tableName 
        SET isCompleted = 1
         WHERE id =$id;

''');
  }

  Future<List<Map<String, Object?>>>? query() {
    return _mydb?.query(_tableName);
  }


  deletall()
  {
    _mydb!.delete(_tableName);
  }
}
