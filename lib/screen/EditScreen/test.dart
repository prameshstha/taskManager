// import 'package:flutter/material.dart';

// DropdownButton(
//                         hint: Text('Select Priority'),
//                         value: updatePriority != ''
//                             ? updatePriority
//                             : selectedPriorityValue,
//                         items: ['Priority', 'High', 'Normal', 'Low']
//                             .map((selectedPriority) {
//                           return DropdownMenuItem<String>(
//                             child: Text(selectedPriority),
//                             value: selectedPriority,
//                           );
//                         }).toList(),
//                         onChanged: (newValue) {
//                           setState(() {
//                             selectedPriorityValue = newValue.toString();
//                             tasknameController = txtTaskController.text;
//                             updatePriority = newValue.toString();
//                           });
//                         },
//                       ),