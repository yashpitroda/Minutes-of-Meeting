import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minuteofmeeting/widgets/add_project_widgets.dart';
import 'package:minuteofmeeting/screens/project_details_screen/project_details_screen.dart';
import 'package:minuteofmeeting/widgets/project_item.dart';

import '../../widgets/app_drawer.dart';

class ProjectScreen extends StatelessWidget {
  static const routeName = '/ProjectScreen';
  const ProjectScreen({super.key});
  void addproject(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddProjectWidget();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("projects"),
        actions: [
          IconButton(
              onPressed: () => addproject(context), icon: Icon(Icons.add)),
          //  PopupMenuButton(
          //     color: Theme.of(context).primaryColorLight,
          //     itemBuilder: (context) => [
          //       PopupMenuItem(
          //           onTap: () {
          //             FirebaseAuth.instance.signOut();
          //           },
          //           child: Text("Logout")),
          //     ],
          //   ),
          // DropdownButton(
          //   icon: Icon(
          //     Icons.more_vert,
          //     color: Theme.of(context).backgroundColor,
          //   ),
          //   items: [
          //     DropdownMenuItem(
          //       child: Container(
          //         child: Row(
          //           children: <Widget>[
          //             Icon(
          //               Icons.exit_to_app,
          //               color: Colors.black,
          //             ),
          //             SizedBox(width: 8),
          //             Text('Logout'),
          //           ],
          //         ),
          //       ),
          //       value: 'logout',
          //     ),
          //   ],
          //   onChanged: (itemIdentifier) {
          //     if (itemIdentifier == 'logout') {
          //       FirebaseAuth.instance.signOut();
          //     }
          //   },
          // ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('projects').snapshots(),
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
                        ProjectDetailsScreen.routeName,
                        arguments: projectdata[index].id);
                  },
                  child: projectItem(
                      projectDiscription: projectdata[index]
                          ['projectDiscription'],
                      projecttilte: projectdata[index]['projectname'],
                      projectcreateby: projectdata[index]['projectcreateby'],
                      projectehencreaated: projectdata[index]
                          ['projectcreationdate']),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addproject(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
