import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProjectWidget extends StatefulWidget {
  @override
  State<AddProjectWidget> createState() => _AddProjectWidgetState();
}

class _AddProjectWidgetState extends State<AddProjectWidget> {
  final _formkey = GlobalKey<FormState>();

  String _projectName = '';
  String _projectDiscription = '';
  // String _organizationName = '';
  String _departmentname = '';
  DateTime? _dateTimeWhenprojectCreated;

  @override
  void dispose() {
    super.dispose();
  }

  // void _DatePicker() {
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime(2011),
  //           lastDate: DateTime.now().add(Duration(days: 15)))
  //       .then((pickdedDate) {
  //     if (pickdedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       _dateTimeWhenprojectCreated = pickdedDate;
  //     });
  //   });
  // }

  void _showErrorDialog(String masage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("an error occur"),
              content: Text(masage),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("okey"))
              ],
            ));
  }

  Future<void> _trySave() async {
    final isvalid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isvalid) {
      _formkey.currentState!.save();
      final currentUser = await FirebaseAuth.instance.currentUser;
      final userdocData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      FirebaseFirestore.instance.collection('projects').add({
        'projectname': _projectName,
        'projectDiscription': _projectDiscription,
        // 'organizationName': _organizationName,
        'departmentname': _departmentname,
        'projectcreationdate': Timestamp.now(),
        'projectcreateby':userdocData['username'],
        'useridWhoprojectCreated':userdocData['useridbyfirebase'],
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryhelp = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10 //for device keybord title and amount will show
              ),
          child: Container(
            child: Card(
                child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        key: ValueKey('projectNameKey'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'fill the box';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'project name'),
                        onSaved: (newValue) {
                          _projectName = newValue!;
                        },
                      ),
                      TextFormField(
                        key: ValueKey('projectDiscriptionKey'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'fill the box';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration:
                            InputDecoration(labelText: 'project Discription'),
                        onSaved: (newValue) {
                          _projectDiscription = newValue!;
                        },
                      ),
                     
                      TextFormField(
                        key: ValueKey('departmentnameKey'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'fill this box';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration:
                            InputDecoration(labelText: 'department name'),
                        onSaved: (newValue) {
                          _departmentname = newValue!;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      // Row(
                      //   children: [
                      //     Text(_dateTimeWhenprojectCreated == null
                      //         ? "No Date selected!"
                      //         : _dateTimeWhenprojectCreated!.toIso8601String()),
                      //     ElevatedButton(
                      //         onPressed: _DatePicker,
                      //         child: Text(
                      //           "Choose Date",
                      //           style: TextStyle(
                      //               color: Colors.purple,
                      //               fontWeight: FontWeight.w700),
                      //         )),
                      //   ],
                      // ),
                      ElevatedButton(
                        onPressed: _trySave,
                        child: Text("submit"),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
