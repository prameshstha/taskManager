import 'package:flutter/material.dart';
import 'package:to_do_app/models/database_helper.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/screen/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/update_task_done_undone.dart';

class TaskListInsideSlidableAction extends StatelessWidget {
  final String taskName;
  final String dueDate;
  final String time;
  final String priority;
  final int alarm;
  final String done;
  final int id;
  const TaskListInsideSlidableAction({
    Key? key,
    required this.taskName,
    required this.dueDate,
    required this.time,
    required this.priority,
    required this.alarm,
    required this.done,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _databaseHelper = DatabaseHelper();
    String donee = context.watch<UpdateTaskDone>().donee;
    int iid = context.watch<UpdateTaskDone>().iid;

    Size size = MediaQuery.of(context).size;
    Color high = Colors.red;
    Color normal = Colors.amber;
    Color low = Colors.blue;
    return Container(
      width: size.width,
      child: Row(
        children: [
          //priority bar start
          Column(
            children: [
              Container(
                width: 10,
                height: 60,
                decoration: BoxDecoration(
                  color: priority == 'High'
                      ? high
                      : priority == 'Normal'
                          ? normal
                          : priority == 'Low'
                              ? low
                              : null,
                ),
              ),
            ],
          ),
          //priority bar end
          SizedBox(
            width: size.width * 0.02,
          ),
          //column for Task details start
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //container for task name start
              Container(
                width: size.width * 0.60,
                child: Row(
                  children: [
                    Text(
                      taskName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              //container for task name end
              SizedBox(
                height: 5,
              ),
              //Row for task date and time start
              Row(
                children: [
                  //container for task date only - start
                  Container(width: size.width * 0.40, child: Text(dueDate)),
                  //container for task date only - end
                  Icon(
                    Icons.safety_divider_sharp,
                    size: size.height * 0.03,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  // align -> container for task time only - start
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        Container(
                            width: size.width * 0.15,
                            child: Text(
                              time,
                              textAlign: TextAlign.right,
                            )),
                      ],
                    ),
                  ),
                  // align -> container for task time only - start
                ],
              ),
              //Row for task date and time end
            ],
          ),
          //column for Task details end
          SizedBox(
            width: size.width * 0.02,
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.alarm,
                  color: alarm == 1 ? Colors.blue : Colors.grey,
                ),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              DoneCheckWidget(
                done: done,
                id: id,
                iid: iid,
                donee: donee,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DoneCheckWidget extends StatefulWidget {
  final int id;
  final int iid;

  final String done;
  final String donee;
  const DoneCheckWidget({
    Key? key,
    required this.done,
    required this.id,
    required this.iid,
    required this.donee,
  }) : super(key: key);

  @override
  State<DoneCheckWidget> createState() => _DoneCheckWidgetState();
}

class _DoneCheckWidgetState extends State<DoneCheckWidget> {
  @override
  Widget build(BuildContext context) {
    int ids = widget.id;
    int iids = widget.iid;
    String donees = widget.donee;
    String updateDone = ids == iids ? donees : widget.done;
    return Container(
      width: 30,
      height: 30,
      child: updateDone == 'no'
          ? null
          : Container(
              decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  border: Border.all(color: Colors.blueGrey.shade200),
                  borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                'assets/images/check_icon.png',
                width: 30,
                height: 30,
              ),
            ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey.shade200),
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
