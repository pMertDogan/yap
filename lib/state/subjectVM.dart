import 'dart:io';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:jiffy/jiffy.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/models/friend.dart';
import 'package:todo/models/subject.dart';
import 'package:todo/models/user.dart';

class SubjectVM {
  List<Subject> _subjectList = <Subject>[];
  int _totalSubjectCount = 0;
  File _selectedImageFile;
  String _startDate;
  String _endDate;
  String _startTime;
  String _endTime;
  DateTime _endDateInitDate;
  DateTime _startDateLastDate;
  List<double> _latLngValues = <double>[];
  MapBoxPlace _mapBoxPlace;
  //List<Friend> _userFriendList;

  MapBoxPlace get mapBoxPlace => _mapBoxPlace;

  set mapBoxPlace(MapBoxPlace value) {
    _mapBoxPlace = value;
  }

  List<double> get latLngValues => _latLngValues;

  set latLngValues(List<double> value) {
    _latLngValues = value;
  }

  DateTime get startDateLastDate => _startDateLastDate;

  DateTime get endDateInitDate => _endDateInitDate;

  String get startDate => _startDate;

  set selectedImageFile(File value) {
    _selectedImageFile = value;
  }

  set startDate(String value) {
    _startDate = value;
    _endDateInitDate =
        (Jiffy(value, "dd/MM/yyyy").dateTime.add(Duration(hours: 1)))
            .subtract(Duration(days: 1));
  }

  List<Subject> get subjectList => _subjectList;

  int get totalSubjectCount => _totalSubjectCount;

  File get selectedImageFile => _selectedImageFile;

  get endDate => _endDate;

  set endDate(value) {
    _endDate = value;
    _startDateLastDate =
        (Jiffy(value, "dd/MM/yyyy").dateTime.add(Duration(hours: 1)))
            .subtract(Duration(days: 1));
  }

  get endTime => _endTime;

  set endTime(value) {
    _endTime = value;
  }

  get startTime => _startTime;

  set startTime(value) {
    _startTime = value;
  }

  void addNewSubject(Subject newSubject) {
    _subjectList.add(newSubject);
  }
}
