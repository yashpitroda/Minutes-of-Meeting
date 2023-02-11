import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../screens/agenda_details_screen/select_supplier_screen.dart';

class AddAgendaWidget extends StatefulWidget {
  static const routeName = '/AddAgendaWidget';

  @override
  State<AddAgendaWidget> createState() => _AddAgendaWidgetState();
}

class _AddAgendaWidgetState extends State<AddAgendaWidget> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController addmamberController = TextEditingController();

  bool _isgeneral = true;
  String _agendaName = '';
  String _agendaDiscription = '';
  // String _organizationName = '';
  String _vanueName = '';
  DateTime? _dateTimeWhenprojectCreated;
  List? selectedmember;
  List<String> selectedmemberEmailList = [];
  @override
  void initState() {
    // TODO: implement initState
    DateTime currentDate = DateTime.now();
    finaldateTime = currentDate;
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     print(doc["username"]);
    //   });
    // });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime? _selectedDate;
  TimeOfDay? _selectedtime;
  DateTime? finaldateTime;
  void customDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            // firstDate: DateTime(2019),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101)
            // lastDate: DateTime.now()
            )
        .then((pickdedDate) {
      if (pickdedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickdedDate;
        final day = _selectedDate!.day;
        final mounth = _selectedDate!.month;
        final year = _selectedDate!.year;
        finaldateTime = DateTime(
            year, mounth, day, finaldateTime!.hour, finaldateTime!.minute);
      });
    });
  }

  void customTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((pickedtime) {
      if (pickedtime == null) {
        return;
      }
      setState(() {
        _selectedtime = pickedtime;
        final hourr = _selectedtime!.hour;
        final minitt = _selectedtime!.minute;
        finaldateTime = DateTime(finaldateTime!.year, finaldateTime!.month,
            finaldateTime!.day, hourr, minitt);
      });
    });
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
      await FirebaseFirestore.instance.collection('agenda').add({
        'agendaname': _agendaName,
        'agendaDiscription': _agendaDiscription,
        // 'organizationName': _organizationName,
        "memberlist": selectedmember,
        'venue': _vanueName,
        'agendacreationdate': Timestamp.now(),
        'agendacreateby': userdocData['username'],
        'useridWhoprojectCreated': userdocData['useridbyfirebase'],
      });
      final Email email = Email(
        body: 'meeting: ${_agendaName}\nvanue:${_vanueName}',
        subject: 'meeting invitation',
        recipients: selectedmemberEmailList,
        // cc: ['cc@example.com'],
        // bcc: ['bcc@example.com'],
        // cc: [''],
        // bcc: [''],
        // attachmentPaths: ['/path/to/attachment.zip'],
        // attachmentPaths: [''],
        isHTML: false,
      );

      String platformResponse;

      try {
        await FlutterEmailSender.send(email);
        platformResponse = 'success';
      } catch (error) {
        print(error);
        platformResponse = error.toString();
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(platformResponse),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  void _gotoSelectselectmamber() {
    Navigator.of(context)
        .pushNamed(SelectSupplierScreen.routeName)
        .then((value) {
      selectedmember = value as List?;
      if (selectedmember != null) {
        selectedmemberEmailList = [];
        selectedmember!.forEach((element) {
          selectedmemberEmailList.add(element["emailid"]);
        });
        print(selectedmemberEmailList);
        setState(() {});
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryhelp = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("add new meeting"),
      ),
      body: SingleChildScrollView(
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
                        DateTimeSelector(),
                        billWithOrWithoutOption(),
                        TextField(
                          readOnly: true,
                          onTap: () {
                            _gotoSelectselectmamber();
                          },
                          controller: addmamberController,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              // letterSpacing: 1,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                          decoration: const InputDecoration(
                            suffixIcon:
                                Icon(Icons.arrow_right), //icon at tail of input
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            // labelText: "client",
                            labelText: "Firm Name",
                            labelStyle:
                                TextStyle(letterSpacing: 1, fontSize: 14),
                            hintStyle: TextStyle(fontSize: 13),

                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        if (selectedmember != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            // height: 26,
                            // width: 170,
                            decoration: BoxDecoration(
                                // border: Border.all(
                                //     width: 1,
                                //     color: Colors.black45),
                                color: Colors.grey.withOpacity(0.075),
                                borderRadius: BorderRadius.circular(6)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Selected member",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: selectedmember!.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            selectedmember![index]["username"],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        TextFormField(
                          key: ValueKey('agendaNameKey'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'fill the box';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration:
                              InputDecoration(labelText: 'Meeting name'),
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
                          decoration: InputDecoration(labelText: 'vanue'),
                          onSaved: (newValue) {
                            _vanueName = newValue!;
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
      ),
    );
  }

  Row DateTimeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: customDatePicker,
          child: Row(
            children: [
              Icon(Icons.calendar_today_rounded),
              SizedBox(
                width: 6,
              ),
              Text(finaldateTime.toString().split(' ')[0]),
              const Icon(
                Icons.arrow_drop_down,
                size: 26,
              )
            ],
          ),
        ),
        InkWell(
          onTap: customTimePicker,
          child: Row(
            children: [
              const Icon(Icons.alarm),
              SizedBox(
                width: 7,
              ),
              Text(finaldateTime.toString().split(' ')[1].split('.')[0]),
              const Icon(
                Icons.arrow_drop_down,
                size: 26,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row billWithOrWithoutOption() {
    return Row(
      children: [
        ChoiceChip(
          backgroundColor: const Color.fromARGB(255, 192, 200, 216),
          selectedColor: const Color.fromARGB(255, 104, 167, 255),
          label: const Text('GENERAL'),
          selected: _isgeneral,
          onSelected: (bool selected) {
            setState(() {
              // _isBillValue = selected ? 1 : null;
              _isgeneral = true;
              print(_isgeneral);
              // doEmptyController();
              // Utility.removeFocus(context: context);
            });
          },
        ),
        SizedBox(
          width: 7,
        ),
        ChoiceChip(
          backgroundColor: const Color.fromARGB(255, 192, 200, 216),
          selectedColor: const Color.fromARGB(255, 104, 167, 255),
          label: const Text('DEPARTMENT'),
          selected: !_isgeneral,
          onSelected: (bool selected) {
            setState(() {
              // _isBillValue = selected ? 0 : null;
              _isgeneral = false;
              print(_isgeneral);
              // doEmptyController();
              // Utility.removeFocus(context: context);
            });
          },
        ),
      ],
    );
  }
}
