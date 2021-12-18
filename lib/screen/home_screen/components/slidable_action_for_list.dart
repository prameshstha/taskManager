import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/components/all_methods_functions.dart';
import 'package:to_do_app/models/database_helper.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/screen/EditScreen/edit_task_screen.dart';
import 'package:to_do_app/screen/addtask/add_task_screen.dart';
import 'package:to_do_app/screen/addtask/components/body.dart';
import 'package:to_do_app/screen/home_screen/components/task_list_inside_slidable.dart';
import 'package:to_do_app/screen/home_screen/home_screen.dart';

class ListViewWidgetForTasks extends StatefulWidget {
  final String taskName;
  final String dueDate;
  final String time;
  final String priority;
  final int alarm;
  final String done;
  final int id;
  final int selectedIndex;

  const ListViewWidgetForTasks({
    Key? key,
    required this.taskName,
    required this.dueDate,
    required this.time,
    required this.priority,
    required this.alarm,
    required this.done,
    required this.id,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<ListViewWidgetForTasks> createState() => _ListViewWidgetForTasksState();
}

String done1 = '';
String updatedDone = '';
int dismissId = 0;

class _ListViewWidgetForTasksState extends State<ListViewWidgetForTasks> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DatabaseHelper _databaseHelper = DatabaseHelper();
    done1 = updatedDone == '' ? widget.done : done1;
    return GestureDetector(
      onTap: () {
        editTask(context,
            taskName: widget.taskName,
            date: widget.dueDate,
            time: widget.time,
            priority: widget.priority,
            alarm: widget.alarm,
            done: done,
            selectedId: widget.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: EdgeInsets.all(10),

          //task list starts here
          child: TaskListInsideSlidableAction(
            taskName: widget.taskName,
            dueDate: widget.dueDate,
            time: widget.time,
            priority: widget.priority,
            alarm: widget.alarm,
            done: updatedDone == '' ? widget.done : done1,
            id: widget.id,
          ),
          //task list ends here
        ),
      ),
    );
  }
}
