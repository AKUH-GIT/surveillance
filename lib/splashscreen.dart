import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebaseservices/SplashServices.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splashscreen> {
  SplashServices _splashServivce = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashServivce.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text('Hacoline Surveillance v1.0',
                style: TextStyle(fontSize: 30))));
  }
}
