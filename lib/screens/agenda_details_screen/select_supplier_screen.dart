import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectSupplierScreen extends StatefulWidget {
  static const String routeName = '/SelectSupplierScreen';
  SelectSupplierScreen({super.key});

  @override
  State<SelectSupplierScreen> createState() => _SelectSupplierScreenState();
}

class _SelectSupplierScreenState extends State<SelectSupplierScreen> {
  User? currentUser = FirebaseAuth.instance.currentUser!;
  TextEditingController searchTextController = TextEditingController();
  FocusNode searchTextfocusnode = FocusNode();

  var _isselected = false;
  var _isloading = false;
  var selectedSuppilerObj;
  bool issearchon = false;
  List items = [];
  List selectedUserlist = [];
  Map selectedUser = {};
  @override
  void didChangeDependencies() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        items.add({
          "emailid": doc["emailid"],
          "mobileno": doc["mobileno"],
          "password": doc["password"],
          "role": doc["role"],
          "useridbyfirebase": doc["useridbyfirebase"],
          "username": doc["username"],
        });
      });
    });
    print(items);
    setState(() {});
    // if (_isInit) {
    //   setState(() {
    //     _isloading = true;
    //   });
    //   Provider.of<SupplierProvider>(context, listen: false)
    //       .fatchSupplier()
    //       .then((_) {
    //     setState(() {
    //       _isloading = false;
    //     });
    //   });
    //   // widget.duplicateItems =
    //   //     Provider.of<ClientContactProvider>(context).clientContactList;
    //   // items.addAll(duplicateItems);
    // }
    // print(items);

    // _isInit = false;
    super.didChangeDependencies();
  }

  void clearTextOnSearchTextField() {
    searchTextController.clear();
    searchTextfocusnode.unfocus();
    // Utility.refreshSupplier(context);
  }

  @override
  Widget build(BuildContext context) {
    // List<Supplier> items =
    //     Provider.of<SupplierProvider>(context, listen: true).supplierList;

    var mqhight = MediaQuery.of(context).size.height;
    var mqwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Select mamber",
          // style: TextStyle(fontFamily: "Rubik"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(selectedUserlist);
              },
              icon: Icon(Icons.check_sharp))
        ],
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.09),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedUserlist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 140,
                        child: Card(
                          child: Container(
                            width: 120,
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                Column(
                                  children: [
                                    Flexible(
                                        child: Text(
                                            "${selectedUserlist[index]["username"]}")),
                                    Flexible(
                                        child: Text(
                                            "${selectedUserlist[index]["role"]}")),
                                    Flexible(
                                        child: Text(
                                            "${selectedUserlist[index]["emailid"]}"))
                                  ],
                                ),
                                Positioned(
                                  top: -10,
                                  right: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          selectedUserlist.removeAt(index);
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.remove)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: mqhight * 0.015,
              ),
              Expanded(
                flex: 6,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                      color: Colors.white,
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 0),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${items[index]["username"]}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Rubik"),
                            ),
                          ],
                        ),

                        // "${items[index].cname} AND cid=${items[index].cid}"

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${items[index]["mobileno"]} : ${items[index]["emailid"]}",
                              style: const TextStyle(fontFamily: "Rubik"),
                            ),
                          ],
                        ),
                        // subtitle: Text(" ${items[index].entrydatetime}"),
                        value: items[index],
                        groupValue: selectedUser,
                        // toggleable: true,
                        onChanged: (value) {
                          setState(() {
                            _isselected = true;
                            selectedUser = value;
                            selectedUserlist.add(selectedUser);
                            print(selectedUserlist);
                          });

                          // print(selectedSuppilerObj);
                          // Navigator.of(context).pop(selectedSuppilerObj);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //     Navigator.of(context).pushNamed(AddupdateSupplierScreen.routeName);
      //     // .then((_) => _refreshProducts(context));
      //   },
      //   label: const Text('Add Supplier'),
      //   icon: const Icon(Icons.add),
      // ),
    );
  }
}
// import 'package:cashbook_app/models/client_contact.dart';
// import 'package:cashbook_app/provider/client_contact_provider.dart';
// import 'package:cashbook_app/screen/contact_screens/select_contact_screen.dart';
// import 'package:cashbook_app/screen/manage_client_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'add_client_screen.dart';

// // class SelectClintScreen extends StatefulWidget {
// //   static const String routeName = '/SelectClintScreen';
// //   SelectClintScreen({super.key});

// //   @override
// //   State<SelectClintScreen> createState() => _SelectClintScreenState();
// // }

