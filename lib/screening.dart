import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveillance/ui/auth/login.dart';
import 'package:surveillance/utils/Utils.dart';
import 'package:surveillance/widgets/RoundButton.dart';

class screening extends StatefulWidget {
  const screening({Key? key}) : super(key: key);

  @override
  State<screening> createState() => screeningstate();
}

class screeningstate extends State<screening> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final FullName = TextEditingController();
  final VRID = TextEditingController();
  final MedidataScreeningID = TextEditingController();
  final Age = TextEditingController();
  final CompleteAddress = TextEditingController();
  final PhoneNumber = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void saveData() {
    var tbl_baseline = FirebaseFirestore.instance.collection("Baseline");

    tbl_baseline
        .add({
      "FullName": FullName.text,
      "VRID": VRID.text,
      "MedidataScreeningID": MedidataScreeningID.text,
      "Age": Age.text,
      "CompleteAddress": CompleteAddress.text,
      "PhoneNumber": PhoneNumber.text,
    })
        .then((value) {})
        .onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });

    Utils().toastMessage('Baseline successfully saved');
    setState(() {
      loading = false;
    });
    clearFields();
  }

  clearFields() {
    _formKey.currentState!.reset();
    FullName.text = "";
    VRID.text = "";
    MedidataScreeningID.text = "";
    Age.text = "";
    CompleteAddress.text = "";
    PhoneNumber.text = "";
  }

  logOut() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hacoline Surveillance v1.0'),
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                TextFormField(
                  controller: FullName,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please enter full woman name";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Full Name",
                      labelText: "Full Name",
                      labelStyle: const TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                TextFormField(
                  controller: Age,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please enter age (years)";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Age (Years)",
                    labelText: "Age (Years)",
                    labelStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                TextFormField(
                  controller: VRID,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please enter VRID";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: "VRID",
                    labelText: "VRID",
                    labelStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                TextFormField(
                  controller: MedidataScreeningID,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please enter Medidata Screening ID";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Medidata Screening ID",
                    hintText: "Medidata Screening ID",
                    labelStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                TextFormField(
                  controller: CompleteAddress,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please enter complete address";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Complete Address",
                    labelText: "Complete Address",
                    labelStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Phone Number required";
                    else
                      return null;
                  },
                  controller: PhoneNumber,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    labelText: "Phone Number",
                    labelStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                RoundButton(
                  loading: loading,
                  title: "Save Data",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      saveData();
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                RoundButton(
                  title: "Logout",
                  onTap: () {
                    logOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
