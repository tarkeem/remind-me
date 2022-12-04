import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {


   ThemeData light_mode=ThemeData(
    primaryColor:primaryClr ,
    backgroundColor:primaryClr ,
    brightness: Brightness.light
  );

   ThemeData dark_mode=ThemeData(
    primaryColor:darkGreyClr ,
    backgroundColor:darkGreyClr ,
    brightness: Brightness.dark
  );





}



   TextStyle get headlinesstyle{

    return GoogleFonts.lato(//need internet on device to download work

     textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.white:Colors.black
     )
      
    );

  }




TextStyle get subheadlinesstyle{

    return GoogleFonts.lato(

     textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.white:Colors.black
     )
      
    );

  }




  TextStyle get titlestyle{

    return GoogleFonts.lato(

     textStyle: TextStyle(
      fontSize:18 ,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.white:Colors.black
     )
      
    );

  }




  TextStyle get subtitlestyle{

    return GoogleFonts.lato(

     textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode?Colors.white:Colors.black
     )
      
    );

  }

 