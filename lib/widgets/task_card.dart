import 'package:flutter/material.dart';

class taskCard extends StatelessWidget {
  const taskCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Task: Build presentation for next Friday",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left),
            Text("Agenda",
                style: TextStyle(color: Colors.black, fontSize: 20),
                // fontWeight: FontWeight.bold),
                textAlign: TextAlign.left),
            Divider(color: Colors.black),
            Text("Due Date : 24th September,2022",
                style: TextStyle(color: Colors.black, fontSize: 20),
                // fontWeight: FontWeight.bold),
                textAlign: TextAlign.left)
          ]),
        ),
      ),
    );
  }
}