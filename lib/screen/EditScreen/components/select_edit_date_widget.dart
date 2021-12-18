import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/components/constant.dart';

class SelectEditDateWidget extends StatelessWidget {
  final ValueChanged<String> dateSelect;
  const SelectEditDateWidget({
    Key? key,
    required this.datess,
    required this.updateDate,
    required this.dateSelect,
  }) : super(key: key);

  final String datess;
  final String updateDate;

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
            Icons.calendar_today,
            color: Colors.redAccent,
          ),
        ),
        //for spacing
        SizedBox(
          width: 24,
        ),

        //for text
        TextButton(
            onPressed: () {
              selectDate(context);
            },
            child: Text(
                datess.isEmpty
                    ? 'Select Date'
                    : updateDate != ''
                        ? updateDate
                        : datess,
                style: TextStyle(
                    fontSize: 18,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700]))),
      ],
    );
  }

  void selectDate(BuildContext context, {TextEditingController? txtcont}) {
    DateFormat Dateformatter = DateFormat('dd-MMM-yyyy');
    showDatePicker(
        context: context,
        initialDate: Dateformatter.parse(datess),
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2030, 12),
        builder: (context, picker) {
          return Theme(
            //TODO: change colors
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: kPrimaryColor,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: picker!,
          );
        }).then((selectedDate) {
      if (selectedDate != null) {
        // (selectedDate.year+selectedDate.month+selectedDate.day)
        var d = Dateformatter.format(selectedDate);

        dateSelect(d);
      }
    });
  }
}
