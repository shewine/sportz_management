import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/like_animation.dart';

class UserEvent extends StatefulWidget {
  const UserEvent({Key? key}) : super(key: key);

  @override
  State<UserEvent> createState() => _UserEventState();
}

class _UserEventState extends State<UserEvent> {
  // SingingCharacter? _character = SingingCharacter.paid;
  bool isLoading = false;
  String dropdownValue = 'Free';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          "Event Add Screen",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Text('Vinit Op');
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Events: ',
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData || snapshot.data != null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?>? documentSnapshot =
                        snapshot.data?.docs[index];

                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Description(
                        //       title: documentSnapshot!['eventName'],
                        //       description: documentSnapshot['eventDesc'],
                        //     ),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10)),
                          height: 90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      (documentSnapshot != null)
                                          ? (documentSnapshot["eventName"])
                                          : "",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Text((documentSnapshot != null)
                                        ? ('Detail: ' +
                                            documentSnapshot["eventDesc"])
                                        : ""),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Text((documentSnapshot != null)
                                        ? ('Venue: ' +
                                            documentSnapshot["eventDate"])
                                        : ""),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Text((documentSnapshot != null)
                                        ? ('Type: ' +
                                            documentSnapshot["eventType"])
                                        : ""),
                                  ),
                                ],
                              ),
                              // String uid=  FirebaseAuth.instance.currentUser!.uid;
                              LikeAnimation(
                                isAnimating:
                                    documentSnapshot!['registeredUsers']
                                        .contains(FirebaseAuth
                                            .instance.currentUser!.uid),
                                smallLike: true,
                                child: IconButton(
                                  icon: documentSnapshot['registeredUsers']
                                          .contains(FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 30,
                                        )
                                      : const Icon(
                                          Icons.check_box_outline_blank,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                  onPressed: () => FireStoreMethods().likePost(
                                    documentSnapshot['eventId'].toString(),
                                    FirebaseAuth.instance.currentUser!.uid,
                                    documentSnapshot['registeredUsers'],
                                  ),
                                ),
                              ),

                              // IconButton(
                              //   onPressed: () {
                              //     // description = documentSnapshot["eventDate"];
                              //     showDialog(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return AlertDialog(
                              //             shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.circular(10)),
                              //             title: const Text("Add Todo"),
                              //             content: Container(
                              //               width: 400,
                              //               height: 145,
                              //               child: Column(
                              //                 children: [
                              //                   // TextField(
                              //                   //   onChanged: (String value) {
                              //                   //     title = value;
                              //                   //   },
                              //                   // ),
                              //                   TextField(
                              //                     onChanged: (String value) {
                              //                       description = value;
                              //                     },
                              //                   ),
                              //                   Row(
                              //                     children: [
                              //                       const Text(
                              //                           'Completion Date:'),
                              //                       TextButton(
                              //                         onPressed: () {
                              //                           setState(() {
                              //                             datepicker();
                              //                           });
                              //                         },
                              //                         child: const Icon(
                              //                             Icons.date_range),
                              //                         //  Text(
                              //                         //   DateFormat("dd/MM/yyyy")
                              //                         //       .format(date)
                              //                         //       .toString(),
                              //                         // ),
                              //                       ),
                              //                     ],
                              //                   )
                              //                 ],
                              //               ),
                              //             ),
                              //             actions: <Widget>[
                              //               TextButton(
                              //                   onPressed: () {
                              //                     setState(() {
                              //                       updateTodo(title);
                              //                     });
                              //                     Navigator.of(context).pop();
                              //                   },
                              //                   child: const Text("Add"))
                              //             ],
                              //           );
                              //         });

                              //     // setState(() {
                              //     //   //todos.removeAt(index);
                              //     //   updateTodo((documentSnapshot != null)
                              //     //       ? (documentSnapshot["todoTitle"])
                              //     //       : "");

                              //     //   print(dayOnly);
                              //     // });
                              //   },
                              //   icon: const Icon(
                              //     Icons.edit,
                              //     color: Colors.deepPurple,
                              //   ),
                              // ),
                              // Container(
                              //   child: IconButton(
                              //     onPressed: () {
                              //       setState(() {
                              //         //todos.removeAt(index);
                              //         deleteTodo((documentSnapshot != null)
                              //             ? (documentSnapshot["eventTitle"])
                              //             : "");
                              //       });
                              //     },
                              //     icon: const Icon(
                              //       Icons.delete,
                              //       color: Colors.red,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                    // Card(
                    //  elevation: 4,
                    //  child: ListTile(
                    //    // leading: Text(DateFormat.yMd().format(date)),
                    //    leading: Text((documentSnapshot != null)
                    //        ? (documentSnapshot["todoDate"])
                    //        : ""),
                    //    title: Text((documentSnapshot != null)
                    //        ? (documentSnapshot["todoTitle"])
                    //        : ""),
                    //    subtitle: Text((documentSnapshot != null)
                    //        ? ((documentSnapshot["todoDesc"] != null)
                    //            ? documentSnapshot["todoDesc"]
                    //            : "")
                    //        : ""),
                    //    trailing: IconButton(
                    //      icon: const Icon(Icons.delete),
                    //      color: Colors.red,
                    //      onPressed: () {
                    //        setState(() {
                    //          //todos.removeAt(index);
                    //          deleteTodo((documentSnapshot != null)
                    //              ? (documentSnapshot["todoTitle"])
                    //              : "");
                    //        });
                    //      },
                    //    ),
                    //  ),
                    //   );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // const Center(
      //   child: Text('Events Screen'),
      // ),

      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           scrollable: true,
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(10)),
      //           title: const Text("Add Event"),
      //           content: Container(
      //             width: MediaQuery.of(context).size.width * 0.8,
      //             height: MediaQuery.of(context).size.height * 0.33,
      //             child: Column(
      //               children: [
      //                 TextField(
      //                   decoration: const InputDecoration(
      //                     border: OutlineInputBorder(),
      //                     hintText: 'Enter Event Name',
      //                   ),
      //                   onChanged: (String value) {
      //                     eventName = value;
      //                   },
      //                 ),
      //                 const SizedBox(height: 10),
      //                 TextField(
      //                   decoration: const InputDecoration(
      //                     border: OutlineInputBorder(),
      //                     hintText: 'Event Place and Decription',
      //                   ),
      //                   onChanged: (String value) {
      //                     eventDesc = value;
      //                   },
      //                 ),
      //                 const SizedBox(height: 10),
      //                 TextField(
      //                   decoration: const InputDecoration(
      //                     border: OutlineInputBorder(),
      //                     hintText: 'Event Date and Time',
      //                   ),
      //                   onChanged: (String value) {
      //                     eventDate = value;
      //                   },
      //                 ),
      //                 const SizedBox(height: 10),
      //                 DropdownButton<String>(
      //                   value: dropdownValue,
      //                   icon: const Icon(Icons.arrow_downward),
      //                   elevation: 16,
      //                   style: const TextStyle(color: Colors.white),
      //                   underline: Container(
      //                     height: 2,
      //                     color: Colors.white,
      //                   ),
      //                   onChanged: (String? newValue) {
      //                     setState(() {
      //                       dropdownValue = newValue!;
      //                     });
      //                   },
      //                   items: <String>['Free', 'Paid']
      //                       .map<DropdownMenuItem<String>>((String value) {
      //                     return DropdownMenuItem<String>(
      //                       value: value,
      //                       child: Text(value),
      //                     );
      //                   }).toList(),
      //                 ),

      //                 // Row(
      //                 //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 //   children: [
      //                 //     const Text('Paid'),
      //                 //     Radio<SingingCharacter>(
      //                 //       value: SingingCharacter.paid,
      //                 //       groupValue: _character,
      //                 //       onChanged: (SingingCharacter? value) {
      //                 //         setState(() {
      //                 //           _character = value;
      //                 //         });
      //                 //       },
      //                 //     ),
      //                 //     const Text('Unpaid'),
      //                 //     Radio<SingingCharacter>(
      //                 //       value: SingingCharacter.unpaid,
      //                 //       groupValue: _character,
      //                 //       onChanged: (SingingCharacter? value) {
      //                 //         setState(() {
      //                 //           _character = value;
      //                 //         });
      //                 //       },
      //                 //     ),
      //                 //   ],
      //                 // ),
      //               ],
      //             ),
      //           ),
      //           actions: <Widget>[
      //             TextButton(
      //               onPressed: () {
      //                 postEvent(
      //                     // userProvider.getAdmin.uid,
      //                     );
      //                 null;
      //                 // setState(() {

      //                 //   // createToDo();
      //                 //   // //todos.add(title);
      //                 //   // null;
      //                 // });
      //                 Navigator.of(context).pop();
      //               },
      //               child: const Text(
      //                 "Add",
      //                 style: TextStyle(fontWeight: FontWeight.bold),
      //               ),
      //             )
      //           ],
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sportz_management/models/user.dart';

