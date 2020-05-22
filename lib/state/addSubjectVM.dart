import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:jiffy/jiffy.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/data/dbHelper.dart';
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
  List<bool> selectedFriendList;

  //Tags tempory
  Set<int> tagChipsSelect = <int>{};
  //to store tempary tags
  Set<String> tags = <String>{}; // "toplantı" , "yemek"

  //ToDo List
  //List<ToDo> toDoList = <ToDo>[ToDo()];
  int toDoIndex = 0;

  //AddSubjectVM(this.databaseHelper, this.userVM, this.subjectVM) {
  AddSubjectVM() {
    RM.get<UserVM>().listenToRM((rm) {
      if (rm.state.user != null) {
        friendList = rm.state.user.friends;
        print("addSubjectVM friends updated" + friendList.toString());
        selectedFriendList = friendList.isEmpty
            ? <bool>[]
            : List.generate(friendList.length, (index) => false);
      }
    });

    RM.get<SubjectVM>().listenToRM((subjectVM) {
      print("addSubjectVM tags updated");
      tags = subjectVM.state.tags.isEmpty ? <String>{} : subjectVM.state.tags;
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
    print(dummyFriends.toList());
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
