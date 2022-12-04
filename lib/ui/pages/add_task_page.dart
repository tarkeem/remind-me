import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

import '../../controllers/task_controller.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TaskController taskController = Get.put(TaskController());
  DateTime date = DateTime.now();
  DateTime start_time = DateTime.now();
  DateTime end_time = DateTime.now().add(Duration(minutes: 15));
  TextEditingController title_controll = TextEditingController();
  TextEditingController note_controll = TextEditingController();
  int choosen_reminder = 5;
  String choosen_repeat = 'none';
  List<int> reminder = [5, 10, 15, 20];
  List<String> repeat = ['none', 'daily', 'weekly', 'monthly'];
  int choosen_circular=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('images/person.jpeg'),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'add task',
                style: headlinesstyle,
              ),
              InputField(note: 'enter task name', title: 'task',cotroll: title_controll,),
              InputField(note: 'enter note', title: 'note',cotroll: note_controll,),
              InputField(
                note: DateFormat.yMd().format(date),
                title: 'date',
                widg: showDate(),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                    note: DateFormat.Hm().format(start_time),
                    title: 'start time',
                    widg: showTime(true),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: InputField(
                    note: DateFormat.Hm().format(end_time),
                    title: 'end time',
                    widg: showTime(false),
                  )),
                ],
              ),
              InputField(
                note: "$choosen_reminder minute only",
                title: 'reminder time',
                widg: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Color.fromARGB(255, 184, 183, 183),
                  onChanged: (value) => setState(() {
                    choosen_reminder = int.parse(value!);
                  }),
                  value: choosen_reminder.toString(),
                  items: reminder
                      .map<DropdownMenuItem<String>>((value) =>
                          DropdownMenuItem(
                              value: value.toString(), child: Text('$value')))
                      .toList(),
                ),
              ),
              InputField(
                note: "$choosen_repeat",
                title: 'repeat',
                widg: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Color.fromARGB(255, 184, 183, 183),
                  onChanged: (value) => setState(() {
                    choosen_repeat = value!;
                  }),
                  value: choosen_repeat,
                  items: repeat
                      .map<DropdownMenuItem<String>>((value) =>
                          DropdownMenuItem(value: value, child: Text('$value')))
                      .toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'color:',
                        style: subtitlestyle,
                      ),
                      Row(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              child: CircleAvatar(
                                radius: 15,
                                child: choosen_circular == index
                                    ? Icon(Icons.done)
                                    : Container(),
                                backgroundColor: index == 0
                                    ? bluishClr
                                    : (index == 1 ? Colors.yellow : Colors.red),
                              ),
                              onTap: () => setState(() {
                                choosen_circular = index;
                              }),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  MyButton('insert', () {
                    checkInput();
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  addtodp() async {
    debugPrint('now in add fun');
    int? id =await taskController.add_task(Task(
        title: title_controll.text,
        note: note_controll.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(date),
        startTime: DateFormat.Hm().format(start_time),
        endTime: DateFormat.Hm().format(end_time),
        color: choosen_circular,
        remind: choosen_reminder,
        repeat: choosen_repeat));
    debugPrint('this ...........................is element $id');
  }

  showDate() {
    return IconButton(
        onPressed: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2022),
              lastDate: DateTime(2033));
          setState(() {
            date = pickedDate ?? DateTime.now();
          });
        },
        icon: Icon(Icons.access_time_filled_outlined));
  }
  showTime(bool isStart) {
    return IconButton(
        onPressed: () async {
          TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: isStart
                  ? TimeOfDay.fromDateTime(start_time)
                  : TimeOfDay.fromDateTime(end_time));
          setState(() {
            if (pickedTime == null) {
              pickedTime = TimeOfDay.now();
            }
            isStart
                ? start_time =
                    DateTime(2022, 1, 1, pickedTime!.hour, pickedTime!.minute)
                : end_time =
                    DateTime(2022, 1, 1, pickedTime!.hour, pickedTime!.minute);
          });
        },
        icon: Icon(Icons.access_time_filled_outlined));
  }

  void checkInput() {
    debugPrint('${title_controll.text.isEmpty}');
    if (title_controll.text.isEmpty || note_controll.text.isEmpty) {
      Get.snackbar('required', 'pleast enter all fields');
    } else {
      addtodp();
      Get.back();
    }
  }
}
