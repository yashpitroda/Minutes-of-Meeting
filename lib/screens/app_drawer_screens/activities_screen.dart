import 'package:flutter/material.dart';
import 'package:minuteofmeeting/widgets/app_drawer.dart';

class ActiviesScreen extends StatelessWidget {
  static const routeName = '/ActiviesScreen';
  const ActiviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Activies")),
      body: Center(
        child: Text('ActiviesScreen'),
      ),
    );
  }
}
