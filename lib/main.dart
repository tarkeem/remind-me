import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/theme.dart';

import 'ui/pages/home_page.dart';
//by tarkeem(tarek)
void main() async {
  debugPrint('main start.....');
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); //to bring values that stored in
  await DBHelper().initDataBase();
  NotifyHelper().initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( //instead of material app because we will use get
      theme: Themes().light_mode,
      darkTheme: Themes().dark_mode,
      themeMode: ThemeServices().current_theme(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
