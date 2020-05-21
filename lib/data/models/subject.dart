import 'package:jiffy/jiffy.dart';
import 'package:todo/data/models/alarms.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/todo.dart';

class Subject {
  //SQL only support primitive data types => Shrink to tables
  //Primitive
  int id, priority;
  String picURL,
      picLocal,
      title,
      explanation,
      startDate,
      endDate,
      startTime,
      endTime;
  bool completed; //= false;

  //Custom fields - from other Tables
  List<ToDo> toDoList;
  List<Alarms> listOfAlarms;
  List<Friend> contributors;
  Set<String> tags;
  List<double> latLngList = <double>[];

  Subject({
    this.id,
    this.picURL,
    this.picLocal,
    this.title,
    this.explanation,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.contributors,
    this.listOfAlarms,
    this.completed,
    int priority,
    tags,
    List<ToDo> toDoList,
    List<double> latLng,
  })  : this.latLngList = latLng ?? <double>[],
        this.priority = priority ?? 0,
        this.toDoList = <ToDo>[ToDo()],
        this.tags = tags ?? <String>{};

  @override
  String toString() {
    return 'Subject{title: $title, explanation: $explanation, tags: $tags}';
  }

  Map<String, dynamic> toSubjectMap() {
    // ISO8601 YYYY-MM-DD HH:MM:SS.SSS
    // https://www.sqlitetutorial.net/sqlite-date/
    //https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
    //Return Map for Subject Table
    String convertedStartDate =
        Jiffy(this.startDate, "dd/MM/yyyy").format("yyyy/MM/dd");
    String convertedStartTime =
        Jiffy(this.startTime, "HH:mm:ss").format("HH:mm:ss");
    String convertedEndDate, convertedEndTime;
    if (this.endTime != null) {
      convertedEndDate = Jiffy(this.endDate, "dd/MM/yyyy").format("yyyy/MM/dd");
      convertedEndTime = Jiffy(this.endTime, "HH:mm:ss").format("HH:mm:ss");
    }

    return {
      //"id": this.id,
      "title": this.title,
      "explanation": this.explanation,
      "pic_url": this.picURL,
      "pic_local": this.picLocal,
      "start_date": convertedStartDate,
      "start_time": convertedStartTime,
      "end_date": convertedEndDate,
      "end_time": convertedEndTime,
      "priority": this.priority,
      //"completed": this.completed ? 1 : 0, // True => 1 False => 0
    };
  }

  List<Map<String, String>> toTagsMap() {
    //Return Map for Subject Table
    return List.generate(tags.length,
        (index) => <String, String>{"name": tags.elementAt(index)});
//    List<Map<String, String>> listOftagMap = [];
//
//    if (tags.isNotEmpty) {
//      //Convert each tag to Map
//      tags.forEach((element) {
//        listOftagMap.add(<String, String>{"name": element});
//      });
//    }
//    return listOftagMap;
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return new Subject(
      id: map['id'] as int,
      priority: map['priority'] as int,
      picURL: map['pic_url'] as String,
      picLocal: map['pic_local'] as String,
      title: map['title'] as String,
      explanation: map['explanation'] as String,
      startDate: map['start_date'] as String,
      endDate: map['end_date'] as String,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
      completed: map['completed'] == 0 ? false : true,
      toDoList: map['toDoList'] as List<ToDo>,
      listOfAlarms: map['listOfAlarms'] as List<Alarms>,
      contributors: map['contributors'] as List<Friend>,
      tags: map['tags'] as Set<String>,
      latLng: map['latLngList'] as List<double>,
    );
  }
}
