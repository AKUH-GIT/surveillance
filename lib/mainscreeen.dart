import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({Key? key}) : super(key: key);

  @override
  State<mainscreen> createState() => _mainscreenstate();
}

class _mainscreenstate extends State<mainscreen> {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: AppBar(
        title: Text("Hacoline Surveillance v1.0"),
      ),
    );
  }
}
