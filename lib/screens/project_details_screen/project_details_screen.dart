import 'package:flutter/material.dart';
import 'package:minuteofmeeting/screens/project_details_screen/bottom_nav_pages/chat_screen.dart';
import 'package:minuteofmeeting/screens/project_details_screen/bottom_nav_pages/meeting_screen.dart';
import 'package:minuteofmeeting/screens/project_details_screen/bottom_nav_pages/post_screen.dart';
import 'package:minuteofmeeting/screens/project_details_screen/bottom_nav_pages/task_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});
  static const routeName = '/ProjectDetailsScreen';

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  dynamic projectId;
  int current_index = 0;
  var pageList = [
    MeetingScreen(),
    Taskscreen(),
    ChatScreen(),
    PostScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      current_index = index;
    });
  }

  @override
  void didChangeDependencies() {
    var pid = ModalRoute.of(context)?.settings.arguments;
    if (pid != null) {
      projectId = pid;
    }
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
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded),
            label: 'post',
          ),
        ],
      ),
    );
  }
}
