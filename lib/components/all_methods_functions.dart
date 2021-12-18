import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/models/database_helper.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/screen/EditScreen/edit_task_screen.dart';
import 'package:to_do_app/providers/update_task_done_undone.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screen/home_screen/home_screen.dart';

DatabaseHelper _databaseHelper = DatabaseHelper();
taskDone(BuildContext context,
    {required int id,
    required DatabaseHelper dbHelper,
    required String dones}) async {
  try {
    await dbHelper.updateTaskDone(TaskDone(
        done: dones == 'yes'
            ? 'no'
            : dones == 'no'
                ? 'yes'
                : dones,
        id: id));
  } catch (error) {
    print(error);
  }
}

Future<bool> askUser(
    DismissDirection direction,
    BuildContext context,
    int? selectedId,
    DatabaseHelper databaseHelper,
    String done,
    String taskName,
    AsyncSnapshot<List<Tasks>> snapshot,
    int index,
    String indexOfPage) async {
  String action;
  if (direction == DismissDirection.startToEnd) {
    // This is an archive action
    action = done == 'yes' ? "Undone" : 'Done';
  } else {
    print('other');

    // This is a delete action
    action = "delete";
  }

  return await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: action == 'delete'
              ? Text("Are you sure you want to $action?")
              : action == 'Done'
                  ? Text("Are you sure you want to check this as $action?")
                  : Text("Are you sure you want to check this as $action?"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () async {
                // Dismiss the dialog and
                // also dismiss the swiped item
                if (action == 'delete') {
                  print(action);
                  try {
                    await databaseHelper.deleteTask(selectedId!);
                  } catch (error) {
                    print(error);
                  }
                  snapshot.data!.removeAt(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$taskName Deleted')));
                } else {
                  print(action);
                  try {
                    await databaseHelper.updateTaskDone(TaskDone(
                        done: done == 'yes'
                            ? 'no'
                            : done == 'no'
                                ? 'yes'
                                : done,
                        id: selectedId));
                    if (indexOfPage != 'body') {
                      snapshot.data!.removeAt(index);
                      return Navigator.of(context).pop(true);
                    }
                    //code for setstate to change the checkbox of done
                    //28/11/2021 10:15PM still need to work on this to refresh page
                    //while updating only database updated but remains old data on the page

                    context.read<UpdateTaskDone>().changeTaskDoneUndone(
                        done == 'yes' ? 'no' : 'yes', selectedId!);

                    return Navigator.of(context).pop(false);
                  } catch (error) {
                    print(error);
                  }
                }

                return Navigator.of(context).pop(true);
              },
            ),
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                // Dismiss the dialog but don't
                // dismiss the swiped item
                print('cancel');
                return Navigator.of(context).pop(false);
              },
            )
          ],
        ),
      ) ??
      false;
} // In case the user dismisses the dialog by clicking away from it

void editTask(BuildContext context,
    {required String taskName,
    required String date,
    required String time,
    required String priority,
    required int alarm,
    required String done,
    required int selectedId}) {
  print('$taskName is here with id  $selectedId');
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return EditTaskScreen(
        taskName: taskName,
        dueDate: date,
        time: time,
        priority: priority,
        alarm: alarm,
        done: done,
        id: selectedId);
  }));
}
