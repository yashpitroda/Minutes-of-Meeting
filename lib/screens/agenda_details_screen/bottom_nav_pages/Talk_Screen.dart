import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:minuteofmeeting/widgets/upload_icon_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../widgets/remove_icon_widget.dart';

class TalksScreen extends StatefulWidget {
  const TalksScreen({super.key, required this.projectId});
  final String projectId;
  @override
  State<TalksScreen> createState() => _TalksScreenState();
}

class _TalksScreenState extends State<TalksScreen> {
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
            Card(
              elevation: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.34,
                child: ListView(
                  children: [
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                  ],
                ),
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
                  InkWell(onTap: () {}, child: UploadIconWidget()),
                  InkWell(onTap: () {}, child: RemoveIconWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
