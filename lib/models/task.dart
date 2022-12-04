// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  Task fromJason(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      note: map['note'],
      isCompleted: map['isCompleted'],
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      color: map['color'],
      remind: map['remind'],
      repeat: map['repeat'],
    );
  }

}
