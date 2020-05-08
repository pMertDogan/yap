import 'package:todo/models/subject.dart';
import 'package:todo/repo/subjectBase.dart';

class SubjectVM implements SubjectBase {
  Set<int> tagChipsSelect = <int>{};
  Set<String> tags = <String>{};
  List<Subject> listOfSubjects = <Subject>[];

  @override
  void addSubject(Subject value) {
    listOfSubjects.add(value);
    tagChipsSelect.add(listOfSubjects.length - 1);
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
