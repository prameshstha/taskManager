import 'package:flutter/material.dart';

class PriorityContainer extends StatelessWidget {
  const PriorityContainer({
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
            Icons.priority_high_rounded,
            color: Colors.redAccent,
          ),
        ),
        //for spacing
        SizedBox(
          width: 24,
        ),

        //for text
        Text(
          'Priority',
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
