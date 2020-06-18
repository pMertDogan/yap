import 'package:flutter_map/flutter_map.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/state/subjectVM.dart';

class DetailVM {
  Subject subject;
  MapController mapController = MapController();

  Future<void> updateFavoriteStatus() async {
    /*
    subjectToChange and subject variables has same referance(SAME OBJECT)!
    If we change favorite status after = !subject.favorite and send it to 
    RM its send  !!favorite status so its not change anythink
    */
    await RM
        .get<SubjectVM>()
        .setState((s) async => await s.updateFavoriteStatus(subject));
    subject.favorite = !subject.favorite;
  }

  Future<void> updateToDoStatus(int index) async {
    subject.toDoList[index].completed = !subject.toDoList[index].completed;
    print(subject.toDoList[index].id.toString() + " todo ID ");
    await RM.get<SubjectVM>().setState((s) async => await s.updateToDoStatus(
        subject.toDoList[index].id, !subject.toDoList[index].completed));
  }

  Future<void> updateSubjectTags(Set<String> tags) async {
    await RM
        .get<SubjectVM>()
        .setState((s) async => await s.updateSubjectTags(subject.id, tags));
    subject.tags = tags;
  }

  Future<void> updateSubjectContributors(
      List<Friend> updatedContributors) async {
    await RM.get<SubjectVM>().setState((s) async =>
        await s.updateSubjectContributors(updatedContributors, subject.id));
    subject.contributors = updatedContributors;
  }
}
