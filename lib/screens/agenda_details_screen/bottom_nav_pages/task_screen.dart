import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minuteofmeeting/widgets/task_card.dart';

import '../../../widgets/add_agenda_widgets.dart';
import '../../../widgets/app_drawer.dart';
import '../../../widgets/project_item.dart';
import '../agenda_details_screen.dart';

class Taskscreen extends StatelessWidget {
  const Taskscreen({super.key, required this.projectId});
  final String projectId;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          // title: Text("Task"),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "My task",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                  child: Text(
                "Asign to",
                style: TextStyle(color: Colors.black),
              )),
              // Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          actions: [
            // IconButton(
            //     onPressed: () => addproject(context), icon: Icon(Icons.add)),
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
        body: TabBarView(
          children: [
            Column(
              children: [Text("sorry no data present")],
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('task/').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final projectdata = snapshot.data?.docs;
                  // final newpdata=projectdata!.where((element) {
                  //   return ((element.id==currentUser!.refreshToken) );
                  // });
                  // final a=projectdata.where((element) {

                  // });
                  // if ((projectdata! .isEmpty)) {
                  print(projectdata);
                  if ((projectdata == null)) {
                    return Center(
                      child: Text("sorry project list is empty.."),
                    );
                  }
                  return ListView.builder(
                    itemCount: projectdata.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          // onTap: () {
                          //   print(projectdata[index].id);
                          //   Navigator.of(context).pushNamed(
                          //       AgendaDetailsScreen.routeName,
                          //       arguments: projectdata[index].id);
                          // },
                          child: ListTile(
                        leading: Icon(Icons.check_box_outline_blank),
                        title: Text(projectdata[index]["task_title"]),
                        subtitle: Text(projectdata[index]["asign_to"]),
                      ));
                    },
                  );
                }),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(AddAgendaWidget.routeName);
        //   },
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}
