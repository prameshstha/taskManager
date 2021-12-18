import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:to_do_app/components/constant.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/models/database_helper.dart';
import 'package:to_do_app/models/local_notification.dart';
import 'package:to_do_app/models/task.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:to_do_app/screen/addtask/components/container/select_date_widget.dart';
import 'package:to_do_app/screen/addtask/components/container/select_priority.dart';
import 'package:to_do_app/screen/addtask/components/container/select_time_widget.dart';
import 'package:to_do_app/screen/home_screen/home_screen.dart'; //for Dateformat

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void initializeSetting() async {
  var initializeAndroid = AndroidInitializationSettings('tech');
  var iOSinitializeSetting = IOSInitializationSettings();
  var initializeSetting = InitializationSettings(
      android: initializeAndroid, iOS: iOSinitializeSetting);

  await flutterLocalNotificationsPlugin.initialize(initializeSetting,
      onSelectNotification: notificatationSelected);
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

// String tasknameController = '';
bool remindMe = true;
int? selectedId;
String datess = '';
String done = 'no';
String times = '';
TextEditingController txtTaskController = TextEditingController();

class _BodyState extends State<Body> {
  @override
  void initState() {
    initializeSetting();
    tz.initializeTimeZones();

    super.initState();
  }

  // TODO: dispose
  @override
  void dispose() {
    txtTaskController.clear();
    times = '';
    datess = '';
    selectedPriorityValue = '';
    super.dispose();
  }

  DateTime dateTime = DateTime.now();
  DateFormat Dateformatter = DateFormat('dd-MMM-yyyy');
  DateFormat timeFormater = DateFormat('h:mm');
  DateFormat dateTimeFormatter = DateFormat('dd-MMM-yyyy h:mm');
  // Pass this method to the child page.

  var selectedPriorityValue = 'Priority';

//selection of time, date priority => setstate
  void _dateSelect(String date) {
    setState(() => datess = date);
  }

  void _timeSelect(String time) {
    setState(() => times = time);
  }

  void _prioritySelect(String selectedPriority) {
    setState(() => selectedPriorityValue = selectedPriority);
  }

  // TimeOfDayFormat timeOfDayFormat = TimeOfDayFormat()
  DatabaseHelper _databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
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
                  'Add Task',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      height: 1.2,
                      color: Colors.grey[80]),
                ),
                //container for task lists

                TextFormField(
                    controller: txtTaskController,
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
                //container for date selection widget

                SelectDateWidget(dateSelect: _dateSelect, datess: datess),

                SizedBox(
                  height: size.height * 0.02,
                ),
                //container for timing tray 2
                SelectTimeWidget(timeSelect: _timeSelect, time: times),

                SizedBox(
                  height: size.height * 0.03,
                ),
                //container for priority
                SelectPriorityWidget(
                    prioritySelect: _prioritySelect,
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
                        if ( //txtTaskController.text == '' ||
                            datess == '' ||
                                times == '' ||
                                selectedPriorityValue == 'Priority') {
                          _showDialog(
                              taskname: txtTaskController,
                              date: datess,
                              time: times,
                              priority: selectedPriorityValue);
                        } else {
                          var amPm = times.substring(times.length - 2);
                          String dt = datess + " " + times;
                          print(dt);
                          DateTime dt1 = dateTimeFormatter.parse(dt);
                          print('$dt1 datetimee');

                          print('$dt1 and ${DateTime.now()}');
                          print(DateTime.now()
                              .difference(dt1)
                              .inMinutes); //because time converting am pm cause 12 hours differences

                          if (DateTime.now().difference(dt1).inMinutes < 720) {
                            //the alarm time set is in utc time but the timezone is local time
                            try {
                              int? notificationId =
                                  await _databaseHelper.insertTask(Tasks(
                                      taskName: txtTaskController.text,
                                      dueDate: datess,
                                      time: times,
                                      priority: selectedPriorityValue,
                                      alarm: remindMe ? 1 : 0,
                                      done: done));
                              print(notificationId);

                              if (remindMe = true && done == 'no') {
                                displayNotification(
                                    dt1,
                                    notificationId,
                                    txtTaskController.text,
                                    datess,
                                    times,
                                    amPm);
                              }
                              txtTaskController.clear();
                              times = '';
                              datess = '';
                              selectedPriorityValue = '';

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
}

Future<void> displayNotification(DateTime dateTime, int? notificationId,
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
