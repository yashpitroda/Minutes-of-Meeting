import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MassagesWidget extends StatelessWidget {
  final projectId;
  MassagesWidget({super.key, this.projectId});
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    print(projectId);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('agenda/$projectId/chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),

      //when ever this database changes at that time it weill automatic call and fatch the data
      //whenever stream givs new value at that time bulder re executed

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //else
        final chatdocument = snapshot.data?.docs;
        if ((chatdocument!.isEmpty)) {
          return Center(
            child: Text("sorry project list is empty.."),
          );
        }
        return ListView.builder(
          reverse: true, //botton to top
          itemCount: chatdocument.length,
          itemBuilder: (ctx, index) => GestureDetector(
            onLongPress: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                            onTap: () async {
                              print(chatdocument[index].id);
                              String chatid = chatdocument[index].id;
                              // await FirebaseFirestore.instance
                              //     .collection('agenda/$projectId/chats').
                                  
                            }
                            // Remove the tapped document here - how?

                            ));
                  });
            },
            child: MessageBubble(
              chatdocument[index]['text'],
              chatdocument[index]['userName'],
              chatdocument[index]['userImageUrl'],
              (chatdocument[index]['userId'] == currentUser!.uid),
              key: ValueKey(chatdocument[index].id),
            ),
          ),
        );
      },
    );
  }
}
