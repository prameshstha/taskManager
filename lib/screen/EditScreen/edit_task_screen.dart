import 'package:flutter/material.dart';
import 'package:to_do_app/components/constant.dart';
import 'package:to_do_app/screen/EditScreen/components/body.dart';

class EditTaskScreen extends StatelessWidget {
  String taskName;
  String dueDate;
  String time;
  String priority;
  int alarm;
  String done;
  int id;
  EditTaskScreen(
      {Key? key,
      required this.taskName,
      required this.dueDate,
      required this.time,
      required this.priority,
      required this.alarm,
      required this.done,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        backgroundColor: kPrimaryLightColor,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          // onTap: () {
          //   FocusScope.of(context).unfocus();
          // },
          child: Body(
              taskName: taskName,
              dueDate: dueDate,
              time: time,
              priority: priority,
              alarm: alarm,
              done: done,
              id: id),
        ),
      ),
    );
  }
}
