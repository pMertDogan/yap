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
  bool completed = false;

  //Custom
  List<ToDo> toDoList;
  List<Alarms> listOfAlarms;
  List<Friend> contributors;
  Set<String> tags;
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
    this.contributors,
    this.listOfAlarms,
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
    return 'Subject{picURL: $picURL, title: $title, explanation: $explanation, startDate: $startDate,'
        ' endDate: $endDate, startTime: $startTime, endTime: $endTime,picLocal: $picLocal, '
        'listOfAlarms: $listOfAlarms, contributors: $contributors, tags: $tags, priority: $priority, '
        'toDoList: $toDoList, latLngList: $latLngList,}';
  }

  Map<String, dynamic> toSubjectMap() {
    // ISO8601 YYYY-MM-DD HH:MM:SS.SSS
    // https://www.sqlitetutorial.net/sqlite-date/
    //https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
    //Return Map for Subject Table
    print("unconverted " + this.startDate);

    //HATAAAA
    String convertedStartDate =
        Jiffy(this.startDate, "dd/MM/yyyy").format("yyyy/MM/dd");
    String convertedStartTime =
        Jiffy(this.startTime, "HH:mm:ss").format("HH:mm:ss");
    String convertedEndDate, convertedEndTime;
    if (this.endTime != null) {
      convertedEndDate = Jiffy(this.endDate, "dd/MM/yyyy").format("yyyy/MM/dd");
      convertedEndTime = Jiffy(this.endTime, "HH:mm:ss").format("HH:mm:ss");
    }
    print(" converted time YYYY/MM/DD " + convertedStartDate);

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
      "completed": this.completed ? 1 : 0, // True => 1 False => 0
    };
  }

  List<Map<String, String>> tagsToTable() {
    //Return Map for Subject Table
    List<Map<String, String>> listOftagMap = [];

    if (tags.isNotEmpty) {
      //Convert each tag to Map
      tags.forEach((element) {
        listOftagMap.add(<String, String>{"name": element});
      });
    }

    return listOftagMap;
  }
}
