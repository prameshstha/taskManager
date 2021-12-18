// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_app/components/constant.dart';
import 'package:to_do_app/screen/addtask/add_task_screen.dart';
import 'package:to_do_app/screen/home_screen/components/body.dart';
import 'package:to_do_app/screen/home_screen/components/completed_task_list.dart';
import 'package:to_do_app/screen/home_screen/components/not_completed_task.dart';
import 'package:to_do_app/screen/home_screen/components/overdue_task.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //screens for bottom navbar
  static int _selectedIndex = 0;
  String updatedDone = '';
  List navBar = [
    //main body of the task list
    Body(selectedIndex: _selectedIndex),
    //list of task done
    CompletedTask(),
    //list of task not done
    NotCompletedTask(),
    //list of overdue task
    OverDueTask(),
  ];
  _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'My Task List',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
        ),
        backgroundColor: kPrimaryLightColor,
      ),
      body: Center(
        child: navBar.elementAt(_selectedIndex),
      ),
      drawer: MyDrawer(),
      //bottom navigation bar start
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.blueGrey.shade300,
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey.shade300,
            icon: Icon(Icons.done),
            label: 'Done',
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.blueGrey.shade300,
              icon: Icon(Icons.do_not_disturb_outlined),
              label: 'Not Done'),
          BottomNavigationBarItem(
              backgroundColor: Colors.blueGrey.shade300,
              icon: Icon(Icons.task),
              label: 'Due'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
      //bottom navigation bar start

      //folating action button start
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddTaskScreen();
          }));
        },
        child: Icon(Icons.add),
      ),
      //folating action button end
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Task Menu'), accountEmail: Text('Sort tasks')),
          ListTile(
            title: Text('Sort'),
            subtitle: Text('by date accending'),
            leading: Icon(Icons.sort),
            onTap: () {
              print('sort acc');
            },
          ),
          ListTile(
            title: Text('Sort'),
            subtitle: Text('by date decending'),
            leading: Icon(Icons.sort),
            onTap: () {
              print('sort dec');
            },
          ),
          ListTile(
            title: Text('Alarm on'),
            subtitle: Text('sort by alarm on'),
            leading: Icon(Icons.alarm),
            onTap: () {
              print('sort alarm on');
            },
          ),
          ListTile(
            title: Text('Alarm off'),
            subtitle: Text('sort by alarm off'),
            leading: Icon(Icons.alarm_off),
            onTap: () {
              print('sort alarm off');
            },
          )
        ],
      ),
    );
  }
}
