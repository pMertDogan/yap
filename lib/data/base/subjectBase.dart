import 'package:todo/data/models/subject.dart';

abstract class SubjectBase {
  Future<void> addSubject(Subject value);
  Future<void> deleteSubject(Subject value);
  Future<void> deleteSubjectByID(int subjectID);
  Future<void> updateSubject(Subject updatedSubject, int indexToReplace);
  Future<void> getSelectedDayData({bool filterByTags});
}
