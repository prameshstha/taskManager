import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/components/constant.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/models/database_helper.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/screen/EditScreen/components/select_edit_date_widget.dart';
import 'package:to_do_app/screen/EditScreen/components/select_edit_priority.dart';
import 'package:to_do_app/screen/EditScreen/components/select_edit_time_widget.dart';
import 'package:to_do_app/screen/addtask/components/body.dart';
import 'package:to_do_app/screen/home_screen/home_screen.dart'; //for Dateformat

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Body extends StatefulWidget {
  final String taskName;
  final String dueDate;
  final String time;
  final String priority;
  final int alarm;
  final String done;
  final int id;
  const Body(
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
  State<Body> createState() => _BodyState();
}

TextEditingController txtTaskController = TextEditingController();

class _BodyState extends State<Body> {
  @override
  void dispose() {
    txtTaskController.clear();
    times = '';
    datess = '';
    selectedPriorityValue = '';
    super.dispose();
  }

  bool remindMe = true;
  String datess = '';
  String selectedPriorityValue = 'Priority';
  String time = '';
  String done = '';
  DateTime dateTime = DateTime.now();
  DateFormat Dateformatter = DateFormat('dd-MMM-yyyy');
  DateFormat timeFormater = DateFormat('h:mm');
  String updatePriority = '';
  String updateDate = '';
  String updateTime = '';
  bool updateRemindMe = true;
  String updateDone = '';
  String updatePage = '';

  // TimeOfDayFormat timeOfDayFormat = TimeOfDayFormat()
  DatabaseHelper _databaseHelper = DatabaseHelper();

  DateFormat dateTimeFormatter = DateFormat('dd-MMM-yyyy HH:mm');

  //Passthis method to the child page(dateselect)
  //  selection of time data and priority => setstete
  void _dateSelect(String date) {
    setState(() => updateDate = date);
  }

  void _timeSelect(String time) {
    setState(() => updateTime = time);
  }

  void _prioritySelect(String priorityVal) {
    setState(() {
      updatePriority = priorityVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    datess = widget.dueDate;
    time = widget.time;
    selectedPriorityValue = widget.priority;
    remindMe = updatePage == '' ? (widget.alarm == 1 ? true : false) : remindMe;
    done = widget.done;
    int selectedId = widget.id;
    Size size = MediaQuery.of(context).size;
    return Container(
        color: kPrimaryLightColor,
        height: size.height,
        width: double.infinity,
        child: Column(children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ignore: prefer_const_constructors

                Text(
                  'Edit Task',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      height: 1.2,
                      color: Colors.grey[80]),
                ),
                //container for task lists

                TextField(
                    controller: txtTaskController..text = widget.taskName,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade100)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade200)),
                      hintText: 'Task Name',
                      hintStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[500]),
                    )),
                SizedBox(
                  height: size.height * 0.02,
                ),
                //container for timing tray Date

                SelectEditDateWidget(
                    dateSelect: _dateSelect,
                    datess: datess,
                    updateDate: updateDate),

                SizedBox(
                  height: size.height * 0.02,
                ),
                //container for timing tray time
                SelectEditTimeWidget(
                    timeSelect: _timeSelect,
                    time: time,
                    updateTime: updateTime),
                SizedBox(
                  height: size.height * 0.03,
                ),
                //container for priority
                SelectPriorityWidget(
                    prioritySelect: _prioritySelect,
                    updatePriorityValue: updatePriority,
                    selectedPriorityValues: selectedPriorityValue),
                SizedBox(
                  height: size.height * 0.03,
                ),
                //container for task remainder
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      //container for icon
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(240, 235, 255, 1),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          Icons.alarm_on,
                          color: Colors.purpleAccent[100],
                        ),
                      ), //for spacing
                      SizedBox(
                        width: 24,
                      ),

                      //for text
                      Text(
                        'Remind Me',
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[700]),
                      ),
                      const Spacer(),
                      Switch(
                          value: remindMe,
                          onChanged: (value) {
                            setState(() {
                              remindMe = value;
                              updateRemindMe = value;
                              updatePage = 'update';
                            });
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                //button for create Task
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 0),
                      ),
                      child: const Text(
                        'Save Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      onPressed: () async {
                        if (txtTaskController.text == '' ||
                            datess == '' ||
                            time == '' ||
                            selectedPriorityValue == 'Priority') {
                          _showDialog(
                              taskname: txtTaskController,
                              date: datess,
                              time: time,
                              priority: selectedPriorityValue);
                        } else {
                          // selectedId!=null?
                          //inserting into database

                          if (updateDate == '') {
                            updateDate = datess;
                          }
                          if (updateTime == '') {
                            updateTime = time;
                          }
                          if (updatePriority == '') {
                            updatePriority = selectedPriorityValue;
                          }

                          var amPm =
                              updateTime.substring(updateTime.length - 2);
                          print(amPm);
                          String dt = updateDate + " " + updateTime;
                          print(dt);
                          DateTime dt1 = dateTimeFormatter.parse(dt);
                          print('$dt1 datetimee');
                          print('$dt1 and ${DateTime.now()}');
                          print(DateTime.now()
                              .difference(dt1)
                              .inMinutes); //because time converting am pm cause 12 hours differences
                          if (DateTime.now().difference(dt1).inMinutes < 720) {
                            // the alarm time set is in utc time but the timezone is local time

                            try {
                              await _databaseHelper.updateTask(Tasks(
                                  taskName: txtTaskController.text,
                                  dueDate: updateDate,
                                  time: updateTime,
                                  priority: updatePriority,
                                  alarm: updateRemindMe ? 1 : 0,
                                  done: done,
                                  id: selectedId));

                              // var last2 = time.split(' ');
                              // print(last2[1]);

                              if (updateRemindMe = true && done == 'no') {
                                displayNotificationEdit(
                                    dt1,
                                    selectedId,
                                    txtTaskController.text,
                                    updateDate,
                                    updateTime,
                                    amPm);
                              } else if (updateRemindMe =
                                  false || done == 'yes') {
                                await flutterLocalNotificationsPlugin
                                    .cancel(selectedId);
                              }

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }));
                            } catch (error) {
                              print(error);
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: AlertDialog(
                                    title: Text(
                                      'Past Time',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                        'Please Select future date and time!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Go Back'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ]));
  }

  // user defined function
  void _showDialog(
      {String? date,
      String? priority,
      TextEditingController? taskname,
      String? time}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SingleChildScrollView(
          child: AlertDialog(
            title: new Text("Please fill all required field",
                style: TextStyle(fontWeight: FontWeight.bold)),

            // txtTaskController.text == '' ||
            //     datess == '' ||
            //     time == '' ||
            //     selectedPriorityValue == 'Priority'
            content: Container(
              height: 150,
              width: 100,
              child: ListView(
                children: [
                  Text(
                    taskname!.text == '' ? '*Enter Task Name' : '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(date == '' ? '*Select Date' : '',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(time == '' ? '*Select Time' : '',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(priority == 'Priority' ? '*Select Priority' : '',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new TextButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> displayNotificationEdit(DateTime dateTime, int? notificationId,
      String task, String datess, String time, String amPm) async {
    print(dateTime.toUtc());
    if (amPm == 'PM') {
      print(dateTime.add(Duration(hours: 12)));
      var notificationDateTime = dateTime.add(Duration(hours: 12));
    }

    // print('tz.local');
    // print(tz.TZDateTime.now(tz.local));
    print('datetime.now');
    print(DateTime.now());
    // print('difference');
    // print(dateTime.difference(tz.TZDateTime.now(tz.local)));
    // Duration duration = dateTime.difference(DateTime.now()).inDays;
    print('addition subs');
    // print(dateTime
    //     .add(Duration(hours: dateTime.difference(DateTime.now()).inHours)));
    //start
    flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId!,
        task,
        'You have a task due on $datess at $time.',
        tz.TZDateTime.from(
            amPm == 'PM' ? (dateTime.add(Duration(hours: 12))) : dateTime,
            tz.local),
        // tz.TZDateTime.from(dateTime, tz.local),

        NotificationDetails(
            android: AndroidNotificationDetails(
              'channel id',
              'channel name',
            ),
            iOS: IOSNotificationDetails()),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future notificatationSelected(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    runApp(
      MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
