import 'package:flutter/material.dart';

class meetingCard extends StatelessWidget {
  const meetingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text("Meeting 1",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            Text(
              "Leader:xyz",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Divider(color: Colors.black),
            Text("Venue: Vishwakarma Hall",
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.left),
            Text("Date : 20th September, 2022",
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.left),
            Text(
              "Duration : 2 hours",
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.left,
            ),
          ]),
        ),
      ),
    );
  }
}
