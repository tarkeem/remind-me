import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/theme.dart';

class TaskTile extends StatelessWidget {
  TaskTile({required this.task, Key? key}) : super(key: key);
  Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 151,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getbkcolor(task.color!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.title!,
                  style: titlestyle,
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${task.startTime}-${task.endTime}',
                      style: subtitlestyle,
                    )
                  ],
                ),
                Text(
                  task.note!,
                  style: subtitlestyle,
                ),
              ],
            ),
            SizedBox(
              width: 3,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted==0?"is not done":
                'is done',
                style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  getbkcolor(int col) {
    switch (col) {
      case 0:
        return primaryClr;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
    }
  }
}