// import '../providers/user_provider.dart';
// import '../resources/auth_methods.dart';
// import '../resources/firestore_methods.dart';
// import '../utils/colors.dart';
// import '../widgets/like_animation.dart';

// // enum SingingCharacter { paid, unpaid }

// class UserEvent extends StatefulWidget {
//   const UserEvent({Key? key}) : super(key: key);

//   @override
//   State<UserEvent> createState() => _UserEventState();
// }

// class _UserEventState extends State<UserEvent> {
//   User? user;
//   final AuthMethods _authMethods = AuthMethods();
//   // SingingCharacter? _character = SingingCharacter.paid;
//   bool isLikeAnimating = false;
//   // String dropdownValue = 'Free';
//   bool value = false;

//   // // String eventName = '';
//   // // String eventDesc = '';
//   // // String eventDate = '';
//   // // String eventWinner = 'Yet to be declared';
//   // late List registeredUsers = [];

//   // createToDo() {
//   //   DocumentReference documentReference =
//   //       FirebaseFirestore.instance.collection("Tasks").doc(eventName);

//   //   Map<String, Object> addEvents = {
//   //     "eventTitle": eventName,
//   //     "eventDesc": eventDesc,
//   //     "eventDate": eventDate,
//   //     "eventWinner": eventWinner,
//   //     "registeredUsers": registeredUsers,
//   //     "eventType": dropdownValue,
//   //     // date.toString()
//   //   };

