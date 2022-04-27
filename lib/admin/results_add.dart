import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import 'event_desciption.dart';

enum SingingCharacter { paid, unpaid }

class ResultAdd extends StatefulWidget {
  const ResultAdd({Key? key}) : super(key: key);

  @override
  State<ResultAdd> createState() => _ResultAddState();
}

class _ResultAddState extends State<ResultAdd> {
  // SingingCharacter? _character = SingingCharacter.paid;
  bool isLoading = false;
  // String dropdownValue = 'Free';

  String eventTitle = '';

  String eventWinner = '';

  createToDo() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("results").doc(eventTitle);

    Map<String, Object> addEvents = {
      "eventTitle": eventTitle,

      "eventWinner": eventWinner,

      // date.toString()
    };

    documentReference
        .set(addEvents)
        .whenComplete(() => print("Data stored successfully"));
  }

  deleteTodo(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("results").doc(item);

    documentReference
        .delete()
        .whenComplete(() => print("deleted successfully"));
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
          "Result Screen",
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Event Result: ',
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('results').snapshots(),
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
                        onTap: () {},
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
                                          ? ('Winner Name: ' +
                                              documentSnapshot["eventWinner"])
                                          : ""),
                                    ),
                                  ],
                                ),
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
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Event Name',
                        ),
                        onChanged: (String value) {
                          eventTitle = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name of Winner:',
                        ),
                        onChanged: (String value) {
                          eventWinner = value;
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
                      });

                      // setState(() {

                      //   // createToDo();
                      //   // //todos.add(title);
                      //   // null;
                      // });
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
