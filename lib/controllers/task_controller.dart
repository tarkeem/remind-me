import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  static List tasks = [].obs;

  get_task()async {//call it after any changes for reloading data from database after any changes
    debugPrint('in get task fun');
    List <Map<String,Object?>>? tasks_as_jason=await DBHelper().query();
    debugPrint('$tasks_as_jason');

      if(tasks_as_jason!=null)
        {
          debugPrint('assign data to list');
          tasks.assignAll(tasks_as_jason.map((element) => Task().fromJason(element)).toList());

        }

  }

   Future add_task(Task task)async {
   return await DBHelper().insert(task);
  }

  delet_task(int id)async
  {
  await DBHelper().delet(id);
  }

  update_task(int id)async
  {
    await DBHelper().update(id);
  }
  delet_all()async
  {
    await DBHelper().deletall();

  }



}
