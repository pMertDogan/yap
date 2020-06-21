import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class ToDo {
  int id, subjectID, userID;
  String title, explanation, changeInfo;
  bool completed = false;
  DateTime changeDate;

//Data Methods

  ToDo({
    this.id,
    this.subjectID,
    @required this.title,
    @required this.userID,
    @required this.changeInfo,
    @required this.changeDate,
    this.explanation,
    this.completed,
  });

  Map<String, dynamic> toMap() {
    //Todo add id support,currently its working only for local db

    Map<String, dynamic> map = {
      'title': this.title,
      'user_id': this.userID,
      //For supporting Sqflite dateTime format
      'change_date': Jiffy(this.changeDate).format("yyyy-MM-dd HH:mm:ss"),
      'change_info': this.changeInfo,
    };
    if (explanation != null) {
      map['explanation'] = this.explanation;
    }
    return map;
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return new ToDo(
      id: map['id'] as int,
      subjectID: map['subject_id'] as int,
      title: map['title'] as String,
      explanation: map['explanation'] as String,
      completed: map['completed'] == 0 ? false : true,
      userID: map['user_id'] as int,
      changeDate:
          Jiffy(map['change_date'] as String, "yyyy-MM-dd HH:mm:ss").dateTime,
      changeInfo: map['change_info'] as String,
    );
  }
//Data class
}
