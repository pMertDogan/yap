import 'package:todo/data/base/subjectBase.dart';
import 'package:todo/data/dbHelper.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/data/models/todo.dart';

class SubjectVM implements SubjectBase {
  Set<String> allTags = <String>{};
  List<Subject> listOfAllSubjects = <Subject>[];
  Set<int> tagChipsSelect = <int>{};
  Set<String> tags = <String>{};
  List<Subject> listOfSubjects = <Subject>[];
  List<String> listOfSubjectsStartDates = <String>[];
  List<int> listOfTotalSubjectCountForEachDay = <int>[];
  int selectedStartDayIndex = 0;
  String orderByParamater = "Priority";

  final DatabaseHelper databaseHelper;

  SubjectVM(this.databaseHelper);

  @override
  Future<void> addSubject(Subject subjectToAdd) async {
    if (subjectToAdd.title.isEmpty) {
      throw "Subject title empty";
    } else if (subjectToAdd.toDoList[0].title.isEmpty) {
      throw "Todo name empty";
    } else {
      //fake delay
      await Future.delayed(Duration(seconds: 2));
      //save to sqflite
      await databaseHelper.addSubject(subjectToAdd);
      print("subject added to local sql Table");
      await getInitDatas();
    }
  }

  @override
  Future<void> deleteSubject(Subject value) {
    //Check is Subject in list?
    if (listOfSubjects.contains(value)) {
      listOfSubjects.removeAt(listOfSubjects.indexOf(value));
    }
  }

  @override
  Future<void> deleteSubjectByID(int subjectID) {
    //databaseHelper.
    //Check index is acceptable
//    if (index >= 0 && index <= listOfSubjects.length - 1) {
//      listOfSubjects.removeAt(index);
//    }
  }

  @override
  Future<void> updateSubject(Subject updatedSubject, int indexToReplace) {
    listOfSubjects[indexToReplace] = updatedSubject;
  }

  Future<void> updateFavoriteStatus(Subject subject) async {
    await databaseHelper.updateFavoriteStatus(subject.id, subject.favorite);
    await getSelectedDayData(filterByTags: true);
  }

  Future<void> updateSubjectContributors(
      List<Friend> updatedContributors, int subjecID) async {
    await databaseHelper.updateSubjectContributors(
        updatedContributors, subjecID);
    await getSelectedDayData(filterByTags: true);
  }

  Future<void> updateSubjectTags(int subjectID, Set<String> subjectTags) async {
    await databaseHelper.updateSubjectTags(subjectID, subjectTags);
    await databaseHelper.removeUnusedTags();
    await getInitDatas();
    await getSelectedDayData(filterByTags: true);
  }

  Future<void> updateToDoStatus(int todoID, bool status) async {
    await databaseHelper.updateToDoStatus(todoID, status);
    await getSelectedDayData(filterByTags: true);
  }

  Future<int> addToDoToSubject(ToDo toDo, int subjectId) async {
    int id = await databaseHelper.addToDoToSubject(toDo, subjectId);
    await getSelectedDayData(filterByTags: true);
    print("todo ıd " + id.toString());
    //return id to fix newly crated toDo (without ıd field) id on DetailVM
    return id;
  }

  Future<void> getInitDatas() async {
    //Is it for all or only for specific start_date?
    listOfAllSubjects =
        await databaseHelper.getSubjects(orderBy: orderByParamater);
    listOfSubjects = await databaseHelper.getSubjects(
        orderBy: orderByParamater); //?? <Subject>[];
    allTags = await databaseHelper.getAllTags();
    tags = await databaseHelper.getAllTags(); //?? <String>{} if none
    tagChipsSelect = List.generate(tags.length, (index) => index).toSet();
    //Get datas  for daysUI
    await databaseHelper.getAllSubjectStartDates().then((value) {
      listOfSubjectsStartDates = value[0];
      return listOfTotalSubjectCountForEachDay = value[1];
    });
//    print("SUBJECTVM getInitDates subjects length: " +
//        listOfSubjects.length.toString());
  }

  Future<void> getSelectedDayData({bool filterByTags = false}) async {
    if (filterByTags) {
      //created selected tag set
      Set<String> selectedTags = List.generate(tagChipsSelect.length, (index) {
        return tags.elementAt(tagChipsSelect.elementAt(index));
      }).toSet();
      print("selected Tags" + selectedTags.toString() + "SubjectVM");
      //get filtered tags
      if (selectedStartDayIndex == 0) {
        listOfSubjects = await databaseHelper.getSubjects(
            tags: selectedTags, orderBy: orderByParamater);
      } else {
        listOfSubjects = await databaseHelper.getSubjects(
            //-1 for avoid "All" tab index problem
            startDate: listOfSubjectsStartDates[selectedStartDayIndex - 1],
            tags: selectedTags); //?? <Subject>[];
      }
    }
    //just get subjects by start_date
    else {
      listOfSubjects = await databaseHelper.getSubjects(
          startDate: listOfSubjectsStartDates[selectedStartDayIndex - 1],
          orderBy: orderByParamater);
      tags.clear();
      await Future.forEach(
          listOfSubjects, (Subject element) => tags.addAll(element.tags));
      tagChipsSelect = List.generate(tags.length, (index) => index).toSet();
    }
  }

  Future<void> deleteToDoById(int todoID) async {
    await databaseHelper.deleteToDoById(todoID);
    await getSelectedDayData(filterByTags: true);
  }

  Future<void> updateSubjectLocation(
      int subjectID, double lat, lng, String locationName) async {
    await databaseHelper.updateSubjectLocation(
        subjectID, lat, lng, locationName);
    await getSelectedDayData(filterByTags: true);
  }
}
