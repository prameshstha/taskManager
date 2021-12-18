import 'package:flutter/material.dart';
import 'package:to_do_app/components/constant.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: Colors.blue[50],
        height: size.height,
        width: double.infinity,
        child: Stack(children: <Widget>[
          child,
        ]));
  }
}
