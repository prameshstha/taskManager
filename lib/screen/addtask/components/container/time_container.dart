import 'package:flutter/material.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer({
    Key? key,
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
        Text(
          '1:00pm',
          style: TextStyle(
              fontSize: 18,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: Colors.grey[700]),
        )
      ],
    );
  }
}
