import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:minuteofmeeting/models/summary_proivder.dart';
import 'package:minuteofmeeting/utilly.dart';
import 'package:minuteofmeeting/widgets/message_widget.dart';
import 'package:minuteofmeeting/widgets/upload_icon_widget.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../widgets/remove_icon_widget.dart';

class TalksScreen extends StatefulWidget {
  const TalksScreen({super.key, required this.projectId});
  final String projectId;
  @override
  State<TalksScreen> createState() => _TalksScreenState();
}

class _TalksScreenState extends State<TalksScreen> {
  String? pid;

  Map<String, HighlightedWord> _highlights = {
    "Flutter": HighlightedWord(
      onTap: () {
        print("Flutter");
      },
      textStyle: TextStyle(
          fontSize: 30.0, color: Colors.blue, fontWeight: FontWeight.bold),
    ),
    "Task": HighlightedWord(
      onTap: () {
        print("Task");
      },
      textStyle: TextStyle(
          fontSize: 30.0, color: Colors.red, fontWeight: FontWeight.bold),
    ),
    "assignment": HighlightedWord(
      onTap: () {
        print("assignment");
      },
      textStyle: TextStyle(
          fontSize: 30.0, color: Colors.green, fontWeight: FontWeight.w400),
    ),
    "Dr Purvi Mam Ramanuj": HighlightedWord(
      onTap: () {
        print("Dr purvi mam ramanuj");
      },
      textStyle: TextStyle(
          fontSize: 30.0, color: Colors.pink, fontWeight: FontWeight.w400),
    ),
    "Doctor Purvi Mam Ramanuj": HighlightedWord(
      onTap: () {
        print("Dr purvi mam ramanuj");
      },
      textStyle: TextStyle(
          fontSize: 30.0, color: Colors.pink, fontWeight: FontWeight.w400),
    ),
    "Doctor Purvi Ramanuj": HighlightedWord(
      onTap: () {
        print("Dr purvi mam ramanuj");
      },
      textStyle: TextStyle(
          fontSize: 30.0, color: Colors.pink, fontWeight: FontWeight.w400),
    ),
    "Dr Purvi Mem Ramanuj": HighlightedWord(
      onTap: () {
        print("Dr purvi mam ramanuj");
      },
      textStyle: TextStyle(
          fontSize: 30.0, color: Colors.pink, fontWeight: FontWeight.w400),
    ),
  };
  stt.SpeechToText? _speech;
  bool _islistening = false;
  String _text = 'press btn to start speaking';
  // String _text =
  //     'press btn to start speakingpress btn to start speakingpress btn to start speakingpress btn to start speakingpress btn to start speakingpress btn to start speakingpress btn to start speakingpress btn to start speakingpress btn to start speakingpress btn to start speakingpress btn to start speakingpress btn to start speaking';
  double _confiance = 1.0;

  @override
  void initState() {
    super.initState();
    pid = widget.projectId;
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    print(_islistening);

    if (!_islistening) {
      bool availible = await _speech!.initialize(
        onStatus: (status) => print('onstatus:$status'),
        onError: (error) => print('onstatus:$error'),
      );
      if (availible) {
        setState(() {
          _islistening = true;
        });
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confiance = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() {
        _islistening = false;
      });
      _speech!.stop();
    }
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus(); //exit to keybord
    ans = Utill.removeSlangWords(
        // inputtext: "ANND BHODU BABUCHAK NICH HUMAN");
        inputtext: _text);
    final currentUser = await FirebaseAuth.instance.currentUser;
    final userdocData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    await FirebaseFirestore.instance.collection('agenda/$pid/chats').add({
      'text': ans,
      'createdAt': Timestamp.now(),
      'userId': currentUser.uid,
      'userName': userdocData['username'],
      'userImageUrl':
          'https://firebasestorage.googleapis.com/v0/b/minute-of-meeting-fdabc.appspot.com/o/download.jpeg?alt=media&token=9b56540f-29ad-4fcd-b546-66235c91ed5c',
    });
    _ontap();
  }

  void _ontap() async {
    String data__ = "";
    var a = "";
    print("object");
    await FirebaseFirestore.instance
        .collection('agenda/$pid/chats')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        a = a + doc["text"];
        data__ = a;
      });
    });
    await Provider.of<summaryProvider>(context, listen: false).detectSummary(
      data: data__,
    );
  }

  // void _ontap2() async {
  //   final Email email = Email(
  //     body: 'Email body',
  //     subject: 'Email subject',
  //     recipients: ['tirthshah100@gmail.com'],
  //     // cc: ['cc@example.com'],
  //     // bcc: ['bcc@example.com'],
  //     attachmentPaths: ['/path/to/attachment.zip'],
  //     isHTML: false,
  //   );

  //   await FlutterEmailSender.send(email);
  // }
  String ans = "";
  Future<void> send() async {
    // final Email email = Email(
    //   body: 'Email body',
    //   subject: 'Email subject',
    //   recipients: ['tirthshah100@gmail. com'],
    //   // cc: ['cc@example.com'],
    //   // bcc: ['bcc@example.com'],
    //   // cc: [''],
    //   // bcc: [''],
    //   // attachmentPaths: ['/path/to/attachment.zip'],
    //   // attachmentPaths: [''],
    //   isHTML: false,
    // );

    // String platformResponse;

    // try {
    //   await FlutterEmailSender.send(email);
    //   platformResponse = 'success';
    // } catch (error) {
    //   print(error);
    //   platformResponse = error.toString();
    // }

    // if (!mounted) return;

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(platformResponse),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text('confidance:${(_confiance * 100.0).toStringAsFixed(1)}%'),
      // ),

      // body: ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AvatarGlow(
        animate: _islistening,
        // animate: true,
        glowColor: Theme.of(context).errorColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,

        child: FloatingActionButton(
          // color: _islistening ? null : Theme.of(context).errorColor,
          backgroundColor: _islistening
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).primaryColorLight,
          child: Icon(
            _islistening ? Icons.mic : Icons.mic_off,
            color: _islistening ? Colors.white : Colors.black,
          ),
          onPressed: () => _listen(),
        ),
      ),
      // body: SingleChildScrollView(
      // reverse: true,
      // child: Container(
      //     child: TextHighlight(
      //   text: _text,
      //   words: _highlights,
      //   textStyle: TextStyle(
      //       fontSize: 32.0, color: Colors.black, fontWeight: FontWeight.w400),
      // )),
      // child: Container(child: Text(_text)),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ElevatedButton(
            //     onPressed: () async {
            //       _ontap();
            //     },
            // // child:
            //  Text("btn")),
            // ElevatedButton(
            //     onPressed: () async {
            //       await send();
            //       setState(() {});
            //     },
            //     child: Text("btnnnn222")),
            // Text(ans),
            Card(
              elevation: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.34,
                child: MassagesWidget(projectId: pid),
              ),
            ),
            Card(
              elevation: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.33,
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: TextHighlight(
                          text: _text,
                          words: _highlights,
                          textAlign: TextAlign.justify,
                          textStyle: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: _sendMessage, child: UploadIconWidget()),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _text = '';
                        });
                      },
                      child: RemoveIconWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
