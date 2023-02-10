import 'package:flutter/material.dart';
import 'package:minuteofmeeting/models/summary_proivder.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.projectId});
  final String projectId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    String ans = Provider.of<summaryProvider>(context).getans;
    return Scaffold(
      body: Column(
        children: [Text(ans)],
      ),
    );
  }
}
