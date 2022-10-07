import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class projectItem extends StatefulWidget {
  projectItem(
      {required this.projectDiscription,
      required this.projecttilte,
      required this.projectcreateby,
      required this.projectehencreaated});
  final String projecttilte;
  String projectDiscription;
  Timestamp projectehencreaated;
  String projectcreateby;

  @override
  State<projectItem> createState() => _projectItemState();
}

class _projectItemState extends State<projectItem> {
  // @override
  var _expanded = false;
  void _popupprojectbtn(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return PopUpBottomSheetMoreInProject();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
              leading: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
              title: Text(
                (_expanded)
                    ? 'project name:  ${widget.projecttilte}'
                    : '${widget.projecttilte}',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                // DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
                'created by :' + widget.projectcreateby,
                overflow: TextOverflow.fade,
              ),
              trailing: IconButton(
                onPressed: () => _popupprojectbtn(context),
                icon: Icon(Icons.more_vert),
              )),
          if (_expanded)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              height: max(widget.projectDiscription.length * 2, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discription: " + widget.projectDiscription,
                  ),
                  // Text("create date: " + widget.projectehencreaated.toString()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class PopUpBottomSheetMoreInProject extends StatelessWidget {
  const PopUpBottomSheetMoreInProject({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.blue[600],
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                        "add memebers",
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.edit_note_sharp,
                      color: Colors.blue[600],
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                        "manage memebers",
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people_rounded,
                      color: Colors.blue[600],
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                        "view memebers",
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
