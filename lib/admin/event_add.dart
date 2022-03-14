import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'event_desciption.dart';

class EventAdd extends StatefulWidget {
  const EventAdd({Key? key}) : super(key: key);

  @override
  State<EventAdd> createState() => _EventAddState();
}

class _EventAddState extends State<EventAdd> {
  String eventName = '';
  String eventDesc = '';
  String eventDate = '';
  String eventWinner = 'Yet to be declared';
  late List registeredUsers = [];

  createToDo() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Tasks").doc(eventName);

    Map<String, Object> addEvents = {
      "eventTitle": eventName,
      "eventDesc": eventDesc,
      "eventDate": eventDate,
      "eventWinner": eventWinner,
      "registeredUsers": registeredUsers,
      // date.toString()
    };

    documentReference
        .set(addEvents)
        .whenComplete(() => print("Data stored successfully"));
  }

  deleteTodo(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Tasks").doc(item);

    documentReference
        .delete()
        .whenComplete(() => print("deleted successfully"));
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Description(
                              title: documentSnapshot!['eventTitle'],
                              description: documentSnapshot['eventDesc'],
                            ),
                          ),
                        );
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
                                          ? (documentSnapshot["eventTitle"])
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
                                ],
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
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      //todos.removeAt(index);
                                      deleteTodo((documentSnapshot != null)
                                          ? (documentSnapshot["eventTitle"])
                                          : "");
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: const Text("Add Event"),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Event Name',
                        ),
                        onChanged: (String value) {
                          eventName = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Event Place and Decription',
                        ),
                        onChanged: (String value) {
                          eventDesc = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Event Date and Time',
                        ),
                        onChanged: (String value) {
                          eventDate = value;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        createToDo();
                        //todos.add(title);
                        null;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
