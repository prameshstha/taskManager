import 'package:flutter/material.dart';

class RemainderContainer extends StatefulWidget {
  const RemainderContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<RemainderContainer> createState() => _RemainderContainerState();
}

class _RemainderContainerState extends State<RemainderContainer> {
  @override
  Widget build(BuildContext context) {
    bool remindMe = true;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          //container for icon
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromRGBO(240, 235, 255, 1),
            ),
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.alarm_on,
              color: Colors.purpleAccent[100],
            ),
          ), //for spacing
          SizedBox(
            width: 24,
          ),

          //for text
          Text(
            'Remind Me',
            style: TextStyle(
                fontSize: 18,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700]),
          ),
          Spacer(),
          Switch(
              value: true,
              onChanged: (value) {
                setState(() {
                  print(value);

                  remindMe = value;
                  print(value);
                  print(remindMe);
                });
              })
        ],
      ),
    );
  }
}
