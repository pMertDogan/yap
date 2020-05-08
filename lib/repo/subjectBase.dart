import 'package:todo/models/subject.dart';

abstract class SubjectBase {
  void addSubject(Subject value);
  void deleteSubject(Subject value);
  void deleteSubjectByIndex(int index);
  void updateSubject(Subject updatedSubject, int indexToReplace);
}
