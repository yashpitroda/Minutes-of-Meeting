import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minuteofmeeting/widgets/meeting_card.dart';

import '../../../widgets/project_item.dart';
import '../agenda_details_screen.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key, required this.projectId});
  final String projectId;
  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  @override
  Widget build(BuildContext context) {
    final pid = widget.projectId;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            meetingCard(),
            meetingCard(),
            meetingCard(),
            meetingCard(),
          ],
        ),
      ),
    );
  }
}
