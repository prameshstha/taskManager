import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat timeFormater = DateFormat('h:mm');

class SelectTimeWidget extends StatelessWidget {
  final ValueChanged<String> timeSelect;
  final String time;
  const SelectTimeWidget({
    Key? key,
    required this.time,
    required this.timeSelect,
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
            Icons.alarm,
            color: Colors.orangeAccent,
          ),
        ),
        //for spacing
        SizedBox(
          width: 24,
        ),

        //for text

        TextButton(
          onPressed: () {
            selectTime(context);
          },
          child: Text(
            time.isEmpty ? 'Select Time' : time,
            style: TextStyle(
                fontSize: 18,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700]),
          ),
        )
      ],
    );
  }

  void selectTime(BuildContext context) {
    showTimePicker(
            initialEntryMode: TimePickerEntryMode.dial,
            context: context,
            initialTime: TimeOfDay.now())
        .then((selectedTime) {
      if (selectedTime != null) {
        var t = selectedTime.format(context).toString();
        print('$selectedTime  ' '  $t');
        timeSelect(t);
      }
    });
  }
}
