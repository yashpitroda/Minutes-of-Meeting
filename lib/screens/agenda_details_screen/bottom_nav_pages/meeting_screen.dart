import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  final pid=widget.projectId;
    return Scaffold(
      body: Column(
        children: [
          Text(pid),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('projects/$pid/meetings').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var projectdata = snapshot.data?.docs;
                if ((projectdata!.isEmpty)) {
                  return Center(
                    child: Text("sorry project list is empty.."),
                  );
                }
                return ListView.builder(
                  itemCount: projectdata!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(projectdata[index].id);
                        Navigator.of(context).pushNamed(
                            AgendaDetailsScreen.routeName,
                            arguments: projectdata[index].id);
                      },
                      child: projectItem(
                          projectDiscription: projectdata[index]
                              ['projectDiscription'],
                          projecttilte: projectdata[index]['projectname'],
                          projectcreateby: projectdata[index]
                              ['projectcreateby'],
                          projectehencreaated: projectdata[index]
                              ['projectcreationdate']),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
