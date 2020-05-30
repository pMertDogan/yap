import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:jiffy/jiffy.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/dbHelper.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/state/userVM.dart';

class AddSubjectVM {
  final DatabaseHelper databaseHelper = IN.get<DatabaseHelper>();
  //Create a subject object for tempory changes
  Subject subject = Subject();

  //Time logic
  DateTime endDateInitDate;
  DateTime startDateLastDate;
  //Location
  MapBoxPlace mapBoxPlace;

  //Contributor
  Set<Friend> friendList;
  List<bool> selectedFriendList = <bool>[];

  //Tags tempory
  Set<int> tagChipsSelect = <int>{};
  //to store tempary tags
  Set<String> tags = <String>{}; // "toplantı" , "yemek"

  //ToDo List
  //List<ToDo> toDoList = <ToDo>[ToDo()];
  int toDoIndex = 0;

  AddSubjectVM() {
    RM.get<SubjectVM>().listenToRM((subjectVM) {
      print("addSubjectVM updated tags : " + subjectVM.state.tags.toString());
      tags = subjectVM.state.tags ?? <String>{};
    });

    RM.get<UserVM>().listenToRM((rm) {
      if (rm.state.user != null) {
        print("AddSUBJECTVM updated friends : " +
            rm.state.user.friends.toString());
        friendList = rm.state.user.friends;
        selectedFriendList = rm.state.user.friends.isEmpty
            ? <bool>[]
            : List.generate(rm.state.user.friends.length, (index) => false);
      }
    });
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
    print(
        "changeContributors addsubjectVM " + dummyFriends.toList().toString());
  }

  void addTag(String yeniTag) {
    if (yeniTag != null && tags.add(yeniTag)) {
      tagChipsSelect.add(tags.length - 1);
      print(tagChipsSelect.toString());
    }
  }

  void addTagsToSubject() {
    //add selected tags to Subject
    if (tagChipsSelect.isNotEmpty) {
      tagChipsSelect
          .forEach((index) => subject.tags.add(tags.elementAt(index)));
    }
  }

  void clearFields() {
    tags.clear();
    tagChipsSelect.clear();
    subject = new Subject();
    toDoIndex = 0;
  }
}
