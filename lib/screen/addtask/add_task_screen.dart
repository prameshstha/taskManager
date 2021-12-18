import 'package:flutter/material.dart';
import 'package:to_do_app/components/constant.dart';
import 'package:to_do_app/screen/addtask/components/body.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

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
              onTap: () => FocusScope.of(context).unfocus(), child: Body())),
    );
  }
}
