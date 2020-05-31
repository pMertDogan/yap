import 'package:todo/data/models/subject.dart';

abstract class SubjectBase {
  Future<void> addSubject(Subject value);
  Future<void> deleteSubject(Subject value);
  Future<void> deleteSubjectByIndex(int index);
  Future<void> updateSubject(Subject updatedSubject, int indexToReplace);
  Future<void> syncData();
}
