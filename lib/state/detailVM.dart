import 'package:flutter_map/flutter_map.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/state/subjectVM.dart';

class DetailVM {
  Subject subject;
  MapController mapController = MapController();
  final ReactiveModel<SubjectVM> subjectVM = RM.get<SubjectVM>();

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
    ToDo todo = subject.toDoList[index];
    todo.completed = !todo.completed;

    print("UpdateTodoStatus todo ID " + todo.id.toString());

    await RM.get<SubjectVM>().setState(
        (s) async => await s.updateToDoStatus(todo.id, !todo.completed));
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

  Future<void> addToDo(ToDo toDo) async {
    //
    toDo.completed = false;
    await subjectVM.setState((s) async {
      return toDo.id = await s.addToDoToSubject(toDo, subject.id);
    });
    //print("addTodo ID " + toDo.id.toString());
    subject.toDoList.add(toDo);
  }

  Future<void> removeTodoById(int todoID) async {
    print("remove todo ıd " + todoID.toString());
    await subjectVM.setState((s) => s.deleteToDoById(todoID));
    subject.toDoList.removeWhere((element) => element.id == todoID);
  }
}
