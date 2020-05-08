import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo/models/friend.dart';
import 'package:todo/models/todo.dart';

class AddSubjectVM {
  File selectedImageFile;
  String subjectTitle, subjectExplanation;
  //Time
  String _startDate;
  String _endDate;
  String startTime;
  String endTime;
  DateTime endDateInitDate;
  DateTime startDateLastDate;
  //Location
  List<double> latLngValues = <double>[];
  //Contributor
  Set<Friend> friendList;
  List<bool> selectedFriend;

  MapBoxPlace mapBoxPlace;
  //Tags tempory
  Set<int> tagChipsSelect = <int>{};
  Set<String> tags = <String>{};
  //
  //Priority
  int priority = 0;
  //ToDo List
  List<ToDo> toDoList = <ToDo>[ToDo()];
  int toDoIndex = 0;

  AddSubjectVM({@required this.friendList, @required this.tags}) {
    print("Created AddSubjectVM with friendList  ${friendList.length}");
    print("Created AddSubjectVM with tags  ${tags.toString()}");
    selectedFriend = List.generate(friendList.length, (index) => false);
  } //to do

  get startDate => _startDate;

  set startDate(String value) {
    _startDate = value;
    endDateInitDate =
        (Jiffy(value, "dd/MM/yyyy").dateTime.add(Duration(hours: 1)))
            .subtract(Duration(days: 1));
  }

  get endDate => _endDate;

  set endDate(value) {
    _endDate = value;
    startDateLastDate =
        (Jiffy(value, "dd/MM/yyyy").dateTime.add(Duration(hours: 1)))
            .subtract(Duration(days: 1));
  }

  void addTag(String tag) {
    if (tag != null && !tags.contains(tag)) {
      tags.add(tag);
      tagChipsSelect.add(tagChipsSelect.length);
      print("tags $tags  and lenght ${tag.length}");
      print(tagChipsSelect.toString());
    }
  }
}