//   //   documentReference
//   //       .set(addEvents)
//   //       .whenComplete(() => print("Data stored successfully"));
//   // }

//   deleteTodo(item) {
//     DocumentReference documentReference =
//         FirebaseFirestore.instance.collection("Tasks").doc(item);

//     documentReference
//         .delete()
//         .whenComplete(() => print("deleted successfully"));
//   }

//   @override
//   void initState() async {
//     // TODO: implement initState
//     User user = await _authMethods.getUserDetails();
//     user = user;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final UserProvider userProvider = Provider.of<UserProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         shadowColor: Colors.grey,
//         backgroundColor: mobileBackgroundColor,
//         title: const Text(
//           "Select Event Screen",
//           style: TextStyle(
//               fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.info,
//               color: Colors.white,
//               size: 30.0,
//             ),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 5,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text(
//                 'Events: ',
//               ),
//             ],
//           ),
//           StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return const Text('Something went wrong');
//               } else if (snapshot.hasData || snapshot.data != null) {
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: snapshot.data?.docs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     QueryDocumentSnapshot<Object?>? documentSnapshot =
//                         snapshot.data?.docs[index];

//                     return InkWell(
//                       onTap: null,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           margin: const EdgeInsets.only(bottom: 10),
//                           decoration: BoxDecoration(
//                               color: Colors.blueGrey,
//                               borderRadius: BorderRadius.circular(10)),
//                           height: 90,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Flexible(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.only(left: 20),
//                                       child: Text(
//                                         (documentSnapshot != null)
//                                             ? (documentSnapshot["eventName"])
//                                             : "",
//                                         style: const TextStyle(
//                                             fontSize: 20,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.only(left: 20),
//                                       child: Text((documentSnapshot != null)
//                                           ? ('Detail: ' +
//                                               documentSnapshot["eventDesc"])
//                                           : ""),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.only(left: 20),
//                                       child: Text((documentSnapshot != null)
//                                           ? ('Venue: ' +
//                                               documentSnapshot["eventDate"])
//                                           : ""),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.only(left: 20),
//                                       child: Text((documentSnapshot != null)
//                                           ? ('Type: ' +
//                                               documentSnapshot["eventType"])
//                                           : ""),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               // IconButton(
//                               //   onPressed: () {
//                               //     // description = documentSnapshot["eventDate"];
//                               //     showDialog(
//                               //         context: context,
//                               //         builder: (BuildContext context) {
//                               //           return AlertDialog(
//                               //             shape: RoundedRectangleBorder(
//                               //                 borderRadius:
//                               //                     BorderRadius.circular(10)),
//                               //             title: const Text("Add Todo"),
//                               //             content: Container(
//                               //               width: 400,
//                               //               height: 145,
//                               //               child: Column(
//                               //                 children: [
//                               //                   // TextField(
//                               //                   //   onChanged: (String value) {
//                               //                   //     title = value;
//                               //                   //   },
//                               //                   // ),
//                               //                   TextField(
//                               //                     onChanged: (String value) {
//                               //                       description = value;
//                               //                     },
//                               //                   ),
//                               //                   Row(
//                               //                     children: [
//                               //                       const Text(
//                               //                           'Completion Date:'),
//                               //                       TextButton(
//                               //                         onPressed: () {
//                               //                           setState(() {
//                               //                             datepicker();
//                               //                           });
//                               //                         },
//                               //                         child: const Icon(
//                               //                             Icons.date_range),
//                               //                         //  Text(
//                               //                         //   DateFormat("dd/MM/yyyy")
//                               //                         //       .format(date)
//                               //                         //       .toString(),
//                               //                         // ),
//                               //                       ),
//                               //                     ],
//                               //                   )
//                               //                 ],
//                               //               ),
//                               //             ),
//                               //             actions: <Widget>[
//                               //               TextButton(
//                               //                   onPressed: () {
//                               //                     setState(() {
//                               //                       updateTodo(title);
//                               //                     });
//                               //                     Navigator.of(context).pop();
//                               //                   },
//                               //                   child: const Text("Add"))
//                               //             ],
//                               //           );
//                               //         });

