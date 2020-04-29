import 'package:todo/models/alarms.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/models/user.dart';

class Subject {
  String picURL, picLocal, title, explanation;
  String startDate, endDate, startTime, endTime;
  DateTime startDateTime, endDateTime;
  var locationGPS;
  List<Alarms> listOfAlarms;
  List<User> contributors;
  List<String> tags;
  int priority;
  List<ToDo> todoList;

  Subject(
      {this.picURL,
      this.picLocal,
      this.title,
      this.explanation,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.startDateTime,
      this.endDateTime,
      this.locationGPS,
      this.listOfAlarms,
      this.contributors,
      this.tags,
      this.priority,
      this.todoList});
}
