import 'package:todo/data/base/subjectBase.dart';
import 'package:todo/data/dbHelper.dart';
import 'package:todo/data/models/subject.dart';

class SubjectVM implements SubjectBase {
  Set<String> allTags = <String>{};
  List<Subject> listOfAllSubjects = <Subject>[];
  Set<int> tagChipsSelect = <int>{};
  Set<String> tags = <String>{};
  List<Subject> listOfSubjects = <Subject>[];
  List<String> listOfSubjectsStartDates = <String>[];
  List<int> listOfTotalSubjectCountForEachDay = <int>[];
  int selectedStartDayIndex = 0;

  final DatabaseHelper databaseHelper;

  SubjectVM(this.databaseHelper);

  @override
  Future<void> addSubject(Subject value) async {
    await Future.delayed(Duration(seconds: 2));
    //save to sqflite
    await databaseHelper.addSubject(value);
    print("subject added to local sql Table");
    await getInitDatas();
  }

  @override
  Future<void> deleteSubject(Subject value) {
    //Check is Subject in list?
    if (listOfSubjects.contains(value)) {
      listOfSubjects.removeAt(listOfSubjects.indexOf(value));
    }
  }

  @override
  Future<void> deleteSubjectByIndex(int index) {
    //Check index is acceptable
    if (index >= 0 && index <= listOfSubjects.length - 1) {
      listOfSubjects.removeAt(index);
    }
  }

  @override
  Future<void> updateSubject(Subject updatedSubject, int indexToReplace) {
    listOfSubjects[indexToReplace] = updatedSubject;
  }

  Future<void> getInitDatas() async {
    //Is it for all or only for specific start_date?
    listOfAllSubjects = await databaseHelper.getSubjects();
    listOfSubjects = await databaseHelper.getSubjects(); //?? <Subject>[];
    allTags = await databaseHelper.getAllTags();
    tags = await databaseHelper.getAllTags(); //?? <String>{} if none
    tagChipsSelect = List.generate(tags.length, (index) => index).toSet();
    //Get datas  for daysUI
    await databaseHelper.getAllSubjectStartDates().then((value) {
      listOfSubjectsStartDates = value[0];
      return listOfTotalSubjectCountForEachDay = value[1];
    });
    print("SUBJECTVM getAll subjects length: " +
        listOfSubjects.length.toString());
  }

  Future<void> getSelectedDayData({bool filterByTags = false}) async {
    if (filterByTags) {
      //created selected tag set
      Set<String> selectedTags = List.generate(tagChipsSelect.length, (index) {
        return tags.elementAt(tagChipsSelect.elementAt(index));
      }).toSet();
      //get filtered tags
      if (selectedStartDayIndex == 0) {
        listOfSubjects = await databaseHelper.getSubjects(tags: selectedTags);
      } else {
        listOfSubjects = await databaseHelper.getSubjects(
            //-1 for avoid "All" tab index problem
            startDate: listOfSubjectsStartDates[selectedStartDayIndex - 1],
            tags: selectedTags); //?? <Subject>[];
      }
      print("subjectVM deki subject uzunluğu " +
          listOfSubjects.length.toString());
    }
    //just get subjects by start_date
    else {
      listOfSubjects = await databaseHelper.getSubjects(
          startDate: listOfSubjectsStartDates[selectedStartDayIndex - 1]);
      tags.clear();
      await Future.forEach(
          listOfSubjects, (Subject element) => tags.addAll(element.tags));
      tagChipsSelect = List.generate(tags.length, (index) => index).toSet();
    }
  }
}
