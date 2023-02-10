import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/activities_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/calender_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/individual_chat_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/profile_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/agenda_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Octal3'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.web),
            title: Text('Agenda'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AgendaScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.receipt_long_rounded),
            title: Text('activities'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ActiviesScreen.routeName);
              // .pushReplacementNamed(OrdersScreenNewFutureBuilder.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.chat_outlined),
            title: Text('individual chat'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(IndividualChatScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('calender'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CalenderScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('profile'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProfileScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('logout'),
            onTap: () {
              // Navigator.of(context).pop();
              // Navigator.of(context).pushReplacementNamed('/');
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              FirebaseAuth.instance.signOut();
              print("happy");
            },
          ),
        ],
      ),
    );
  }
}
