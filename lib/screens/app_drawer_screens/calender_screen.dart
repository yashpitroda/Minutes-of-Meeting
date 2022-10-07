import 'package:flutter/material.dart';

import '../../widgets/app_drawer.dart';

class CalenderScreen extends StatelessWidget {
  static const routeName = '/CalenderScreen';
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calender")),
      drawer: AppDrawer(),
      body: Center(
        child: Text('CalenderScreen'),
      ),
    );
  }
}
