import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w500, color: Colors.grey[800]),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade100)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade200)),
          hintText: 'Task Name',
          hintStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.grey[500]),
        ));
  }
}
