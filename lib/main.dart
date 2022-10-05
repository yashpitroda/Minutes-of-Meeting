import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minuteofmeeting/screens/dashbord.dart';

import 'firebase_options.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:StreamBuilder(
        stream: FirebaseAuth.instance
            .authStateChanges(), //it give a token whter it is authenticed or not
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            //if data is found mean userr authanticated so we go to chatscreem
            return Dashboardscreen();
          } else {
            //and no data so not auth.. so retry
            return AuthScreen();
          }
        },
      ),
    );
  }
}
