import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/dbHelper.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/data/base/subjectBase.dart';
import 'package:todo/state/userVM.dart';

class SubjectVM implements SubjectBase {
  Set<int> tagChipsSelect = <int>{};
  Set<String> tags = <String>{};
  List<Subject> listOfSubjects = <Subject>[];

  final DatabaseHelper databaseHelper;

  SubjectVM(this.databaseHelper);

  @override
  Future<void> addSubject(Subject value) async {
    await Future.delayed(Duration(seconds: 2));
    //save to sqflite
    await databaseHelper.addSubject(value);
    print("subject added to local sql Table");
    await getAllSubjects();
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

  @override
  Future<void> getAllSubjects() async {
    listOfSubjects = await databaseHelper.getAllSubjects() ?? <Subject>[];
    tags = await databaseHelper.getAllTags() ?? <String>{};
    tagChipsSelect = List.generate(tags.length, (index) => index).toSet();
    print("subjectVM getAll subjects length: " +
        listOfSubjects.length.toString());
  }
}
