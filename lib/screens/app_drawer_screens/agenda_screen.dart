import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minuteofmeeting/screens/agenda_details_screen/agenda_details_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/navigator_key.dart';
import 'package:minuteofmeeting/widgets/add_agenda_widgets.dart';
import 'package:minuteofmeeting/widgets/project_item.dart';

import '../../constants/colors.dart';
import '../../widgets/app_drawer.dart';
import '../video_conferencing/common/join_screen.dart';

class AgendaScreen extends StatelessWidget {
  User? currentUser = FirebaseAuth.instance.currentUser;
  static const routeName = '/ProjectScreen';
  AgendaScreen({super.key});
  // void addproject(BuildContext ctx) {
  //   showModalBottomSheet(
  //       context: ctx,
  //       builder: (_) {
  //         return AddAgendaWidget();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Meeting"),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "General",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                  child: Text(
                "Department",
                style: TextStyle(color: Colors.black),
              )),
              Tab(
                  child: Text(
                "Video Conferencing",
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
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('agenda').snapshots(),
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
                        onTap: () {
                          print(projectdata[index].id);
                          Navigator.of(context).pushNamed(
                              AgendaDetailsScreen.routeName,
                              arguments: projectdata[index].id);
                        },
                        child: projectItem(
                            projectDiscription: projectdata[index]
                                ['agendaDiscription'],
                            projecttilte: projectdata[index]['agendaname'],
                            projectcreateby: projectdata[index]
                                ['agendacreateby'],
                            projectehencreaated: projectdata[index]
                                ['agendacreationdate']),
                      );
                    },
                  );
                }),
            // Icon(Icons.directions_transit),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('department')
                    .snapshots(),
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
                        onTap: () {
                          print(projectdata[index].id);
                          Navigator.of(context).pushNamed(
                              AgendaDetailsScreen.routeName,
                              arguments: projectdata[index].id);
                        },
                        child: projectItem(
                            projectDiscription: projectdata[index]
                                ['agendaDiscription'],
                            projecttilte: projectdata[index]['agendaname'],
                            projectcreateby: projectdata[index]
                                ['agendacreateby'],
                            projectehencreaated: projectdata[index]
                                ['agendacreationdate']),
                      );
                    },
                  );
                }),
            MaterialApp(
              title: 'VideoSDK Flutter Example',
              theme: ThemeData.dark().copyWith(
                appBarTheme: const AppBarTheme().copyWith(
                  color: primaryColor,
                ),
                primaryColor: primaryColor,
                backgroundColor: secondaryColor,
              ),
              debugShowCheckedModeBanner: false,
              home: const JoinScreen(),
              navigatorKey: navigatorKey,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddAgendaWidget.routeName);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