// class SelectClintScreen extends StatelessWidget {
//   static const String routeName = '/SelectClintScreen';
//   SelectClintScreen({super.key});
//   User? currentUser = FirebaseAuth.instance.currentUser!;
//   TextEditingController searchTextController = TextEditingController();
//   FocusNode searchTextfocusnode = FocusNode();

//   var selectedClient;

//   Future<void> _refreshClient(BuildContext context) async {
//     await Provider.of<ClientContactProvider>(context, listen: false)
//         .fatchCilentContact(useremail: currentUser!.email.toString());
//     print('refresh done');
//   }

//   // @override
//   // void didChangeDependencies() {
//   //   if (_isInit) {
//   //     setState(() {
//   //       _isloading = true;
//   //     });
//   //     Provider.of<ClientContactProvider>(context, listen: false)
//   //         .fatchCilentContact(useremail: currentUser!.email.toString())
//   //         .then((_) {
//   //       setState(() {
//   //         _isloading = false;
//   //       });
//   //     });
//   //     // widget.duplicateItems =
//   //     //     Provider.of<ClientContactProvider>(context).clientContactList;
//   //     // items.addAll(duplicateItems);
//   //   }
//   //   // print(items);

//   //   _isInit = false;
//   //   super.didChangeDependencies();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // List<ClientContact> items =
//     //     Provider.of<ClientContactProvider>(context, listen: true)
//     //         .clientContactList;

//     var mqhight = MediaQuery.of(context).size.height;
//     var mqwidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text(
//           "Select Client",
//           // style: TextStyle(fontFamily: "Rubik"),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(ManageClientScreen.routeName);
//               },
//               icon: const Icon(Icons.settings))
//         ],
//       ),
//       body: GestureDetector(
//         onTap: () {
//           searchTextfocusnode.unfocus();
//         },
//         child: Container(
//           color: Colors.grey.withOpacity(0.09),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: Column(
//               children: [
//                 TextField(
//                   onChanged: (value) {
//                     Provider.of<ClientContactProvider>(context, listen: false)
//                         .filterSearchResults(value);
//                   },
//                   focusNode: searchTextfocusnode,
//                   controller: searchTextController,
//                   cursorColor: Colors.black,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16),
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.search_rounded),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(14)),
//                     ),
//                     labelText: "Search",
//                     labelStyle: TextStyle(letterSpacing: 1, fontSize: 14),
//                     hintStyle: TextStyle(fontSize: 13),
//                     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                   ),
//                 ),
//                 SizedBox(
//                   height: mqhight * 0.015,
//                 ),
//                 Expanded(
//                   child: RefreshIndicator(
//                       onRefresh: () => _refreshClient(context),
//                       child: FutureBuilder(
//                         future: Provider.of<ClientContactProvider>(context,
//                                 listen: false)
//                             .fatchCilentContact(
//                                 useremail: currentUser!.email.toString()),
//                         builder: (context, snapshot) {
//                           List<ClientContact> items =
//                               Provider.of<ClientContactProvider>(context,
//                                       listen: true)
//                                   .clientContactList;
//                           if (items.isNotEmpty) {
//                             return customRadioListTile(items);
//                           } else if (snapshot.hasError) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 16),
//                               child: Text('Error: ${snapshot.error}'),
//                             );
//                           } else {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                         },
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           // Add your onPressed code here!
//           Navigator.of(context).pushNamed(AddupdateClientScreen.routeName);
//           // .then((_) => _refreshProducts(context));
//         },
//         label: const Text('Add Client'),
//         icon: const Icon(Icons.add),
//       ),
//     );
//   }

//   ListView customRadioListTile(List<ClientContact> items) {
//     return ListView.builder(
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         return Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           elevation: 0,
//           color: Colors.white,
//           child: RadioListTile(
//             contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "${items[index].fermname}",
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: "Rubik"),
//                 ),
//                 Text(
//                   "${items[index].entrydatetime.toString().split(' ')[0]}",
//                   style: TextStyle(fontSize: 12, fontFamily: "Rubik"),
//                 ),
//               ],
//             ),

//             // "${items[index].cname} AND cid=${items[index].cid}"

//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${items[index].cname} : +91 ${items[index].cmobileno}",
//                   style: TextStyle(fontFamily: "Rubik"),
//                 ),
//               ],
//             ),
//             // subtitle: Text(" ${items[index].entrydatetime}"),
//             value: items[index],
//             groupValue: selectedClient,
//             // toggleable: true,
//             onChanged: (value) {
//               // setState(() {
//               selectedClient = value;
//               // });
//               print(selectedClient);
//               Navigator.of(context).pop(selectedClient);
//             },
//           ),
//         );
//       },
//     );
//   }
// }
