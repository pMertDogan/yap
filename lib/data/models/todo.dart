import 'package:flutter/material.dart';

class ToDo {
  int id, subjectID;
  String title, explanation;
  bool completed;

//Data Methods

  ToDo(
      {this.id,
      this.subjectID,
      @required this.title,
      this.explanation,
      this.completed});

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'explanation': this.explanation,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return new ToDo(
      id: map['id'] as int,
      subjectID: map['subject_id'] as int,
      title: map['title'] as String,
      explanation: map['explanation'] as String,
      completed: map['completed'] == 0 ? false : true,
    );
  }
//Data class
}
