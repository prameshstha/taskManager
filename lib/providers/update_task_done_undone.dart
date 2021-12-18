import 'package:flutter/material.dart';

class UpdateTaskDone with ChangeNotifier {
  String _done = '';
  int _id = 0;
  String get donee => _done;
  int get iid => _id;
  void changeTaskDoneUndone(String done, int id) {
    _done = done;
    _id = id;
    print('done $done');

    notifyListeners();
  }
}
