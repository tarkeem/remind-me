import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import 'package:todo/ui/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskController.get_task();



  }
  @override
  DateTime? choosen_date=DateTime.now() ;
  TaskController taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    print('main.......');
    print(Get.isDarkMode);
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              TaskController().delet_all();
              NotifyHelper().Cancelall();
              TaskController().get_task();//make refresh on elements
            },
                icon: Icon(Icons.cleaning_services_outlined))
          ],
          leading: IconButton(
              icon: Get.isDarkMode
              ? Icon(Icons.sunny)
              : Icon(Icons.nightlight_outlined),
              onPressed: ()async {
                debugPrint('start');
                NotifyHelper()//test
                    .displayNotification(title: 'theme', body: 'theme have been changed');



                  await ThemeServices().switch_theme();
                setState(() {

                });

              },
          )
        ),
        body: Column(
          children: [Expanded(child:task_bar(),flex: 1, ) ,
            Expanded(child:date_bar(),flex: 1, ) ,
            Expanded(child: show_tasks(),flex: 3,)],
        ));
  }

  task_bar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: subheadlinesstyle,
              ),
              Text(
                'today',
                style: headlinesstyle,
              )
            ],
          ),
          MyButton('+ add task', () async {
            await Get.to(
                AddTaskPage()); //that means:wait until i back from the screen then execute the below code
           await taskController.get_task();
            setState(() {

            });
          })
        ],
      ),
    );
  }

  date_bar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        monthTextStyle: TextStyle(fontWeight: FontWeight.w900),
        onDateChange: (selectedTime){
          setState(() {
            choosen_date=selectedTime;
            debugPrint('date;$choosen_date');
          });
        },
      ),
    );
  }

  show_tasks() {
    return Obx ( //this widget to listen to any change to list.obx which is obx
        (){return TaskController.tasks.isEmpty?show_notask():ListView.builder(
          itemCount: TaskController.tasks.length,
        itemBuilder: ((context, index) {
          Task task = TaskController.tasks[index];

          var hour=task.startTime!.split(':')[0];
          var minute=task.startTime!.split(':')[1];
          debugPrint('$hour $minute');

          /*DateTime date=DateFormat.jm().parse(task.startTime!);
          String mytime=DateFormat.Hm().format(date);
          debugPrint('$date');*/
          NotifyHelper().scheduledNotification(int.parse(hour),int.parse(minute), task);
            if(task.date==DateFormat.yMd().format(choosen_date??DateTime.now()) ||
                task.repeat=='daily'||
                (task.repeat=='weekly'&&choosen_date!.difference(DateFormat.yMd().parse(task.date!)).inDays%7==0 )||
                (task.repeat=='monthly' && DateFormat.yMd().parse(task.date!).day==choosen_date!.day )
            )//if
              {
          return AnimationConfiguration.staggeredList(
            duration: Duration(seconds: 2),
            position: index,
            child: SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () => show_button_sheet(context, task),
                  child: TaskTile(task: task),
                ),
              ),
            ),
          );
              }
            else
              {
                return Container();
              }

        }),

      );}
    );

  }

  show_button_sheet(cxt, Task task) {
    return Get.bottomSheet(Container(
      color: Get.isDarkMode ? Colors.grey : Colors.white,
      height: SizeConfig.screenHeight * 0.4,
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            task.isCompleted != 1
                ? _build_button_sheet('is done', Colors.green, () {
                  TaskController().update_task(task.id!);
                  NotifyHelper().Cancel(task);
                  Get.back();
                  TaskController().get_task();


                })
                : Container(),
            _build_button_sheet('back', Colors.blue, () => Get.back()),
            _build_button_sheet('delet', Colors.red, () {
              TaskController().delet_task(task.id!);
              NotifyHelper().Cancel(task);
              Get.back();
              TaskController().get_task();
            }),
          ],
        ),
      ),
    ));
  }

  Widget _build_button_sheet(
      String label,
      Color col,
      Function()
          on_press) //function() if you will pass annonyms fun as parameter,function if you pass fun name
  {
    return GestureDetector(
      onTap: on_press,
      child: Container(
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: col,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                width: 2, color: Get.isDarkMode ? Colors.white : Colors.black)),
        child: Center(
          child: Text(
            label,
            style: subtitlestyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
  show_notask()
  {
    return RefreshIndicator (
      onRefresh:onrefresh ,
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            SizedBox(
              height: 120,
            ),
            SvgPicture.asset(
              'images/task.svg',
              color: primaryClr,
              height: 50,
              width: 50,
            ),
            Text('you dont have tasks\n try to add some '),
            SizedBox(
              height: 20,
            )
          ],
        ),
      )
    );
  }
   Future<void> onrefresh()async{
    await taskController.get_task();
    debugPrint('refresh');
  }
}
