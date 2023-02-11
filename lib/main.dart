import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minuteofmeeting/models/summary_proivder.dart';
import 'package:minuteofmeeting/screens/agenda_details_screen/select_supplier_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/activities_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/calender_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/individual_chat_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/profile_screen.dart';
import 'package:minuteofmeeting/screens/agenda_details_screen/agenda_details_screen.dart';
import 'package:minuteofmeeting/screens/app_drawer_screens/agenda_screen.dart';
import 'package:minuteofmeeting/widgets/add_agenda_widgets.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //   await translator.init(
  //   localeType: LocalizationDefaultType.device,
  //   languagesList: <String>['ar', 'en'],
  //   assetsDirectory: 'assets/lang/',
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext ctx) => summaryProvider(),
        ),
      ],
      child: MaterialApp(
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
              return AgendaScreen();
            } else {
              //and no data so not auth.. so retry
              return AuthScreen();
            }
          },
        ),
        routes: {
          AgendaDetailsScreen.routeName: (context) => AgendaDetailsScreen(),
          ActiviesScreen.routeName: (context) => ActiviesScreen(),
          CalenderScreen.routeName: (context) => CalenderScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          IndividualChatScreen.routeName: (context) => IndividualChatScreen(),
          AgendaScreen.routeName: (context) => AgendaScreen(),
          AddAgendaWidget.routeName: (context) => AddAgendaWidget(),
          SelectSupplierScreen.routeName: (context) => SelectSupplierScreen(),
        },
      ),
    );
    // );
  }
}
