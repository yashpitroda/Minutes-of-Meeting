
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAgendaWidget extends StatefulWidget {
  @override
  State<AddAgendaWidget> createState() => _AddAgendaWidgetState();
}

class _AddAgendaWidgetState extends State<AddAgendaWidget> {
  final _formkey = GlobalKey<FormState>();

  String _agendaName = '';
  String _agendaDiscription = '';
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
      // FirebaseFirestore.instance.collection('projects').add({
      FirebaseFirestore.instance.collection('agenda').add({
        'agendaname': _agendaName,
        'agendaDiscription': _agendaDiscription,
        // 'organizationName': _organizationName,
        'departmentname': _departmentname,
        'agendacreationdate': Timestamp.now(),
        'agendacreateby':userdocData['username'],
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
                        key: ValueKey('agendaNameKey'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'fill the box';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Agenda name'),
                        onSaved: (newValue) {
                          _agendaName = newValue!;
                        },
                      ),
                      TextFormField(
                        key: ValueKey('agendaDiscriptionKey'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'fill the box';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration:
                            InputDecoration(labelText: 'agenda Discription'),
                        onSaved: (newValue) {
                          _agendaDiscription = newValue!;
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
