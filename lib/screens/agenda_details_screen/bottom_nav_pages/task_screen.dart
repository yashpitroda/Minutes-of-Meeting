import 'package:flutter/material.dart';
import 'package:minuteofmeeting/widgets/task_card.dart';

class Taskscreen extends StatelessWidget {
  const Taskscreen({super.key, required this.projectId});
  final String projectId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        taskCard(),
        taskCard(),
        taskCard(),
      ],
    ));
  }
}
