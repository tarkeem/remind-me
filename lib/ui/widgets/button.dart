import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  String label;
  Function() ontab;
  MyButton(this.label,this.ontab);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontab,
      child: Container(
        width: 100,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(30)
        ),
        child:Text(
          '$label'
        ) ,
      )
      );
  }
}
