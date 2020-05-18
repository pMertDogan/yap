import 'package:todo/data/models/todo.dart';

class ToDoVM {
  List<ToDo> _toDoList = <ToDo>[];

  List<ToDo> get toDoList => _toDoList;

  set toDoList(List<ToDo> value) {
    _toDoList = value;
  }

  void addNewToDo(ToDo newToDo) {
    toDoList.add(newToDo);
  }
}