//                               //     // setState(() {
//                               //     //   //todos.removeAt(index);
//                               //     //   updateTodo((documentSnapshot != null)
//                               //     //       ? (documentSnapshot["todoTitle"])
//                               //     //       : "");

//                               //     //   print(dayOnly);
//                               //     // });
//                               //   },
//                               //   icon: const Icon(
//                               //     Icons.edit,
//                               //     color: Colors.deepPurple,
//                               //   ),
//                               // ),
//                               // Container(
//                               //   margin: const EdgeInsets.only(left: 20),
//                               //   child: Text((documentSnapshot != null)
//                               //       ? (documentSnapshot["eventType"])
//                               //       : ""),
//                               // ),

//                               // LikeAnimation(
//                               //   isAnimating:
//                               //       documentSnapshot!['registeredUsers']
//                               //           .contains(user!.uid),
//                               //   smallLike: true,
//                               //   child: IconButton(
//                               //     icon: documentSnapshot['registeredUsers']
//                               //             .contains(user!.uid)
//                               //         ? const Icon(
//                               //             Icons.favorite,
//                               //             color: Colors.red,
//                               //           )
//                               //         : const Icon(
//                               //             Icons.favorite_border,
//                               //           ),
//                               //     onPressed: () => FireStoreMethods().likePost(
//                               //       documentSnapshot['eventId'].toString(),
//                               //       user!.uid,
//                               //       documentSnapshot['registeredUsers'],
//                               //     ),
//                               //   ),
//                               // ),

//                               // Container(
//                               //   child: Checkbox(
//                               //     checkColor: Colors.white,
//                               //     // fillColor: Colors.black,
//                               //     value: value,
//                               //     onChanged: (bool? value) {
//                               //       setState(() {
//                               //         this.value = value!;
//                               //       });
//                               //     },
//                               //   ),

//                               // IconButton(
//                               //   onPressed: () {
//                               //     setState(() {
//                               //       //todos.removeAt(index);
//                               //       deleteTodo((documentSnapshot != null)
//                               //           ? (documentSnapshot["eventTitle"])
//                               //           : "");
//                               //     });
//                               //   },
//                               //   icon: const Icon(
//                               //     Icons.select_all,
//                               //     color: Colors.green,
//                               //   ),
//                               // ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                     // Card(
//                     //  elevation: 4,
//                     //  child: ListTile(
//                     //    // leading: Text(DateFormat.yMd().format(date)),
//                     //    leading: Text((documentSnapshot != null)
//                     //        ? (documentSnapshot["todoDate"])
//                     //        : ""),
//                     //    title: Text((documentSnapshot != null)
//                     //        ? (documentSnapshot["todoTitle"])
//                     //        : ""),
//                     //    subtitle: Text((documentSnapshot != null)
//                     //        ? ((documentSnapshot["todoDesc"] != null)
//                     //            ? documentSnapshot["todoDesc"]
//                     //            : "")
//                     //        : ""),
//                     //    trailing: IconButton(
//                     //      icon: const Icon(Icons.delete),
//                     //      color: Colors.red,
//                     //      onPressed: () {
//                     //        setState(() {
//                     //          //todos.removeAt(index);
//                     //          deleteTodo((documentSnapshot != null)
//                     //              ? (documentSnapshot["todoTitle"])
//                     //              : "");
//                     //        });
//                     //      },
//                     //    ),
//                     //  ),
//                     //   );
//                   },
//                 );
//               }
//               return const Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     Colors.red,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),

