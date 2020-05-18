import 'package:flutter/cupertino.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/data/dbHelper.dart';

class AddSubjectVM {
  final DatabaseHelper databaseHelper;

  //Create a subject object for tempory changes
  Subject subject = Subject();

  //Time logic
  DateTime endDateInitDate;
  DateTime startDateLastDate;
  //Location
  MapBoxPlace mapBoxPlace;

  //Contributor
  Set<Friend> friendList;
  List<bool> selectedFriendList;

  //Tags tempory
  Set<int> tagChipsSelect = <int>{};
  Set<String> tags = <String>{}; // "toplantı" , "yemek"

  //ToDo List
  List<ToDo> toDoList = <ToDo>[ToDo()];
  int toDoIndex = 0;

  AddSubjectVM(this.databaseHelper,
      {@required this.friendList, @required this.tags}) {
    print("Created AddSubjectVM with friendList  ${friendList.length}");
    print("Created AddSubjectVM with tags  ${tags.toString()}");
    selectedFriendList = List.generate(friendList.length, (index) => false);
  }

  set startDate(String value) {
    subject.startDate = value;
    endDateInitDate =
        (Jiffy(value, "dd/MM/yyyy").dateTime.add(Duration(hours: 1)))
            .subtract(Duration(days: 1));
  }

  set endDate(value) {
    subject.endDate = value;
    startDateLastDate =
        (Jiffy(value, "dd/MM/yyyy").dateTime.add(Duration(hours: 1)))
            .subtract(Duration(days: 1));
  }

  void changeContributorStatus(int index) {
    selectedFriendList[index] = !selectedFriendList[index];
    //create dummy list
    List<Friend> dummyFriends = <Friend>[];
    // for each friend
    for (int i = 0; i <= friendList.length - 1; i++) {
      // friend status !false ?
      if (selectedFriendList[i]) {
        dummyFriends.add(friendList.elementAt(i));
      }
    }
    subject.contributors = dummyFriends;
    print(dummyFriends.toList());
  }

  void addTag(String yeniTag) {
    if (yeniTag != null && tags.add(yeniTag)) {
      tagChipsSelect.add(tags.length - 1);
      print(tagChipsSelect.toString());
    }
  }

  addTagsToSubject() {
    //add selected tags to Subject
    tagChipsSelect.forEach((index) => subject.tags.add(tags.elementAt(index)));
  }
}
