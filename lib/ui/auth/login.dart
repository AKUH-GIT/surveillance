import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surveillance/screening.dart';
import 'package:surveillance/widgets/RoundButton.dart';

import '../../utils/Utils.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<login> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  void login() {
    setState(() {
      loading = true;
    });

    auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage("Welcome: " + value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => screening()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text('Hacoline Surveillance v1.0'),
              backgroundColor: Colors.deepPurpleAccent,
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: const InputDecoration(
                                  hintText: 'Email',
                                  // helperText: 'Enter email for eg reda@aku.edu',
                                  prefixIcon: Icon(Icons.alternate_email)),
                              style: TextStyle(fontSize: 20),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.lock_open)),
                              style: TextStyle(fontSize: 20),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                }
                                return null;
                              },
                            ),
                          ],
                        )),
                    const SizedBox(height: 50),
                    RoundButton(
                      title: 'Login',
                      loading: false,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                    ),
                  ]),
            )));
  }
}