//       // const Center(
//       //   child: Text('Events Screen'),
//       // ),

//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: Colors.green,
//       //   child: const Icon(Icons.add),
//       //   onPressed: () {
//       //     showDialog(
//       //       context: context,
//       //       builder: (BuildContext context) {
//       //         return AlertDialog(
//       //           scrollable: true,
//       //           shape: RoundedRectangleBorder(
//       //               borderRadius: BorderRadius.circular(10)),
//       //           title: const Text("Add Event"),
//       //           content: Container(
//       //             width: MediaQuery.of(context).size.width * 0.8,
//       //             height: MediaQuery.of(context).size.height * 0.33,
//       //             child: Column(
//       //               children: [
//       //                 TextField(
//       //                   decoration: const InputDecoration(
//       //                     border: OutlineInputBorder(),
//       //                     hintText: 'Enter Event Name',
//       //                   ),
//       //                   onChanged: (String value) {
//       //                     eventName = value;
//       //                   },
//       //                 ),
//       //                 const SizedBox(height: 10),
//       //                 TextField(
//       //                   decoration: const InputDecoration(
//       //                     border: OutlineInputBorder(),
//       //                     hintText: 'Event Place and Decription',
//       //                   ),
//       //                   onChanged: (String value) {
//       //                     eventDesc = value;
//       //                   },
//       //                 ),
//       //                 const SizedBox(height: 10),
//       //                 TextField(
//       //                   decoration: const InputDecoration(
//       //                     border: OutlineInputBorder(),
//       //                     hintText: 'Event Date and Time',
//       //                   ),
//       //                   onChanged: (String value) {
//       //                     eventDate = value;
//       //                   },
//       //                 ),
//       //                 const SizedBox(height: 10),
//       //                 DropdownButton<String>(
//       //                   value: dropdownValue,
//       //                   icon: const Icon(Icons.arrow_downward),
//       //                   elevation: 16,
//       //                   style: const TextStyle(color: Colors.white),
//       //                   underline: Container(
//       //                     height: 2,
//       //                     color: Colors.white,
//       //                   ),
//       //                   onChanged: (String? newValue) {
//       //                     setState(() {
//       //                       dropdownValue = newValue!;
//       //                     });
//       //                   },
//       //                   items: <String>['Free', 'Paid']
//       //                       .map<DropdownMenuItem<String>>((String value) {
//       //                     return DropdownMenuItem<String>(
//       //                       value: value,
//       //                       child: Text(value),
//       //                     );
//       //                   }).toList(),
//       //                 ),

//       //                 // Row(
//       //                 //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //                 //   children: [
//       //                 //     const Text('Paid'),
//       //                 //     Radio<SingingCharacter>(
//       //                 //       value: SingingCharacter.paid,
//       //                 //       groupValue: _character,
//       //                 //       onChanged: (SingingCharacter? value) {
//       //                 //         setState(() {
//       //                 //           _character = value;
//       //                 //         });
//       //                 //       },
//       //                 //     ),
//       //                 //     const Text('Unpaid'),
//       //                 //     Radio<SingingCharacter>(
//       //                 //       value: SingingCharacter.unpaid,
//       //                 //       groupValue: _character,
//       //                 //       onChanged: (SingingCharacter? value) {
//       //                 //         setState(() {
//       //                 //           _character = value;
//       //                 //         });
//       //                 //       },
//       //                 //     ),
//       //                 //   ],
//       //                 // ),
//       //               ],
//       //             ),
//       //           ),
//       //           actions: <Widget>[
//       //             TextButton(
//       //               onPressed: () {
//       //                 setState(() {
//       //                   createToDo();
//       //                   //todos.add(title);
//       //                   null;
//       //                 });
//       //                 Navigator.of(context).pop();
//       //               },
//       //               child: const Text(
//       //                 "Add",
//       //                 style: TextStyle(fontWeight: FontWeight.bold),
//       //               ),
//       //             )
//       //           ],
//       //         );
//       //       },
//       //     );
//       //   },
//       // ),
//     );
//   }
// }
