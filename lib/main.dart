import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/activities_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/calender_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/individual_chat_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/profile_screen.dart';
import 'package:minuteofmeeting/screens/project_details_screen/project_details_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/project_screen.dart';

import 'firebase_options.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance
            .authStateChanges(), //it give a token whter it is authenticed or not
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            //if data is found mean userr authanticated so we go to chatscreem
            return ProjectScreen();
          } else {
            //and no data so not auth.. so retry
            return AuthScreen();
          }
        },
      ),
      routes: {
        ProjectDetailsScreen.routeName: (context) => ProjectDetailsScreen(),
        ActiviesScreen.routeName: (context) => ActiviesScreen(),
        CalenderScreen.routeName: (context) => CalenderScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        IndividualChatScreen.routeName: (context) => IndividualChatScreen(),
        ProjectScreen.routeName: (context) => ProjectScreen(),
      },
    );
  }
}
