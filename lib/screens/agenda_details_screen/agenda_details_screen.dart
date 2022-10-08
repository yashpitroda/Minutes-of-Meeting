import 'package:flutter/material.dart';
import 'package:minuteofmeeting/screens/agenda_details_screen/bottom_nav_pages/meeting_screen.dart';

import 'bottom_nav_pages/Talk_Screen.dart';
import 'bottom_nav_pages/chat_screen.dart';
import 'bottom_nav_pages/task_screen.dart';

class AgendaDetailsScreen extends StatefulWidget {
  const AgendaDetailsScreen({super.key});
  static const routeName = '/AgendaDetailsScreen';

  @override
  State<AgendaDetailsScreen> createState() => _AgendaDetailsScreenState();
}

class _AgendaDetailsScreenState extends State<AgendaDetailsScreen> {
  dynamic projectId;
  int current_index = 0;

  void _onItemTapped(int index) {
    setState(() {
      current_index = index;
    });
  }

  var pageList = [];
  @override
  void didChangeDependencies() {
    var pid = ModalRoute.of(context)?.settings.arguments;
    if (pid != null) {
      projectId = pid;
    }
    pageList.add(TalksScreen(projectId: projectId));
    pageList.add(MeetingScreen(projectId: projectId));
    pageList.add(Taskscreen(projectId: projectId));
    pageList.add(ChatScreen(projectId: projectId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('project details screen')),
      body: pageList.elementAt(current_index),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: current_index,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.record_voice_over_rounded),
            label: 'talks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room_outlined),
            label: 'meeting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_rounded),
            label: 'tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'chat',
          ),
        ],
      ),
    );
  }
}
