import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {

//use getstorage to save light things
GetStorage _box=GetStorage();//it is temporary storage
String key='is dark mood';

save_to_box(bool is_darkMood)
{
  _box.write(key, is_darkMood);

}

bool load_from_box()
{
  return _box.read<bool>(key)??false; 

}


ThemeMode current_theme()
{
  return load_from_box()?ThemeMode.dark:ThemeMode.light;
}

switch_theme()
{
  bool rev_isdarkMood=!load_from_box();
  save_to_box(rev_isdarkMood);
  Get.changeThemeMode(current_theme());//instead of state management
}


}
