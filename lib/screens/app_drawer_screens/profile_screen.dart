import 'package:flutter/material.dart';

import '../../widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName='/ProfileScreen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Profile")),
       drawer: AppDrawer(),
      body: Center(
        child: Text('ProfileScreen'),
      ),
    );
  }
}
