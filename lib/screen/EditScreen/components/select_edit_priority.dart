import 'package:flutter/material.dart';

class SelectPriorityWidget extends StatelessWidget {
  final ValueChanged<String> prioritySelect;
  final String updatePriorityValue;
  final String selectedPriorityValues;
  const SelectPriorityWidget({
    Key? key,
    required this.updatePriorityValue,
    required this.selectedPriorityValues,
    required this.prioritySelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //container for icon
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromRGBO(255, 240, 240, 1),
          ),
          padding: EdgeInsets.all(16),
          child: Icon(
            Icons.priority_high_rounded,
            color: Colors.redAccent,
          ),
        ),
        //for spacing
        SizedBox(
          width: 24,
        ),

        //for text
        DropdownButton(
          hint: Text('Select Priority'),
          value: updatePriorityValue != ''
              ? updatePriorityValue
              : selectedPriorityValues,
          items: ['Priority', 'High', 'Normal', 'Low'].map((selectedPriority) {
            return DropdownMenuItem<String>(
              child: Text(selectedPriority),
              value: selectedPriority,
            );
          }).toList(),
          onChanged: (newValue) {
            prioritySelect(newValue.toString());
          },
        ),
      ],
    );
  }
}
