import 'package:todo/data/models/subject.dart';
import 'package:todo/data/base/subjectBase.dart';

class SubjectVM implements SubjectBase {
  Set<int> tagChipsSelect = <int>{};
  Set<String> tags = <String>{};
  List<Subject> listOfSubjects = <Subject>[];

  @override
  Future<void> addSubject(Subject value) async {
    await Future.delayed(Duration(seconds: 2));
    print("added subject " + value.toString());
    listOfSubjects.add(value);
    tagChipsSelect = List.generate(tags.length, (index) => index).toSet();
    tags.addAll(value.tags);
  }

  @override
  void deleteSubject(Subject value) {
    //Check is Subject in list?
    if (listOfSubjects.contains(value)) {
      listOfSubjects.removeAt(listOfSubjects.indexOf(value));
    }
  }

  @override
  void deleteSubjectByIndex(int index) {
    //Check index is acceptable
    if (index >= 0 && index <= listOfSubjects.length - 1) {
      listOfSubjects.removeAt(index);
    }
  }

  @override
  void updateSubject(Subject updatedSubject, int indexToReplace) {
    listOfSubjects[indexToReplace] = updatedSubject;
  }
}
