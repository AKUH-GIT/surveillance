import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class screening extends StatefulWidget {
  const screening({Key? key}) : super(key: key);

  @override
  State<screening> createState() => screeningstate();
}

class screeningstate extends State<screening> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: AppBar(
          title: Text("werwerwe"),
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
