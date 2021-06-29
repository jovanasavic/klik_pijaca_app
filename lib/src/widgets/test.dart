import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

bool toggle = false;

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: toggle
          ? new Image.asset('images/heartt.png')
          : new Image.asset('images/like2.png'),
      onPressed: () async {
        setState(() {
          // Here we changing the icon.
          toggle = !toggle;
        });
      },
    );
  }
}
