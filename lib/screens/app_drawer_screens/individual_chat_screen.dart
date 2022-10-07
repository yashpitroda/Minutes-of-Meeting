import 'package:flutter/material.dart';

import '../../widgets/app_drawer.dart';

class IndividualChatScreen extends StatelessWidget {
  static const routeName='/IndividualChatScreen';
  const IndividualChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("message")),
       drawer: AppDrawer(),
      body: Center(
        child: Text('IndividualChatScreen'),
      ),
    );
  }
}
