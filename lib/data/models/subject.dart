import 'package:todo/data/models/alarms.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/todo.dart';

class Subject {
  int id;
  String picURL, title, explanation;
  String startDate, endDate, startTime, endTime;

  //DateTime startDateTime, endDateTime; //Its not needed and not supported by Floor liblary.
  String picLocal; //Custom type not supported by Floor
  List<Alarms> listOfAlarms;
  List<Friend> contributors;
  Set<String> tags;
  int priority;
  List<ToDo> toDoList;
  bool completed; //Add This for check
  List<double> latLngList = <double>[];

  Subject({
    this.picURL,
    this.picLocal,
    this.title,
    this.explanation,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    //this.startDateTime,
    //this.endDateTime,
    this.listOfAlarms,
    this.contributors,
    tags,
    int priority,
    List<ToDo> toDoList,
    List<double> latLng,
  })  : this.latLngList = latLng ?? <double>[],
        this.priority = priority ?? 0,
        this.toDoList = <ToDo>[ToDo()],
        this.tags = tags ?? <String>{};

  @override
  String toString() {
    return 'Subject{picURL: $picURL, title: $title, explanation: $explanation, startDate: $startDate,'
        ' endDate: $endDate, startTime: $startTime, endTime: $endTime,picLocal: $picLocal, '
        'listOfAlarms: $listOfAlarms, contributors: $contributors, tags: $tags, priority: $priority, '
        'toDoList: $toDoList, latLngList: $latLngList,}';
  }
}
