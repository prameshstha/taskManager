import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectEditTimeWidget extends StatelessWidget {
  final ValueChanged<String> timeSelect;
  const SelectEditTimeWidget({
    Key? key,
    required this.time,
    required this.updateTime,
    required this.timeSelect,
  }) : super(key: key);

  final String time;
  final String updateTime;

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
            time.isEmpty
                ? 'Select Time'
                : updateTime != ''
                    ? updateTime
                    : time,
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

  void selectTime(BuildContext context, {TextEditingController? txtcont}) {
    DateFormat timeFormater = DateFormat('h:mm');
    showTimePicker(
            initialEntryMode: TimePickerEntryMode.dial,
            context: context,
            initialTime: TimeOfDay.fromDateTime(
                (timeFormater.parse(time)))) //timeFormater.parse(widget.time))
        .then((selectedTime) {
      if (selectedTime != null) {
        // (selectedDate.year+selectedDate.month+selectedDate.day)
        var t = selectedTime.format(context).toString();
        timeSelect(t);
      }
    });
    ;
  }
}
